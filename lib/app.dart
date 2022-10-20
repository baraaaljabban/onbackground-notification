import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_background/local_data_source.dart';
import 'package:notification_background/noti_table.dart';
import 'dependencies.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<NotificationMessageTable> allNotifications = [];
  @override
  void initState() {
    super.initState();
    var result = sl.get<LocalDB>().allNotifications();
    allNotifications.addAll(result);
    print('noti count ${allNotifications.length}');
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print('fcm $token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: ListView.builder(
            itemCount: allNotifications.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(4),
                color: Colors.amber,
                child: Text(allNotifications[index].message),
              );
            },
          ),
        ),
      ),
    );
  }
}
