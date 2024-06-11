import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';

///======================================================================================================
/// Widget for displaying a switch button to enable or disable task reminders.
///
/// It can be used to display a reminder switch button for tasks. If a task has a reminder set,
/// the initial state of the switch button is determined by the `reminder` parameter. If not,
/// it fetches the reminder status from the `NotificationBloc` and updates the switch button accordingly.
/// When the user toggles the switch button, it updates the reminder status and notifies the parent
/// widget using the `onChanged` callback.
///
/// Additionally, if there is a scheduled notification for the task in the local notifications,
/// the switch button is automatically set to the enabled state, regardless of the `reminder` parameter.
///
/// Parameters:
///   - `reminder`: A boolean value indicating whether the reminder is enabled or disabled.
///   - `onChanged`: A callback function that is called when the reminder status is changed.
///                  It takes a boolean parameter indicating the new reminder status.
///======================================================================================================

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
      return switchButton(widget.reminder);
    }
    return BlocBuilder<NotificationBloc, NotificationState>(
      buildWhen: (previous, current) => current is GetNotificationByIdState,
      builder: (context, state) {
        if (state is GetNotificationByIdState) {
          widget.reminder = state.baseResponse.data?.id != null;
          widget.onChanged!(widget.reminder);
          return switchButton(widget.reminder);
        }
        return const SizedBox();
      },
    );
  }

  Widget switchButton(bool reminder) {
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
