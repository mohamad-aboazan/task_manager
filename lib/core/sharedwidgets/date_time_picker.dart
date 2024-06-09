import 'package:flutter/material.dart';
import 'package:task_manager_app/core/utils/date_converter.dart';

class AppDateTimePicker {
  static Future<String> show(BuildContext context) async {
    return await showDatePicker(context: context, firstDate: DateTime.now(), initialDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365))).then((e) async {
      var time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (e == null || time == null) return '';
      final DateTime dateTime = DateTime(e.year, e.month, e.day, time.hour, time.minute);
      return DateConverter.formatHumanReadableDateTime(dateTime);
    });
  }
}
