import 'package:task_manager_app/features/kanban/domain/entities/project.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';

class GetProjectUsecase {
  final ProjectRepository repository;

  GetProjectUsecase({required this.repository});

  Future<Project> execute({required String id}) async {
    return await repository.getProject(id);
  }
}
