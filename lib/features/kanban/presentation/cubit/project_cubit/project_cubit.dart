import 'package:bloc/bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/create_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_project_usecase.dart';
import 'package:task_manager_app/features/kanban/domain/usercase/project_usecases/get_projects_usecase.dart';

part "project_state.dart";

/// ---------------------------------------------------------------------------------------------------------
/// BLoC for managing projects in the Kanban application.
///
/// This BLoC is responsible for handling projects within the Kanban application. It provides functionalities
/// for creating new projects, retrieving projects, and managing the current project.
///
/// Features:
///   - Retrieve projects from the data source.
///   - Create new projects.
///   - Manage the current project.
///
/// Usage:
///   - Instantiate `ProjectBloc` with required use cases.
///   - Use `getProjects` to retrieve projects.
///   - Use `createProject` to create a new project.
///
///---------------------------------------------------------------------------------------------------------
///
class ProjectBloc extends Cubit<ProjectState> {
  final GetProjectsUsecase getProjectsUsecase;
  final GetProjectUsecase getProjectUsecase;
  final CreateProjectUsecase createProjectUsecase;

  Project? currentProject;
  List<Project> projects = [];
  ProjectBloc({required this.createProjectUsecase, required this.getProjectUsecase, required this.getProjectsUsecase}) : super(InitialState());

  Future getProjects() async {
    try {
      emit(GetProjectsState(baseResponse: BaseResponse.loading()));
      projects = await getProjectsUsecase.execute();
      if (projects.isNotEmpty) currentProject = projects.first;
      emit(GetProjectsState(baseResponse: BaseResponse.success(projects)));
    } catch (e) {
      emit(GetProjectsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void createProject(CreateProjectDto createProjectDto) async {
    try {
      emit(CreateProjectState(baseResponse: BaseResponse.loading()));
      Project project = await createProjectUsecase.execute(createProjectDto: createProjectDto);
      currentProject = project;
      projects.add(project);
      emit(CreateProjectState(baseResponse: BaseResponse.success(project)));
    } catch (e) {
      emit(CreateProjectState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
