import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/themes/app_theme.dart';

part "theme_state.dart";

///======================================================================================================
/// This file defines the `ThemeBloc` class, which is responsible for managing
/// the application's theme state.
///
/// The `ThemeBloc` class extends `Cubit<ThemeState>` and provides methods for
/// changing the theme, updating SharedPreferences, and emitting new states
/// based on theme changes.
///======================================================================================================

class ThemeBloc extends Cubit<ThemeState> {
  final SharedPreferences _sharedPreferences;
  ThemeData? themeData;
  String? themeMode = "";

  // Constructor: Initializes ThemeBloc with SharedPreferences and sets the initial state.
  ThemeBloc(this._sharedPreferences) : super(InitialState()) {
    themeMode = _sharedPreferences.getString("themeMode");
    if (themeMode != null) {
      if (themeMode == "dark") {
        themeData = AppTheme.generateThemeData(brightness: Brightness.dark); // Generate dark theme data
      } else {
        themeData = AppTheme.generateThemeData(brightness: Brightness.light); // Generate light theme data
      }
    } else {
      themeMode = "dark";
      themeData = AppTheme.generateThemeData(); // Default to dark theme data
    }
  }

  // Method to change the theme, updating SharedPreferences and emitting a new state.
  void changeTheme({Color? color, Brightness? brightness}) async {
    if (brightness != null) {
      if (brightness == Brightness.dark) {
        themeMode = "dark";
        await _sharedPreferences.setString("themeMode", "dark"); // Save dark mode to SharedPreferences
      } else {
        themeMode = "light";
        await _sharedPreferences.setString("themeMode", "light"); // Save light mode to SharedPreferences
      }
    }
    themeData = AppTheme.generateThemeData(color: color, brightness: themeMode == "dark" ? Brightness.dark : Brightness.light // Determine brightness based on themeMode
        );

    emit(ChangeThemeState(baseResponse: BaseResponse.success(themeData))); // Emit new state with updated theme data
  }
}
