///======================================================================================================
/// This file defines the different states used in the ThemeBloc for managing theme changes.
///
/// The `ThemeState` class is an abstract base class representing the different states
/// that the theme can be in. There are two concrete implementations:
///
/// 1. `InitialState` - Represents the initial state of the theme, used for setting
///    default values or initial setup.
/// 2. `ChangeThemeState` - Represents the state when the theme changes. This class
///    contains a `BaseResponse` property which holds the response details of the
///    theme change action.
///======================================================================================================

part of 'settings_cubit.dart';

abstract class SettingsState {}

class InitialState extends SettingsState {}

class ChangeThemeState extends SettingsState {
  BaseResponse baseResponse;
  ChangeThemeState({required this.baseResponse});
}
