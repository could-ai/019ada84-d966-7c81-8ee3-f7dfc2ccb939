enum SignalType { call, put }

class TradingSignal {
  final String id;
  final String asset;
  final SignalType type;
  final DateTime timestamp;
  final double entryPrice;
  final String timeframe;
  final int confidence;
  final bool isWinning; // For history

  TradingSignal({
    required this.id,
    required this.asset,
    required this.type,
    required this.timestamp,
    required this.entryPrice,
    required this.timeframe,
    required this.confidence,
    this.isWinning = true,
  });
}
