import 'dart:convert';

class MessageNotificationModel {
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

  MessageNotificationModel({
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

  factory MessageNotificationModel.fromMap(Map<String, dynamic> map) {
    return MessageNotificationModel(
      notificationType: map['notificationType'] ?? '',
      channelId: map['channelId'] ?? '',
      channelTitle: map['channelTitle'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      messageId: map['messageId'] ?? '',
      message: map['message'] ?? '',
      date: map['date'] ?? '',
      isComplete: map['isComplete'] ?? false,
      workspaceId: map['workspaceId'] ?? '',
      replyToId: map['replyToId'] ?? '',
    );
  }

  factory MessageNotificationModel.fromJson(String source) => MessageNotificationModel.fromMap(json.decode(source));

  // factory MessageNotificationModel.fromModel({required NotificationMessageTable table}) {
  //   return MessageNotificationModel(
  //     notificationType: table.notificationType,
  //     channelId: table.channelId,
  //     channelTitle: table.channelTitle,
  //     userId: table.userId,
  //     userName: table.userName,
  //     messageId: table.messageId,
  //     message: table.message,
  //     date: table.date,
  //     workspaceId: table.workspaceId,
  //     isComplete: table.isComplete,
  //     replyToId: table.replyToId,
  //   );
  // }
}
