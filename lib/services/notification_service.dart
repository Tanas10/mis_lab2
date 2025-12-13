import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

const String notificationTask = "notificationTask";

class NotificationService {
  static final NotificationService _instance =
  NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings =
    InitializationSettings(android: androidSettings);

    await _notifications.initialize(initSettings);

    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  Future<void> scheduleTestNotification() async {
    await Workmanager().registerOneOffTask(
      "notification_1",
      notificationTask,
      initialDelay: const Duration(minutes: 1),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final notifications = FlutterLocalNotificationsPlugin();

    const androidDetails = AndroidNotificationDetails(
      'test_channel',
      'Test Notifications',
      channelDescription: 'Reminder every minute',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails =
    NotificationDetails(android: androidDetails);

    await notifications.show(
      0,
      'Random Meal Reminder',
      'Check your Random Meal!',
      notificationDetails,
    );

    await Workmanager().registerOneOffTask(
      "notification_1",
      notificationTask,
      initialDelay: const Duration(minutes: 1),
    );

    return true;
  });
}
