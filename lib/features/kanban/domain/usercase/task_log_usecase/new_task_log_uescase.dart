import 'package:task_manager_app/core/utils/log_content.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_log_repository.dart';

class NewTaskLogUsecase {
  final TaskLogRepository repository;

  NewTaskLogUsecase({required this.repository});

  Future<void> execute({required String taskId, required TaskLogTypes taskLogType}) async {
    return await repository.newTaskLog(taskId, taskLogType);
  }
}
