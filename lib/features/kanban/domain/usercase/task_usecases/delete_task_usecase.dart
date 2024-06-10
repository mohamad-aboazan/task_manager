import 'package:task_manager_app/features/kanban/domain/repository/task_repository.dart';

class DeleteTaskUsecase {
  final TaskRepository repository;

  DeleteTaskUsecase({required this.repository});

  Future execute({required String id}) async {
    return await repository.deleteTask(id);
  }
}
