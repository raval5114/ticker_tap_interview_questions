// Stock model class
import 'dart:convert';

class Stock {
  String stockName;
  String stockSymbol;
  double stockPrice;
  double stockOpening;
  double stockChanges;
  double stockClosing;
  double stockHighest;
  double stockLowest;
  Stock({
    required this.stockName,
    required this.stockSymbol,
    required this.stockPrice,
    required this.stockOpening,
    required this.stockChanges,
    required this.stockClosing,
    required this.stockHighest,
    required this.stockLowest,
  });

  // Factory method to create a Stock instance from JSON
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      stockName: json['stockName'] ?? '',
      stockSymbol: json['stockSymbol'] ?? '',
      stockPrice: (json['stockCurrentPrice'] as num?)?.toDouble() ?? 0.00,
      stockOpening: (json['stockOpeningPrice'] as num?)?.toDouble() ?? 0,
      stockChanges: (json['stockChanges'] as num?)?.toDouble() ?? 0,
      stockClosing: (json['stockClosingPrice'] as num?)?.toDouble() ?? 0,
      stockHighest: (json['stockHighestPrice'] as num?)?.toDouble() ?? 0,
      stockLowest: (json['stockLowestPrice'] as num?)?.toDouble() ?? 0,
    );
  }

  get stocks => null;
}

// Stocks model class to manage a list of Stock objects
class Stocks {
  List<Stock> stocks;

  Stocks({required this.stocks});

  // Factory method to create a Stocks instance from a JSON string
  factory Stocks.fromJson(String jsonString) {
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Stock> stocksList =
        jsonList.map((json) => Stock.fromJson(json)).toList();
    return Stocks(stocks: stocksList);
  }
}
