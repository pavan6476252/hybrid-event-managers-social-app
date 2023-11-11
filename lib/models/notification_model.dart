
class NotificationModel {
  final String notificationId;
  final String userId;
  final String content;
  final bool isRead;
  final DateTime timestamp;

  NotificationModel({
    required this.notificationId,
    required this.userId,
    required this.content,
    required this.isRead,
    required this.timestamp,
  });
}