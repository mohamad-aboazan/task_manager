import 'package:flutter/material.dart';

///======================================================================================================
/// A utility class to simplify navigation operations in Flutter applications.
///
/// This class provides static methods for common navigation tasks, such as pushing,
/// replacing, and removing routes from the navigator stack. By encapsulating these
/// operations in a single class, it reduces code redundancy and improves readability
/// when performing navigation within the application.
///
/// Note : For larger projects, it's recommended to use named routes (Go_Route) and route constants
/// to manage navigation. However, for smaller projects or quick prototyping, direct navigation
/// methods provided by this class can be used.
///======================================================================================================


class AppRoutes {
  static push(context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ));
  }

  static pushReplacement(context, Widget screen) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ));
  }

  static pop(context) {
    Navigator.pop(context);
  }

  static pushAndRemoveUntil(context, Widget screen) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return screen;
      },
    ), (route) => false);
  }
}
