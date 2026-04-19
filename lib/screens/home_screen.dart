import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../main.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const buttonColor = Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Water Reminder Lab',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/img.png', fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 20,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: "Now",
                        color: buttonColor,
                        onPressed: () async {
                          await notificationService.showNotification(
                            id: 1,
                            title: "Drink water 💧",
                            body: "A quick reminder to hydrate",
                          );
                        },
                      ),
                      CustomButton(
                        text: "After 5s",
                        color: buttonColor,
                        onPressed: () async {
                          await notificationService.scheduleAfterSeconds(
                            id: 2,
                            title: "Drink water 💧",
                            body: "Don’t forget to drink water",
                            seconds: 5,
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: 'Every minute',
                        color: buttonColor,
                        onPressed: () async {
                          await notificationService.showPeriodicNotification(
                            id: 3,
                            title: "Drink water 💧",
                            body: "Keep sipping regularly",
                          );
                        },
                      ),

                      CustomButton(
                        text: "Daily 10:00",
                        color: buttonColor,
                        onPressed: () async {
                          await notificationService.scheduleDaily(
                            id: 3,
                            title: "Morning hydration ☀️",
                            body: "Start your day with water 💧",
                            hour: 10,
                            minute: 0,
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Scheduled 💧"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                        text: "Pick time",
                        color: buttonColor,
                        onPressed: () async {
                          DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) async {
                              selectedTime = date;
                              await notificationService.scheduleAt(
                                id: 4,
                                title: "Drink water 💧",
                                body: "Your reminder is set",
                                dateTime: selectedTime,
                              );
                            },
                          );
                        },
                      ),
                      CustomButton(
                        text: "Cancel all",
                        color: Colors.orange,
                        onPressed: () async {
                          await notificationService.cancelAll();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
