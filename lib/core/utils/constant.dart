import 'package:flutter/material.dart';

abstract class Constant {
  static const String en = "en";
  static const String de = "de";
  static List<Widget> priorityIcons = const [
    Icon(
      Icons.keyboard_double_arrow_up_rounded,
      color: Colors.greenAccent,
    ),
    Icon(
      Icons.keyboard_arrow_up_rounded,
      color: Colors.lightGreenAccent,
    ),
    Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Colors.amber,
    ),
    Icon(
      Icons.keyboard_double_arrow_down_rounded,
      color: Colors.red,
    )
  ];
}
