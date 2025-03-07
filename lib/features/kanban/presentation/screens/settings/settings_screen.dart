import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/utils/constant.dart';
import 'package:task_manager_app/core/utils/todoist_colors.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/settings_cubit/settings_cubit.dart';

///======================================================================================================
/// Screen for managing application settings.
/// This screen allows users to manage application settings, such as theme mode.
///======================================================================================================

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  @override
  void initState() {
    _isDarkMode = context.read<SettingsBloc>().themeMode == "dark";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".tr()),
      ),
      body: Container(
        margin: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.read<SettingsBloc>().changeTheme(
                    color: Color(
                      TodoistColors.getColorCode(context.read<ProjectBloc>().currentProject?.color ?? ''),
                    ),
                    brightness: _isDarkMode ? Brightness.light : Brightness.dark);
                _isDarkMode = !_isDarkMode;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Theme Mode".tr(),
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
            const Divider(height: 30),
            Text(
              "Language".tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale(Constant.de));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Switch to Germany'.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.setLocale(const Locale(Constant.en));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Switch to English'.tr(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
