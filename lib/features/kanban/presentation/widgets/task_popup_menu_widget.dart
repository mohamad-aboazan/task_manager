import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/tasks/task_history_screen.dart';

///======================================================================================================
/// Widget for displaying a popup menu button for task-related actions.
///======================================================================================================

class TaskPopupMenuButton extends StatelessWidget {
  Task task;
  TaskPopupMenuButton({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert_rounded),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          onTap: () {
            AppRoutes.push(context, TaskHistoryScreen(task: task));
          },
          child: Text('History'.tr()),
        ),
        PopupMenuItem<int>(
          value: 2,
          onTap: () {
            context.read<TaskBloc>().deleteTask(task);
            AppRoutes.pop(context);
          },
          child: Text(
            'Delete'.tr(),
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
