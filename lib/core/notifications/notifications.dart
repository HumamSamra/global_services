import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class GlobalNotifications {
  final _plugin = FlutterLocalNotificationsPlugin();

  static GlobalNotifications instance = GlobalNotifications._();
  GlobalNotifications._();

  Future init() async {
    AndroidInitializationSettings android =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings ios = const DarwinInitializationSettings();
    InitializationSettings initSettings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _plugin.initialize(initSettings);
  }

  Future requestPermissions() async {
    if (Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    } else if (Platform.isIOS) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions();
    }
  }

  Future showNotification({
    int id = 1,
    required String title,
    required String body,
  }) async {
    _plugin.show(id, title, body, await _notificationDetails());
  }

  Future _notificationDetails() async => NotificationDetails(
        android: AndroidNotificationDetails(
          '${DateTime.now()}',
          "Global Services",
          channelDescription: "Global Services Channel",
          priority: Priority.high,
          importance: Importance.max,
          playSound: true,
          shortcutId: DateTime.now().toIso8601String(),
        ),
        iOS: const DarwinNotificationDetails(),
      );
}
