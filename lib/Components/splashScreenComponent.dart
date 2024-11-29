import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ticker_tap_interview_questions/Model/StockModel.dart';
import 'package:ticker_tap_interview_questions/Model/Stock_reading_service.dart';
import 'package:ticker_tap_interview_questions/views/homepage.dart';

class Splashscreencomponent extends StatefulWidget {
  const Splashscreencomponent({super.key});

  @override
  State<Splashscreencomponent> createState() => _SplashscreencomponentState();
}

class _SplashscreencomponentState extends State<Splashscreencomponent> {
  late Future<Stocks> stocks;

  @override
  void initState() {
    super.initState();
    stocks = fetchStocks();
    _navigateToHomepage();
  }

  void _navigateToHomepage() async {
    Stocks stockData = await stocks;

    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomepage(
            stocks: stockData,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.blueGrey], // Gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or app branding
              Icon(
                Icons.show_chart,
                size: 80,
                color: Colors.tealAccent,
              ),
              SizedBox(height: 20),
              Text(
                "TickerTap",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(height: 40),

              // Loading indicator
              CircularProgressIndicator(
                color: Colors.tealAccent,
                strokeWidth: 4.0,
              ),
              SizedBox(height: 20),

              // Loading message
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: 1.0,
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
