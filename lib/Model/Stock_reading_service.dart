import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticker_tap_interview_questions/Model/StockModel.dart';

Future<Stocks> fetchStocks() async {
  const String apiUrl = 'http://localhost:3000/stock_app/getStockData';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the response body into a JSON object
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      // Convert JSON response into a list of Stock objects
      final List<Stock> stocksList = jsonResponse
          .map((json) => Stock.fromJson(json as Map<String, dynamic>))
          .toList();

      return Stocks(stocks: stocksList);
    } else {
      // Log the status code for debugging
      throw Exception(
          'Failed to load stocks. Server responded with status code: ${response.statusCode}');
    }
  } catch (error) {
    // Catch and rethrow any error with additional information
    throw Exception('Failed to fetch stocks. Error: $error');
  }
}

