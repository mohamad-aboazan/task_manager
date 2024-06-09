import 'package:task_manager_app/core/services/api_service.dart';
import 'package:task_manager_app/core/utils/endpoints.dart';
import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';

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
  Future<List<Project>> getProjects() {
    throw UnimplementedError();
  }
}
