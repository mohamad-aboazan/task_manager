import 'package:flutter/material.dart';

enum SnackBarStatus {
  success,
  error,
  warning,
}

class AppSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    required SnackBarStatus status,
  }) {
    final Color backgroundColor;
    switch (status) {
      case SnackBarStatus.success:
        backgroundColor = Colors.green.shade700;
        break;
      case SnackBarStatus.error:
        backgroundColor = Colors.red.shade900;
        break;
      case SnackBarStatus.warning:
        backgroundColor = Colors.amber;
        break;    
      default:
        backgroundColor = Colors.blue;
    }

    final snackBar = SnackBar(
      content: Center(
          child: Text(
        message,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
