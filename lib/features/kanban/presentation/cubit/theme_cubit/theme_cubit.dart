import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/core/entities/base_state.dart';

part "theme_state.dart";

class ThemeBloc extends Cubit<ThemeState> {
  ThemeData? themeData;
  ThemeBloc() : super(InitialState());

  void changeTheme({Color? color, Brightness? brightness}) async {
    themeData = getThemeData(color: color, brightness: brightness);
    emit(ChangeThemeState(baseResponse: BaseResponse.success(themeData)));
  }

  init() {
    themeData = getThemeData();
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
