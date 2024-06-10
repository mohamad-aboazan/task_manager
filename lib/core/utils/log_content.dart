import 'package:task_manager_app/core/utils/date_converter.dart';

abstract class LogContent {
  static final Map<TaskLogTypes, String> _content = {
    TaskLogTypes.taskCreated: "You have created this task at {{timer}}",
    TaskLogTypes.taskUpdated: "You have updated this task at {{timer}}",
    TaskLogTypes.commentAdded: "You have added task comment at {{timer}}",
    TaskLogTypes.commentUpdated: "You have updated task comment at {{timer}}",
    TaskLogTypes.commentDeleted: "You have deleted task comment at {{timer}}",
    TaskLogTypes.startTimer: "You have started timer at ",
    TaskLogTypes.stopTimer: "You have stoped timer at ",
    TaskLogTypes.changeStatus: "You have change status task to {{status}} at {{timer}}",
  };
  static String contentGenerator({required TaskLogTypes taskLogType, required Map<String, String> variables}) {
    variables["timer"] = DateConverter.formatHumanReadableDateTime(DateTime.now());
    print(variables);
    var content = _content[taskLogType]!;
    for (var i = 0; i < variables.keys.length; i++) {
      content = content.replaceAll("{{${variables.keys.toList()[i]}}}", variables[variables.keys.toList()[i]]!);
    }
    return content;
  }
}

enum TaskLogTypes { taskUpdated, taskCreated, commentUpdated, commentAdded, commentDeleted, startTimer, stopTimer, changeStatus }
