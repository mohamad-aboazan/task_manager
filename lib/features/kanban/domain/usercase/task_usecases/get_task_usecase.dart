import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

class GetTaskUsecase {
  final TaskRepository repository;

  GetTaskUsecase({required this.repository});

  Future<Task> execute({required String id}) async {
    return await repository.getTask(id);
  }
}
