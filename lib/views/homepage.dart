import 'package:flutter/material.dart';
import 'package:ticker_tap_interview_questions/Components/dashboard.dart';
import 'package:ticker_tap_interview_questions/Components/src/appbar.dart';
import 'package:ticker_tap_interview_questions/Model/StockModel.dart';

class MyHomepage extends StatefulWidget {
  final Stocks stocks;
  const MyHomepage({
    super.key,
    required this.stocks,
  });

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Apply a subtle gradient background to the entire screen
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2C2F33),
              Color(0xFF23272A)
            ], // Darker tones for gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const AppBarComponent(),
            Expanded(
              child: Dashboard(
                stocks: widget.stocks, // Pass stocks data to Dashboard
              ),
            ),
          ],
        ),
      ),
    );
  }
}
