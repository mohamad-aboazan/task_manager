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

  void updateTask(String id, UpdateTaskDto createTaskDto) async {
    try {
      emit(UpdateTaskState(baseResponse: BaseResponse.success("Updated Localy")));
      Task task = await updateTaskUsecase.execute(id: id, updateTaskDto: createTaskDto);
      emit(UpdateTaskState(baseResponse: BaseResponse.success(task)));
    } catch (e) {
      emit(UpdateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void getTasks(String projectId) async {
    try {
      emit(CreateTaskState(baseResponse: BaseResponse.loading()));
      List<Task> tasks = await getTasksUsecase.execute(projectId: projectId);
      this.tasks = tasks;
      emit(CreateTaskState(baseResponse: BaseResponse.success(tasks)));
    } catch (e) {
      emit(CreateTaskState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
