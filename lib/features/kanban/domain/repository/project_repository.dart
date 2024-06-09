import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';

abstract class ProjectRepository {
  Future<List<Project>> getProjects();
  Future<Project> getProject(String id);
  Future<void> createProject(CreateProjectDto createProjectDto);
}
