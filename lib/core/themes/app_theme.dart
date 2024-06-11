import 'package:flutter/material.dart';

abstract class AppTheme {
  ///======================================================================================================
  // Helper method to generate ThemeData based on provided color and brightness.
  ///======================================================================================================
  static ThemeData generateThemeData({Color? color, Brightness? brightness}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color ?? Colors.deepPurple.shade900, // Default seed color if none provided
        brightness: brightness ?? Brightness.dark, // Default to dark brightness if none provided
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set button shape with rounded corners
          )),
        ),
      ),
    );
  }
}
