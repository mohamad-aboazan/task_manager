import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';

class TaskPopupMenuButton extends StatelessWidget {
  Task task;
  TaskPopupMenuButton({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert_rounded),
      onSelected: (value) {
        // Handle menu item selection
        switch (value) {
          case 0:
            print('Option 1 selected');
            break;
          case 1:
            print('Option 2 selected');
            break;
          case 2:
            print('Option 3 selected');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: Text('History'),
        ),
        PopupMenuItem<int>(
          value: 2,
          onTap: () {
            context.read<TaskBloc>().deleteTask(task);
            AppRoutes.pop(context);
          },
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
