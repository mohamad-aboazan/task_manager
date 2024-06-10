import 'package:task_manager_app/features/kanban/domain/repository/task_log_repository.dart';

class GetTasksLogsUescas {
  final TaskLogRepository repository;

  GetTasksLogsUescas({required this.repository});

  Future<Map<dynamic, List<String>>> execute() async {
    return await repository.getTasksLogs();
  }
}
