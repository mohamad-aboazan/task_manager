import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';

class ReminderSwitchwidget extends StatefulWidget {
  bool reminder;
  Function(bool)? onChanged;

  ReminderSwitchwidget({super.key, required this.onChanged, this.reminder = false});

  @override
  State<ReminderSwitchwidget> createState() => _ReminderSwitchwidgetState();
}

class _ReminderSwitchwidgetState extends State<ReminderSwitchwidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.reminder) {
      return switchb(widget.reminder);
    }
    return BlocBuilder<NotificationBloc, NotificationState>(
      buildWhen: (previous, current) => current is GetNotificationByIdState,
      builder: (context, state) {
        if (state is GetNotificationByIdState) {
          widget.reminder = state.baseResponse.data?.id != null;
          widget.onChanged!(widget.reminder);
          return switchb(widget.reminder);
        }
        return const SizedBox();
      },
    );
  }

  Widget switchb(bool reminder) {
    return StatefulBuilder(builder: (context, setstateReminder) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Reminder',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
          ),
          Switch(
            value: reminder,
            onChanged: (value) {
              widget.onChanged!(value);
              setstateReminder(() {
                reminder = value;
              });
            },
          ),
        ],
      );
    });
  }
}
