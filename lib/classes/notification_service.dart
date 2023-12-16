import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('smh');

    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'smart_money_handling_channel',
      'Smart Money Handling',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    try {
      print('Showing notification: title=$title, body=$body');
      await flutterLocalNotificationsPlugin.show(
        0,
        title ?? 'Default Title', // Use a default if title is null
        body ?? 'Default Body', // Use a default if body is null
        platformChannelSpecifics,
        payload: 'item x',
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
}
