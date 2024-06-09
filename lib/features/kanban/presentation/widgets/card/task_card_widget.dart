import 'package:flutter/material.dart';
import 'package:task_manager_app/core/route/route.dart';
import 'package:task_manager_app/features/kanban/domain/entities/task.dart';
import 'package:task_manager_app/features/kanban/presentation/screens/tasks/view_task_screen.dart';

class TaskCard extends StatelessWidget {
  Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onSecondary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.content.toString(),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.comment, size: 15),
                  const SizedBox(width: 5),
                  Text(task.commentCount.toString(), style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              Builder(
                builder: (context) {
                  switch (task.priority) {
                    case 1:
                      return const Icon(
                        Icons.keyboard_double_arrow_up_rounded,
                        color: Colors.greenAccent,
                      );
                    case 2:
                      return const Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: Colors.lightGreenAccent,
                      );
                    case 3:
                      return const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.amber,
                      );
                    case 4:
                      return const Icon(
                        Icons.keyboard_double_arrow_down_rounded,
                        color: Colors.red,
                      );
                  }
                  return const SizedBox();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
