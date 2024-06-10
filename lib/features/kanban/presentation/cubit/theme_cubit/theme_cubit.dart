import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/entities/base_state.dart';

part "theme_state.dart";

class ThemeBloc extends Cubit<ThemeState> {
  final SharedPreferences _sharedPreferences;
  ThemeData? themeData;
  String? themeMode = "";
  ThemeBloc(this._sharedPreferences) : super(InitialState()) {
    themeMode = _sharedPreferences.getString("themeMode");
    if (themeMode != null) {
      if (themeMode == "dark") {
        themeData = getThemeData(brightness: Brightness.dark);
      } else {
        themeData = getThemeData(brightness: Brightness.light);
      }
    } else {
      themeMode = "dark";
      themeData = getThemeData();
    }
  }

  void changeTheme({Color? color, Brightness? brightness}) async {
    if (brightness != null) {
      if (brightness == Brightness.dark) {
        themeMode = "dark";
        await _sharedPreferences.setString("themeMode", "dark");
      } else {
        themeMode = "light";
        await _sharedPreferences.setString("themeMode", "light");
      }
    }
    themeData = getThemeData(color: color, brightness: themeMode == "dark" ? Brightness.dark : Brightness.light);

    emit(ChangeThemeState(baseResponse: BaseResponse.success(themeData)));
  }

  getThemeData({Color? color, Brightness? brightness}) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color ?? Colors.deepPurple.shade900,
        brightness: brightness ?? Brightness.dark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
        ),
      ),
    );
  }
}
