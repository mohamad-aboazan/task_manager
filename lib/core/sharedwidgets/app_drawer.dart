import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/core/utils/todoist_colors.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/project_cubit/project_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/theme_cubit/theme_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/home/home_screen.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/projects/create_project.screen.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/settings/settings_screen.dart';

///======================================================================================================
/// This widget represents the application drawer, offering navigation options and displaying projects.
/// It also includes options to add a new project and access settings.
///======================================================================================================

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectBloc projectBloc = context.read<ProjectBloc>();
    TaskBloc taskBloc = context.read<TaskBloc>();
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Your Projects", style: Theme.of(context).textTheme.titleLarge),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: projectBloc.projects.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () {
                            if (projectBloc.projects[index].id != projectBloc.currentProject?.id) {
                              taskBloc.tasks.clear();
                              projectBloc.currentProject = projectBloc.projects[index];
                              context.read<ThemeBloc>().changeTheme(color: Color(TodoistColors.getColorCode(projectBloc.projects[index].color ?? '')));
                              AppRoutes.pushAndRemoveUntil(context, const HomeScreen());
                            } else {
                              AppRoutes.pop(context);
                            }
                          },
                          title: Text(projectBloc.projects[index].name.toString()),
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(TodoistColors.getColorCode(projectBloc.projects[index].color ?? '')),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
            const Divider(),
            ListTile(
              onTap: () {
                AppRoutes.push(context, const CreateProjectScreen());
              },
              title: const Text("Add New Project"),
              leading: const Icon(Icons.add),
            ),
            ListTile(
              title: const Text("Settings"),
              onTap: () {
                AppRoutes.push(context, const SettingsScreen());
              },
              leading: const Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }
}
