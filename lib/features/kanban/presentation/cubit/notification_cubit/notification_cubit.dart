import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/services/local_notification_service.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';

part "notification_state.dart";

class NotificationBloc extends Cubit<NotificationState> {
  LocalNotificationService localNotificationService;

  Project? currentProject;
  List<Project> projects = [];
  NotificationBloc({required this.localNotificationService}) : super(InitialState());

  void getNotificationById({required int id}) async {
    try {
      emit(GetNotificationByIdState(baseResponse: BaseResponse.loading()));
      PendingNotificationRequest? notification = await localNotificationService.getScheduledNotificationById(id);
      emit(GetNotificationByIdState(baseResponse: BaseResponse.success(notification)));
    } catch (e) {
      emit(GetAllNotificationsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void getAllScheduledNotifications() async {
    try {
      emit(GetAllNotificationsState(baseResponse: BaseResponse.loading()));
      List<PendingNotificationRequest>? notifications = await localNotificationService.getAllScheduledNotifications();
      emit(GetAllNotificationsState(baseResponse: BaseResponse.success(notifications)));
    } catch (e) {
      emit(GetAllNotificationsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
