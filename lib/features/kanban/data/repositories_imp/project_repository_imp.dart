import 'package:task_manager_app/core/network/network_info.dart';
import 'package:task_manager_app/features/kanban/data/datasources/remote/project_remote_data_source.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';

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
