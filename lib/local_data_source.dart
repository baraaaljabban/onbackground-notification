import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_background/noti_model.dart';
import 'package:notification_background/noti_table.dart';
import 'package:objectbox/objectbox.dart';

abstract class LocalDB {
  void saveNewNotificationMessage({required RemoteMessage message});
  List<NotificationMessageTable> allNotifications();
}

class LocalDBImpl extends LocalDB {
  final Store store;
  LocalDBImpl({
    required this.store,
  });
  @override
  void saveNewNotificationMessage({required RemoteMessage message}) {
    var notificationModel = MessageNotificationModel.fromJson(message.data['data']);

    store.box<NotificationMessageTable>().put(
          NotificationMessageTable.fromModel(
            model: notificationModel,
          ),
        );
  }

  @override
  List<NotificationMessageTable> allNotifications() {
    return store.box<NotificationMessageTable>().getAll();
  }
}
