import 'package:intl/intl.dart';

abstract class DateConverter {
  static String formatDateTime(DateTime dateTime) {
    DateFormat outputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS'Z'");
    return outputFormat.format(dateTime.toUtc());
  }

  static DateTime parseDateTime(String input) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return inputFormat.parse(input);
  }

  static DateTime parseIsoDateTime(String isoString) {
    return DateTime.parse(isoString);
  }

  static String formatHumanReadableDateTime(DateTime dateTime) {
    DateFormat outputFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return outputFormat.format(dateTime.toLocal());
  }
}
