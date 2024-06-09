import 'package:task_manager_app/features/kanban/domain/entities/project.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';

class GetProjectsUsecase {
  final ProjectRepository repository;

  GetProjectsUsecase({required this.repository});

  Future<List<Project>> execute() async {
    return await repository.getProjects();
  }
}
