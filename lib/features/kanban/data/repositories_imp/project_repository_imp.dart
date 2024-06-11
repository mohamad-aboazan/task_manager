import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/project_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';

/// =================================================================================================
/// Project Repository Implementation
///
/// This class implements the `ProjectRepository` interface, providing methods to interact with
/// projects in the Kanban application. It manages communication between the domain layer and
/// remote data source for project-related operations.
///
/// Dependencies:
///   - `NetworkInfo`: Service for checking network connectivity.
///   - `ProjectRemoteDataSource`: Data source for remote project operations.
///
/// Usage:
///   - Use instances of this class to perform operations related to projects, such as creating,
///     fetching, and getting projects.
///
/// =================================================================================================

class ProjectRepositoryImpl implements ProjectRepository {
  final NetworkInfo networkInfo;
  final ProjectRemoteDataSource projectRemoteDataSource;

  ProjectRepositoryImpl({required this.projectRemoteDataSource, required this.networkInfo});

  @override
  Future<Project> createProject(CreateProjectDto createProjectDto) async {
    return await projectRemoteDataSource.createProject(createProjectDto);
  }

  @override
  Future<Project> getProject(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getProjects() async {
    return await projectRemoteDataSource.getProjects();
  }
}
