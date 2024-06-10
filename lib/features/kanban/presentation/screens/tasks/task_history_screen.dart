import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';

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
        title: const Text("Task History"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: taskHistory!.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text(taskHistory?[index] ?? '' , textAlign: TextAlign.center,),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
