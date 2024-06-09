import 'package:task_manager_app/features/kanban/data/dto/create_project_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/project_repository.dart';

class CreateProjectUsecase {
  final ProjectRepository repository;

  CreateProjectUsecase({required this.repository});

  Future execute({required CreateProjectDto createProjectDto}) async {
    return await repository.createProject(createProjectDto);
  }
}
