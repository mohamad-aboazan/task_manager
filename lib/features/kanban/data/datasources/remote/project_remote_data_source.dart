import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';

/// =================================================================================================
/// Remote data source for managing projects.
///
/// This data source handles operations related to projects through remote API calls using the `ApiService`.
///
/// Dependencies:
///   - `ApiService`: Service for making API calls.
///   - `Endpoints`: Utility class for defining API endpoints.
///
/// Abstract Methods:
///   - `getProjects`: Fetches all projects from the remote API.
///   - `createProject`: Creates a new project via the remote API.
///   - `getProject`: Fetches a specific project by ID from the remote API.
///
/// Usage:
///   - Implement the `ProjectRemoteDataSource` abstract class with the required methods.
///   - Utilize `ApiService` to make HTTP requests to the appropriate endpoints for project management.
///
/// =================================================================================================

abstract class ProjectRemoteDataSource {
  Future<List<Project>> getProjects();
  Future<Project> createProject(CreateProjectDto createProjectDto);
  Future<Project> getProject(String id);
}

class ProjectRemoteDataSourceImp implements ProjectRemoteDataSource {
  final ApiService apiService;
  ProjectRemoteDataSourceImp({required this.apiService});

  @override
  Future<Project> createProject(CreateProjectDto createProjectDto) async {
    var responseData = await apiService.post(Endpoints.PROJECTS, createProjectDto.toJson());
    Project project = Project.fromJson(responseData);
    return project;
  }

  @override
  Future<Project> getProject(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects() async {
    var responseData = await apiService.get(Endpoints.PROJECTS);
    List<Project> projects = responseData.map((e) => Project.fromJson(e)).toList().cast<Project>();
    projects = projects.where((project) => !(project.isInboxProject ?? false)).toList();
    return projects;
  }
}
