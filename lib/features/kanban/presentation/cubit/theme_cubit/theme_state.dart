part of 'theme_cubit.dart';

abstract class ThemeState {}

class InitialState extends ThemeState {
}

class ChangeThemeState extends ThemeState {
  BaseResponse baseResponse;
  ChangeThemeState({required this.baseResponse});
}
