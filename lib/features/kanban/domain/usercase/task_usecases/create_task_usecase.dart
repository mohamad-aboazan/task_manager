import 'package:task_manager_app/features/kanban/data/dto/create_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

class CreateTaskUsecase {
  final TaskRepository repository;

  CreateTaskUsecase({required this.repository});

  Future execute({required CreateTaskDto createTaskDto}) async {
    return await repository.createTask(createTaskDto);
  }
}
