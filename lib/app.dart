import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/home/home_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/welcome/welcome_screen.dart';

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
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return MaterialApp(
                  title: 'Task Manager',
                  theme: context.read<ThemeBloc>().themeData,
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
