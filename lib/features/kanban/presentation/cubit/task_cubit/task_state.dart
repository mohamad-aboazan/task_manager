part of 'task_cubit.dart';

abstract class TaskState {}

class InitialState extends TaskState {}

class CreateTaskState extends TaskState {
  BaseResponse baseResponse;
  CreateTaskState({required this.baseResponse});
}

class UpdateTaskState extends TaskState {
  BaseResponse baseResponse;
  UpdateTaskState({required this.baseResponse});
}

class GetTasksState extends TaskState {
  BaseResponse baseResponse;
  GetTasksState({required this.baseResponse});
}

class DeleteTaskState extends TaskState {
  BaseResponse baseResponse;
  DeleteTaskState({required this.baseResponse});
}
