import 'package:flutter/material.dart';

class AppBarComponent extends StatefulWidget {
  const AppBarComponent({super.key});

  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent, // Clear app bar background
      elevation: 0, // Remove shadow for a seamless look
      title: const Text(
        "Ticker Tap",
        style: TextStyle(
          color: Colors.tealAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: InkWell(
        borderRadius: BorderRadius.circular(30), // Adds hover effect
        onTap: () {
          // Add an action here if needed
        },
        child: const Icon(
          Icons.pause_circle,
          color: Colors.tealAccent,
          size: 28,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: InkWell(
            child: Text(
              "History",
              style: TextStyle(
                fontSize: 18,
                color: Colors.tealAccent, // Keep teal color for visibility
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
