import 'package:bloc/bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/create_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_task_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/get_tasks_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/task_usecases/update_task_usecase.dart';

part "task_state.dart";

class TaskBloc extends Cubit<TaskState> {
  final GetTasksUsecase getTasksUsecase;
  final GetTaskUsecase getTaskUsecase;
  final CreateTaskUsecase createTaskUsecase;
  final UpdateTaskUsecase updateTaskUsecase;

  List<Task> tasks = [];

  TaskBloc({required this.createTaskUsecase, required this.updateTaskUsecase, required this.getTaskUsecase, required this.getTasksUsecase}) : super(InitialState());

  void createTask(CreateTaskDto createTaskDto) async {
    try {
      emit(CreateTaskState(baseResponse: BaseResponse.loading()));
      Task task = await createTaskUsecase.execute(createTaskDto: createTaskDto);
      tasks.add(task);
      emit(CreateTaskState(baseResponse: BaseResponse.success(task)));
    } catch (e) {
      emit(CreateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void updateTask({required String id, required UpdateTaskDto updateTaskDto}) async {
    try {
      _localTaskUpdate(id: id, updateTaskDto: updateTaskDto);
      emit(UpdateTaskState(baseResponse: BaseResponse.success("Updated Localy")));
      Task task = await updateTaskUsecase.execute(id: id, updateTaskDto: updateTaskDto);
      emit(UpdateTaskState(baseResponse: BaseResponse.success(task)));
    } catch (e) {
      emit(UpdateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  _localTaskUpdate({required String id, required UpdateTaskDto updateTaskDto}) {
    var index = tasks.indexWhere((task) => task.id == id);
    tasks[index].content = updateTaskDto.content ?? tasks[index].content;
    tasks[index].description = updateTaskDto.description ?? tasks[index].description;
    tasks[index].due?.datetime = updateTaskDto.dueDatetime ?? tasks[index].due?.datetime;
    tasks[index].labels = updateTaskDto.labels ?? tasks[index].labels;
    tasks[index].priority = updateTaskDto.priority ?? tasks[index].priority;
    tasks[index].duration?.amount = updateTaskDto.duration ?? tasks[index].duration?.amount;
    tasks[index].duration?.unit = updateTaskDto.durationUnit ?? tasks[index].duration?.unit;
    tasks[index].priority = updateTaskDto.priority ?? tasks[index].priority;
  }

  void getTasks(String projectId) async {
    try {
      emit(GetTasksState(baseResponse: BaseResponse.loading()));
      List<Task> tasks = await getTasksUsecase.execute(projectId: projectId);
      this.tasks = tasks;
      emit(GetTasksState(baseResponse: BaseResponse.success(tasks)));
    } catch (e) {
      emit(GetTasksState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
