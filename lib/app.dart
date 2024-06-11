import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/home/home_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/welcome/welcome_screen.dart';

/// The root widget of the application.
///
/// This widget initializes the application and manages its lifecycle.
/// It fetches the list of projects during initialization and configures the theme.

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    await context.read<ProjectBloc>().getProjects();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      buildWhen: (previous, current) => current is GetProjectsState,
      builder: (context, projectState) {
        if (projectState is GetProjectsState) {
          if (projectState.baseResponse.status == Status.success) {
            FlutterNativeSplash.remove();
            return BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Task Manager'.tr(),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: context.read<SettingsBloc>().themeData,
                  home: projectState.baseResponse.data!.isNotEmpty ? const HomeScreen() : const WelcomeScreen(),
                );
              },
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
