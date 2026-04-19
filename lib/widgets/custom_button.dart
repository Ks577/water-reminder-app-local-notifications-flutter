import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Future<void> Function() onPressed;
  final Color color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 8),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
