import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/utils/assets.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/notification_cubit/notification_cubit.dart';

class NotificationsScreeon extends StatefulWidget {
  const NotificationsScreeon({super.key});

  @override
  State<NotificationsScreeon> createState() => _NotificationsScreeonState();
}

class _NotificationsScreeonState extends State<NotificationsScreeon> {
  @override
  void initState() {
    context.read<NotificationBloc>().getAllScheduledNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (previous, current) => current is GetAllNotificationsState,
          builder: (context, state) {
            if (state is GetAllNotificationsState) {
              if (state.baseResponse.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.baseResponse.status == Status.success) {
                List<PendingNotificationRequest>? notifications = state.baseResponse.data ?? [];
                notifications = notifications.reversed.toList();
                notifications = notifications.where((notification) => DateTime.parse(notification.payload ?? '').isBefore(DateTime.now())).toList();
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset(
                                AppAssets.APP_ICON_TRANSPARENT,
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(notifications![index].title.toString(), style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 5),
                                    Text(notifications[index].body.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            }
            return const SizedBox();
          }),
    );
  }
}
