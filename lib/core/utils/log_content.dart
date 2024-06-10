import 'package:task_manager_app/core/utils/date_converter.dart';

abstract class LogContent {
  static final Map<TaskLogTypes, String> _content = {
    TaskLogTypes.taskCreated: "You have created this task at ",
    TaskLogTypes.taskUpdated: "You have updated this task at ",
    TaskLogTypes.commentAdded: "You have added task comment at ",
    TaskLogTypes.commentUpdated: "You have updated task comment at ",
    TaskLogTypes.commentDeleted: "You have deleted task comment at ",
    TaskLogTypes.startTimer: "You have started timer at ",
    TaskLogTypes.stopTimer: "You have stoped timer at ",
  };
  static String contentGenerator(TaskLogTypes taskLogType) {
    return _content[taskLogType]! + DateConverter.formatHumanReadableDateTime(DateTime.now());
  }
}

enum TaskLogTypes { taskUpdated, taskCreated, commentUpdated, commentAdded, commentDeleted, startTimer, stopTimer }
