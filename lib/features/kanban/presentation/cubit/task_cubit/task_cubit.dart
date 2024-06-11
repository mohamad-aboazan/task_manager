import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/services/local_notification_service.dart';
import 'package:task_manager_app/core/utils/hepler_functions.dart';
import 'package:task_manager_app/core/utils/log_content.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_log_usecase/get_task_logs_uescas.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_log_usecase/new_task_log_uescase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/create_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_tasks_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/delete_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/update_task_usecase.dart';

part "task_state.dart";

/// ---------------------------------------------------------------------------------------------------------
/// BLoC for managing tasks in the Kanban application.
///
/// This BLoC is responsible for handling tasks within the Kanban application. It provides functionalities
/// for creating, updating, deleting tasks, as well as retrieving task logs and managing local notifications
/// for task reminders.
///
/// Features:
///   - Create, update, delete tasks.
///   - Retrieve task logs and manage their storage.
///   - Schedule, update, and cancel local notifications for task reminders.
///
/// Dependencies:
///   - `Bloc`: BLoC library for state management.
///   - `BaseResponse`: Entity representing the base response for operations.
///   - `LocalNotificationService`: Service for managing local notifications.
///   - `HelperFunctions`: Utility functions for common operations.
///   - `Task`, `CreateTaskDto`, `UpdateTaskDto`: Entities representing tasks and their data transfer objects.
///   - `GetTasksUsecase`, `CreateTaskUsecase`, `UpdateTaskUsecase`, `DeleteTaskUsecase`: Use cases for task operations.
///   - `NewTaskLogUsecase`, `GetTasksLogsUescas`: Use cases for task log operations.
///
/// Usage:
///   - Instantiate `TaskBloc` with required dependencies.
///   - Use methods like `createTask`, `updateTask`, `deleteTask` to perform task operations.
///   - Access task histories using `getTaskHistories` method.
///   - Manage local notifications for task reminders.
///
///---------------------------------------------------------------------------------------------------------

class TaskBloc extends Cubit<TaskState> {
  final GetTasksUsecase _getTasksUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  final UpdateTaskUsecase _updateTaskUsecase;
  final DeleteTaskUsecase _deleteTaskUsecase;
  final NewTaskLogUsecase _newTaskLogUsecase;
  final GetTasksLogsUescas _getTaskslogsUsecase;
  final LocalNotificationService _localNotificationService;
  List<Task> tasks = [];
  final Map<String, List<String>> _taskHistories = {};
  TaskBloc(this._getTasksUsecase, this._createTaskUsecase, this._updateTaskUsecase, this._deleteTaskUsecase, this._newTaskLogUsecase, this._getTaskslogsUsecase, this._localNotificationService) : super(InitialState()) {
    _getTaskslogsUsecase.execute().then((histories) {
      _taskHistories.addAll(histories.map((key, value) => MapEntry(key.toString(), value)));
    });
  }

  void createTask(CreateTaskDto createTaskDto) async {
    try {
      emit(CreateTaskState(baseResponse: BaseResponse.loading()));
      Task task = await _createTaskUsecase.execute(createTaskDto: createTaskDto);
      tasks.add(task);
      if (createTaskDto.reminder) {
        _scheduleNotification(task);
      }
      emit(CreateTaskState(baseResponse: BaseResponse.success(task)));
      newLog(taskId: task.id ?? '', taskLogType: TaskLogTypes.taskCreated, variables: {});
    } catch (e) {
      emit(CreateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void updateTask({required String id, required UpdateTaskDto updateTaskDto}) async {
    try {
      _localTaskUpdate(id: id, updateTaskDto: updateTaskDto);
      emit(UpdateTaskState(baseResponse: BaseResponse.success("Updated Localy")));
      Task task = await _updateTaskUsecase.execute(id: id, updateTaskDto: updateTaskDto);
      if (updateTaskDto.reminder) {
        _updateScheduleNotification(task);
      }
      emit(UpdateTaskState(baseResponse: BaseResponse.success(task)));
    } catch (e) {
      emit(UpdateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void deleteTask(Task task) async {
    try {
      _localTaskDelete(task);
      emit(DeleteTaskState(baseResponse: BaseResponse.success("Deleted Localy")));
      await _deleteTaskUsecase.execute(id: task.id!);
      _deleteScheduleNotification(task);

      emit(UpdateTaskState(baseResponse: BaseResponse.success(task)));
    } catch (e) {
      emit(UpdateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  _localTaskUpdate({required String id, required UpdateTaskDto updateTaskDto}) {
    var index = tasks.indexWhere((task) => task.id == id);
    // check if status of task has changed
    if (!HelperFunctions.listEquals(tasks[index].labels!, updateTaskDto.labels!)) {
      newLog(taskId: id, taskLogType: TaskLogTypes.changeStatus, variables: {"status": updateTaskDto.labels?.first ?? ''});
    }
    tasks[index].content = updateTaskDto.content ?? tasks[index].content;
    tasks[index].description = updateTaskDto.description ?? tasks[index].description;
    tasks[index].due?.datetime = updateTaskDto.dueDatetime ?? tasks[index].due?.datetime;
    tasks[index].labels = updateTaskDto.labels ?? tasks[index].labels;
    tasks[index].priority = updateTaskDto.priority ?? tasks[index].priority;
    tasks[index].duration?.amount = updateTaskDto.duration ?? tasks[index].duration?.amount;
    tasks[index].duration?.unit = updateTaskDto.durationUnit ?? tasks[index].duration?.unit;
    tasks[index].priority = updateTaskDto.priority ?? tasks[index].priority;
    newLog(taskId: id, taskLogType: TaskLogTypes.taskUpdated, variables: {});
  }

  _localTaskDelete(Task? task) {
    tasks.remove(task);
  }

  void getTasks(String projectId) async {
    try {
      emit(GetTasksState(baseResponse: BaseResponse.loading()));
      List<Task> tasks = await _getTasksUsecase.execute(projectId: projectId);
      this.tasks = tasks;
      emit(GetTasksState(baseResponse: BaseResponse.success(tasks)));
    } catch (e) {
      emit(GetTasksState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void _scheduleNotification(Task task) {
    _localNotificationService.scheduleNotification(
      id: task.getShortId(),
      title: 'Task Reminder'.tr(),
      body: task.content ?? '',
      scheduledDate: DateTime.parse(task.due?.datetime ?? ''),
      payload: task.due?.datetime ?? '',
    );
  }

  void _updateScheduleNotification(Task task) {
    _localNotificationService.cancelNotification(task.getShortId());
    _localNotificationService.scheduleNotification(
      id: task.getShortId(),
      title: 'Task Reminder'.tr(),
      body: task.content ?? '',
      scheduledDate: DateTime.parse(task.due?.datetime ?? ''),
      payload: task.due?.datetime ?? '',
    );
  }

  void _deleteScheduleNotification(Task task) {
    _localNotificationService.cancelNotification(task.getShortId());
  }

  void newLog({
    required String taskId,
    required TaskLogTypes taskLogType,
    required Map<String, String> variables,
  }) async {
    if (_taskHistories[taskId] == null) {
      _taskHistories[taskId] = [LogContent.contentGenerator(taskLogType: taskLogType, variables: variables)];
    } else {
      _taskHistories[taskId]?.add(LogContent.contentGenerator(taskLogType: taskLogType, variables: variables));
    }
    await _newTaskLogUsecase.execute(taskId: taskId, taskLogType: taskLogType); // Save histories to Hive
  }

  List<String>? getTaskHistories(String taskId) {
    return _taskHistories[taskId];
  }
}
