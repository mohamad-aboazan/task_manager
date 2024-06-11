import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_app/core/entities/base_state.dart';
import 'package:task_manager_app/core/services/local_notification_service.dart';
import 'package:task_manager_app/features/kanban/domain/entities/project.dart';

part "notification_state.dart";

/// ---------------------------------------------------------------------------------------------------------
/// BLoC for managing notifications in the Kanban application.
///
/// This BLoC is responsible for handling notifications within the Kanban application. It provides functionalities
/// for retrieving notifications by ID and getting all scheduled notifications.
///
/// Features:
///   - Retrieve a notification by its ID.
///   - Get all scheduled notifications.
///
/// Usage:
///   - Instantiate `NotificationBloc` with the required `LocalNotificationService`.
///   - Use `getNotificationById` to retrieve a notification by its ID.
///   - Use `getAllScheduledNotifications` to get all scheduled notifications.
///
///---------------------------------------------------------------------------------------------------------

class NotificationBloc extends Cubit<NotificationState> {
  final LocalNotificationService _localNotificationService;

  Project? currentProject;
  List<Project> projects = [];
  NotificationBloc(this._localNotificationService) : super(InitialState());

  void getNotificationById({required int id}) async {
    try {
      emit(GetNotificationByIdState(baseResponse: BaseResponse.loading()));
      PendingNotificationRequest? notification = await _localNotificationService.getScheduledNotificationById(id);
      emit(GetNotificationByIdState(baseResponse: BaseResponse.success(notification)));
    } catch (e) {
      emit(GetAllNotificationsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }

  void getAllScheduledNotifications() async {
    try {
      emit(GetAllNotificationsState(baseResponse: BaseResponse.loading()));
      List<PendingNotificationRequest>? notifications = await _localNotificationService.getAllScheduledNotifications();
      emit(GetAllNotificationsState(baseResponse: BaseResponse.success(notifications)));
    } catch (e) {
      emit(GetAllNotificationsState(baseResponse: BaseResponse.error(e.toString())));
    }
  }
}
