part of 'notification_cubit.dart';

abstract class NotificationState {}

class InitialState extends NotificationState {}

class GetAllNotificationsState extends NotificationState {
  BaseResponse<List<PendingNotificationRequest>?> baseResponse;
  GetAllNotificationsState({required this.baseResponse});
}

class GetNotificationByIdState extends NotificationState {
  BaseResponse<PendingNotificationRequest?> baseResponse;
  GetNotificationByIdState({required this.baseResponse});
}
