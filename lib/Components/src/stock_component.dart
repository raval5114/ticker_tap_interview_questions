import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';

class StockComponent extends StatefulWidget {
  final String cmpSymbl;
  final String cmpName;
  final double stockPrice;
  final double stockChanges;
  final double opening;
  final double closing;
  final double highest;
  final double lowest;

  const StockComponent({
    super.key,
    required this.cmpSymbl,
    required this.cmpName,
    required this.stockPrice,
    required this.stockChanges,
    required this.opening,
    required this.closing,
    required this.highest,
    required this.lowest,
  });

  @override
  State<StockComponent> createState() => _StockComponentState();
}

class _StockComponentState extends State<StockComponent> {
  MaterialAccentColor? colorPrice;
  OverlayEntry? _overlayPortal;

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Background blur effect with dismiss capability
          GestureDetector(
            onTap: _removeOverlay,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.6), // Dim the background
              ),
            ),
          ),

          // Centered overlay content
          Center(
            child: Material(
              elevation: 12.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D3436), Color(0xFF3C4043)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Close button
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: _removeOverlay,
                      ),
                    ),

                    // Header section
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Stock Details",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.cmpName,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "(${widget.cmpSymbl})",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey, height: 30),

                    // Data section
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildDataRow("Current Price",
                                widget.stockPrice.toStringAsFixed(2)),
                            _buildDataRow("Price Change",
                                widget.stockChanges.toStringAsFixed(2),
                                color: colorPrice),
                            const Divider(color: Colors.grey, height: 30),
                            _buildDataRow("Opening Price",
                                widget.opening.toStringAsFixed(2)),
                            _buildDataRow("Closing Price",
                                widget.closing.toStringAsFixed(2)),
                            _buildDataRow("Highest Price",
                                widget.highest.toStringAsFixed(2),
                                color: Colors.greenAccent),
                            _buildDataRow("Lowest Price",
                                widget.lowest.toStringAsFixed(2),
                                color: Colors.redAccent),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showOverlayPortal() {
    if (_overlayPortal != null) return; // Prevent duplicate overlay
    _overlayPortal = _createOverlayEntry();
    Overlay.of(context)?.insert(_overlayPortal!);
  }

  void _removeOverlay() {
    _overlayPortal?.remove();
    _overlayPortal = null;
  }

  @override
  Widget build(BuildContext context) {
    colorPrice =
        widget.stockChanges < 0 ? Colors.redAccent : Colors.greenAccent;

    return GestureDetector(
      onTap: _showOverlayPortal,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2C5364), Color(0xFF203A43)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(0, 4),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cmpSymbl,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.cmpName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.stockPrice.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.stockChanges.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorPrice,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay(); // Clean up overlay on dispose
    super.dispose();
  }
}
