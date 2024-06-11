import 'package:task_manager_app/core/utils/date_converter.dart';

///======================================================================================================
/// Provides methods for generating log content based on predefined templates.
///======================================================================================================

abstract class LogContent {
  /// Map containing predefined content templates for different log types.
  static final Map<TaskLogTypes, String> _content = {
    TaskLogTypes.taskCreated: "You have created this task at {{timer}}",
    TaskLogTypes.taskUpdated: "You have updated this task at {{timer}}",
    TaskLogTypes.commentAdded: "You have added task comment at {{timer}}",
    TaskLogTypes.commentUpdated: "You have updated task comment at {{timer}}",
    TaskLogTypes.commentDeleted: "You have deleted task comment at {{timer}}",
    TaskLogTypes.startTimer: "You have started timer at ",
    TaskLogTypes.stopTimer: "You have stopped timer at ",
    TaskLogTypes.changeStatus: "You have changed status task to {{status}} at {{timer}}",
  };

  /// Generates log content based on the specified task log type and variables.
  ///
  /// The method replaces placeholders in the content template with actual values from the provided variables.
  /// Returns the generated log content as a [String].
  ///
  static String contentGenerator({required TaskLogTypes taskLogType, required Map<String, String> variables}) {
    variables["timer"] = DateConverter.formatHumanReadableDateTime(DateTime.now());
    var content = _content[taskLogType]!;
    for (var i = 0; i < variables.keys.length; i++) {
      content = content.replaceAll("{{${variables.keys.toList()[i]}}}", variables[variables.keys.toList()[i]]!);
    }

    return content;
  }
}

/// Enumeration representing different types of task log events.
enum TaskLogTypes { taskUpdated, taskCreated, commentUpdated, commentAdded, commentDeleted, startTimer, stopTimer, changeStatus }
