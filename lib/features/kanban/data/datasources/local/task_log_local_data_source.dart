import 'package:hive/hive.dart';
import 'package:task_manager_app/core/utils/log_content.dart';

/// =========================================================================================================
/// Local data source for managing task logs.
///
/// This data source handles operations related to task logs in the local database using Hive.
///
/// Dependencies:
///   - `Hive`: Hive library for local database management.
///   - `LogContent`: Utility class for generating log content.
///
/// Abstract Methods:
///   - `newTaskLog`: Adds a new task log to the local database.
///   - `loadTaskHistories`: Loads task histories from the local database.
///   - `saveTaskHistories`: Saves task histories to the local database.
///
/// Usage:
///   - Implement the `TaskLogLocalDataSource` abstract class with the required methods.
///   - Use `Hive` to interact with the local database to manage task logs.
///
///=========================================================================================================

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
