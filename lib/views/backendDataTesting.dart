import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Simulate API call to fetch stock data
Future<Map<String, dynamic>> fetchStockData() async {
  // Simulating a network delay
  await Future.delayed(const Duration(seconds: 1));

  // Replace this with your actual stock API URL
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  debugPrint('Function is called');
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return {
      'title': data['title'],
      'body': data['body']
    }; // Simulating stock data response
  } else {
    throw Exception('Failed to load stock data');
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StockDetailsScreen(),
    );
  }
}

class StockDetailsScreen extends StatefulWidget {
  @override
  _StockDetailsScreenState createState() => _StockDetailsScreenState();
}

class _StockDetailsScreenState extends State<StockDetailsScreen> {
  final StreamController<Map<String, dynamic>> _stockDataController =
      StreamController();
  Timer? _timer; // Timer to periodically fetch data every 5 seconds

  @override
  void initState() {
    super.initState();

    // Start the timer to fetch data every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      try {
        // Fetch stock data from API
        Map<String, dynamic> data = await fetchStockData();

        // Update the stream with the new data
        _stockDataController.add(data);
      } catch (e) {
        _stockDataController.addError('Failed to fetch data');
      }
    });

    // Fetch data once initially when the screen loads
    _fetchInitialData();
  }

  // Function to fetch initial data when screen loads
  Future<void> _fetchInitialData() async {
    try {
      Map<String, dynamic> initialData = await fetchStockData();
      _stockDataController.add(initialData); // Add initial data to the stream
    } catch (e) {
      _stockDataController.addError('Failed to fetch initial data');
    }
  }

  @override
  void dispose() {
    // Clean up the timer and stream when the screen is disposed
    _timer?.cancel();
    _stockDataController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Details')),
      body: Center(
        child: StreamBuilder<Map<String, dynamic>>(
          stream: _stockDataController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show loading indicator while waiting for data
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Show error if the API call fails
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Stock Title: ${snapshot.data!['title']}'),
                  Text('Stock Body: ${snapshot.data!['body']}'),
                ],
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
