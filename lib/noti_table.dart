import 'package:notification_background/noti_model.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class NotificationMessageTable {
  @Id()
  int id;
  final String notificationType;
  final String channelId;
  final String channelTitle;
  final String userId;
  final String userName;
  final String messageId;
  final String message;
  final String date;
  final bool isComplete;
  final String workspaceId;
  final String replyToId;
  NotificationMessageTable({
    this.id = 0,
    required this.notificationType,
    required this.channelId,
    required this.channelTitle,
    required this.userId,
    required this.userName,
    required this.messageId,
    required this.message,
    required this.date,
    required this.isComplete,
    required this.workspaceId,
    required this.replyToId,
  });

  factory NotificationMessageTable.fromModel({
    required MessageNotificationModel model,
  }) {
    return NotificationMessageTable(
      notificationType: model.notificationType,
      channelId: model.channelId,
      channelTitle: model.channelTitle,
      userId: model.userId,
      userName: model.userName,
      messageId: model.messageId,
      message: model.message,
      date: model.date,
      workspaceId: model.workspaceId,
      isComplete: model.isComplete,
      replyToId: model.replyToId,
    );
  }
}
