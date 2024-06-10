import 'package:hive/hive.dart';
import 'package:task_manager_app/core/utils/log_content.dart';
import 'package:task_manager_app/features/kanban/data/datasources/local/task_log_local_data_source.dart';
import 'package:task_manager_app/features/kanban/domain/repository/task_log_repository.dart';

class TaskLogRepositoryImp implements TaskLogRepository {
  final TaskLogLocalDataSource taskLogLocalDataSource;

  TaskLogRepositoryImp({required this.taskLogLocalDataSource});

  @override
  Future<void> newTaskLog(String taskId, TaskLogTypes taskLogType) async {
    return await taskLogLocalDataSource.newTaskLog(taskId, taskLogType);
  }

  @override
  Future<Map<dynamic, List<String>>> getTasksLogs() async {
    final box = await Hive.openBox<List<String>>('taskHistories');
    print("inited");
    return box.toMap();
  }
}
