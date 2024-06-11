import 'package:intl/intl.dart';

///======================================================================================================
/// A utility class for date conversions.
///======================================================================================================

abstract class DateConverter {
  /// Formats a [DateTime] object to a string representation.
  static String formatDateTime(DateTime dateTime) {
    final DateFormat outputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS'Z'");
    return outputFormat.format(dateTime.toUtc());
  }

  /// Parses a string to a [DateTime] object.
  static DateTime parseDateTime(String input) {
    final DateFormat inputFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return inputFormat.parse(input);
  }

  /// Parses an ISO string to a [DateTime] object.
  static DateTime parseIsoDateTime(String isoString) {
    return DateTime.parse(isoString);
  }

  /// Formats a [DateTime] object to a human-readable string representation.
  static String formatHumanReadableDateTime(DateTime dateTime) {
    final DateFormat outputFormat = DateFormat("yyyy-MM-dd hh:mm a");
    return outputFormat.format(dateTime.toLocal());
  }
}
