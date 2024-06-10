import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/utils/todoist_colors.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme_cubit/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  @override
  void initState() {
    _isDarkMode = context.read<ThemeBloc>().themeMode == "dark";
    print(_isDarkMode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                context.read<ThemeBloc>().changeTheme(
                    color: Color(
                      TodoistColors.getColorCode(context.read<ProjectBloc>().currentProject?.color ?? ''),
                    ),
                    brightness: _isDarkMode ? Brightness.light : Brightness.dark);
                _isDarkMode = !_isDarkMode;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Theme Mode",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    _isDarkMode
                        ? Icon(
                            Icons.wb_sunny,
                            color: Colors.yellow,
                            key: ValueKey<bool>(_isDarkMode),
                            size: 30,
                          )
                        : Icon(
                            Icons.nights_stay,
                            key: ValueKey<bool>(_isDarkMode),
                            size: 30,
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
