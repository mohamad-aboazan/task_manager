import 'package:hive/hive.dart';
import 'package:task_manager_app/core/utils/log_content.dart';

abstract class TaskLogLocalDataSource {
  Future<void> newTaskLog(String taskId, TaskLogTypes taskLogType);
  Future<Map<dynamic, List<String>>> loadTaskHistories();
  Future<void> saveTaskHistories(Map<dynamic, List<String>> taskHistories);
}

class TaskLogLocalDataSourceImp implements TaskLogLocalDataSource {
  static const String _boxName = 'taskHistories';

  @override
  Future<void> newTaskLog(String taskId, TaskLogTypes taskLogType) async {
    final box = await Hive.openBox<List<String>>(_boxName);
    final logContent = LogContent.contentGenerator(taskLogType: taskLogType, variables: {});
    if (box.containsKey(taskId)) {
      final List<String> logs = box.get(taskId)!;
      logs.add(logContent);
      await box.put(taskId, logs);
    } else {
      await box.put(taskId, [logContent]);
    }
  }

  @override
  Future<Map<dynamic, List<String>>> loadTaskHistories() async {
    final box = await Hive.openBox<List<String>>(_boxName);
    return box.toMap();
  }

  @override
  Future<void> saveTaskHistories(Map<dynamic, List<String>> taskHistories) async {
    final box = await Hive.openBox<List<String>>(_boxName);
    await box.putAll(taskHistories);
  }
}
