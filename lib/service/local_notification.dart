import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotificationService {
//   static final _notifications = FlutterLocalNotificationsPlugin();

//   static Future _notificationDetails() async {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channel id',
//         'channel Name',
//         channelDescription: 'channel description',
//         importance: Importance.max,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     _notifications.show(
//       id,
//       title,
//       body,
//       await _notificationDetails(),
//       payload: payload,
//     );
//   }
// }

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  void initNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidSettings,
    );
    await _notifications.initialize(initializationSettings);
  }

  void sendNotification({
    String? title,
    String? body,
  }) async {
    AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await _notifications.show(0, title, body, notificationDetails);
  }
}
