import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';

///======================================================================================================
/// Screen for displaying the history of a task.
///
/// This screen displays the history of a task, including all the actions and events related to the task.
/// The history is fetched from the task bloc using the task's ID and displayed in reverse chronological order.
///
/// Parameters:
///   - `context`: The build context used to access dependencies.
///   - `task`: The task for which the history is being displayed.
///======================================================================================================

class TaskHistoryScreen extends StatefulWidget {
  Task task;
  TaskHistoryScreen({super.key, required this.task});

  @override
  State<TaskHistoryScreen> createState() => _TaskHistoryScreenState();
}

class _TaskHistoryScreenState extends State<TaskHistoryScreen> {
  List<String>? taskHistory = [];
  @override
  void initState() {
    taskHistory = context.read<TaskBloc>().getTaskHistories(widget.task.id!) ?? [];
    taskHistory = taskHistory?.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task History".tr()),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: taskHistory!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(
                taskHistory?[index] ?? '',
                textAlign: TextAlign.center,
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
