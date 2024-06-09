part of 'project_cubit.dart';

abstract class ProjectState {}

class InitialState extends ProjectState {}

class CreateProjectState extends ProjectState {
  BaseResponse baseResponse;
  CreateProjectState({required this.baseResponse});
}

class GetProjectsState extends ProjectState {
  BaseResponse baseResponse;
  GetProjectsState({required this.baseResponse});
}
