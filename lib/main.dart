import 'dart:async';
import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_background/local_data_source.dart';

import 'app.dart';
import 'dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Isolate.current.addErrorListener(
    RawReceivePort(
      (pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await _reportError(errorAndStacktrace.first, errorAndStacktrace.last);
      },
    ).sendPort,
  );
  await Firebase.initializeApp();
  await slInit();
  requestNotificationPermission();
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

  await runZonedGuarded<Future<void>>(
    () async {
      runApp(const App());
    },
    (error, stack) => _reportError(error, stack),
  );
}

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  late LocalDB _service;
  try {
    _service = sl<LocalDB>();
  } catch (e) {
    await sl.reset();
    await slInit();
    _service = sl<LocalDB>();
  }
  _service.saveNewNotificationMessage(message: message);
}

Future<void> _reportError(
  dynamic exception,
  dynamic stack,
) async {
  await FirebaseCrashlytics.instance.recordError(
    exception,
    stack,
  );
}

Future requestNotificationPermission() async {
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: false,
    badge: false,
    sound: false,
  );
  return await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
