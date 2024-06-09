import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

class GetTasksUsecase {
  final TaskRepository repository;

  GetTasksUsecase({required this.repository});

  Future<List<Task>> execute({required String projectId}) async {
    return await repository.getTasks(projectId);
  }
}
