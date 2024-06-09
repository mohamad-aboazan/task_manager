import 'package:task_manager_app/features/kanban/data/dto/update_task_dto.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

class UpdateTaskUsecase {
  final TaskRepository repository;

  UpdateTaskUsecase({required this.repository});

  Future execute({required String id, required UpdateTaskDto updateTaskDto}) async {
    return await repository.updateTask(id, updateTaskDto);
  }
}
