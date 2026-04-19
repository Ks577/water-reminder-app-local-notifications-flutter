import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService._();

  static final instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/drop');

    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(settings: settings);

    await _requestPermission();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.notification.status;

    if (!status.isGranted) {
      await Permission.notification.request();
    }
  }

  NotificationDetails _details() {
    const android = AndroidNotificationDetails(
      'water_channel',
      'Water reminders',
      channelDescription: 'Reminder to drink water',
      importance: Importance.max,
      priority: Priority.high,
    );

    const ios = DarwinNotificationDetails();

    return const NotificationDetails(android: android, iOS: ios);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: _details(),
    );
  }

  Future<void> showPeriodicNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _plugin.periodicallyShow(
      id: id,
      title: title,
      body: body,
      repeatInterval: RepeatInterval.everyMinute,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      notificationDetails: _details(),
    );
  }

  Future<void> scheduleAfterSeconds({
    required int id,
    required String title,
    required String body,
    required int seconds,
  }) async {
    final time = tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: time,
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: _details(),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> scheduleAt({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    final time = tz.TZDateTime.from(dateTime, tz.local);

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: time,
      notificationDetails: _details(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
