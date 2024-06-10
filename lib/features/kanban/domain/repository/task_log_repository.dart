import 'package:task_manager_app/core/utils/log_content.dart';

abstract class TaskLogRepository {
  Future<void> newTaskLog(String taskId, TaskLogTypes taskLogType);
  Future<Map<dynamic, List<String>>> getTasksLogs();
}
