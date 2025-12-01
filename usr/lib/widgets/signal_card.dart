import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/signal.dart';

class SignalCard extends StatelessWidget {
  final TradingSignal signal;

  const SignalCard({super.key, required this.signal});

  @override
  Widget build(BuildContext context) {
    final isCall = signal.type == SignalType.call;
    final color = isCall ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    final icon = isCall ? Icons.arrow_upward : Icons.arrow_downward;
    final typeText = isCall ? 'CALL (BUY)' : 'PUT (SELL)';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF334155),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.currency_exchange,
                        color: Colors.white70,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          signal.asset,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm:ss').format(signal.timestamp),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, color: color, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        typeText,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white10, height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('Timeframe', signal.timeframe),
                _buildInfoColumn('Entry', signal.entryPrice.toString()),
                _buildInfoColumn('Confidence', '${signal.confidence}%', 
                    textColor: signal.confidence > 90 ? const Color(0xFFFFD700) : Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, {Color? textColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
