import 'package:flutter/material.dart';
import 'package:ticker_tap_interview_questions/Components/src/stock_component.dart';
import 'package:ticker_tap_interview_questions/Model/StockModel.dart';

class Dashboard extends StatefulWidget {
  final Stocks stocks;

  const Dashboard({Key? key, required this.stocks}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final bool hasStocks = widget.stocks.stocks.isNotEmpty;

    return Container(
      color: Colors.grey[900], // Dark background for the dashboard
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Stock Prices",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.tealAccent[100], // Accent color for the title
              ),
            ),
          ),
          const SizedBox(height: 20),
          hasStocks
              ? Expanded(
                  child: ListView.separated(
                    itemCount: widget.stocks.stocks.length,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                      color: Colors.grey[700], // Dark divider
                    ),
                    itemBuilder: (context, index) {
                      final stock = widget.stocks.stocks[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: StockComponent(
                          cmpName: stock.stockName,
                          stockPrice: stock.stockPrice,
                          stockChanges: stock.stockChanges,
                          cmpSymbl: stock.stockSymbol,
                          closing: stock.stockClosing,
                          opening: stock.stockOpening,
                          highest: stock.stockHighest,
                          lowest: stock.stockLowest,
                        ),
                      );
                    },
                  ),
                )
              : Flexible(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,
                            size: 80, color: Colors.redAccent),
                        const SizedBox(height: 10),
                        Text(
                          "No stocks available.",
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                Colors.grey[300], // Light gray for error text
                          ),
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
