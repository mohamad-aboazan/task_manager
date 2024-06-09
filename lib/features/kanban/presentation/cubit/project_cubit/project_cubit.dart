import 'package:bloc/bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/create_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_projects_usecase.dart';

part "project_state.dart";

class ProjectBloc extends Cubit<ProjectState> {
  final GetProjectsUsecase getProjectsUsecase;
  final GetProjectUsecase getProjectUsecase;
  final CreateProjectUsecase createProjectUsecase;

  Project? currentProject;

  ProjectBloc({required this.createProjectUsecase, required this.getProjectUsecase, required this.getProjectsUsecase}) : super(InitialState());

  void getProjects() async {
    try {
      emit(GetProjectsState(baseResponse: BaseResponse.loading()));
      await Future.delayed(const Duration(seconds: 2));
      emit(GetProjectsState(baseResponse: BaseResponse.success(1)));
    } catch (e) {
      emit(GetProjectsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void createProject(CreateProjectDto createProjectDto) async {
    try {
      emit(CreateProjectState(baseResponse: BaseResponse.loading()));
      Project project = await createProjectUsecase.execute(createProjectDto: createProjectDto);
      currentProject = project;
      emit(CreateProjectState(baseResponse: BaseResponse.success(project)));
    } catch (e) {
      emit(CreateProjectState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
