import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/utils/log_content.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/task_cubit/task_cubit.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/timer_cubit/timer_cubit.dart';

class TimerWidget extends StatelessWidget {
  final String id;

  const TimerWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, Map<String, int>>(
      builder: (context, state) {
        final timerBloc = context.read<TimerBloc>();
        final isRunning = state.containsKey(id) && timerBloc.isTaskRunning(id);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
              iconSize: 48.0,
              onPressed: () {
                print(id);
                if (isRunning) {
                  context.read<TaskBloc>().newLog(taskId: id, taskLogType: TaskLogTypes.stopTimer, variables: {});
                } else {
                  context.read<TaskBloc>().newLog(taskId: id, taskLogType: TaskLogTypes.startTimer, variables: {});
                }
                timerBloc.toggleTimer(id);
              },
            ),
            Text(
              timerBloc.getFormattedTime(id),
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        );
      },
    );
  }
}
