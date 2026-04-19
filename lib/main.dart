import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:local_notifications/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'screens/home_screen.dart';
import 'package:timezone/timezone.dart' as tz;

final notificationService = LocalNotificationService.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  final timeZoneName = await FlutterTimezone.getLocalTimezone();

  tz.setLocalLocation(tz.getLocation(timeZoneName));

  await notificationService.initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drink Water Reminder',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}
