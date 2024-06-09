import 'package:flutter/material.dart';

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
