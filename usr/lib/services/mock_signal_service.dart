import 'dart:async';
import 'dart:math';
import '../models/signal.dart';

class MockSignalService {
  final _streamController = StreamController<List<TradingSignal>>.broadcast();
  final List<TradingSignal> _currentSignals = [];
  final Random _random = Random();
  Timer? _timer;

  Stream<List<TradingSignal>> get signalsStream => _streamController.stream;

  final List<String> _assets = [
    'EUR/USD', 'GBP/USD', 'USD/JPY', 'CRYPTO IDX', 'AUD/CAD', 'BITCOIN', 'GOLD'
  ];

  void startGeneratingSignals() {
    // Generate initial batch
    _addSignal();
    _addSignal();
    
    // Add new signal every 5-10 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _addSignal();
    });
  }

  void _addSignal() {
    final asset = _assets[_random.nextInt(_assets.length)];
    final type = _random.nextBool() ? SignalType.call : SignalType.put;
    final price = 1.0 + _random.nextDouble(); // Simplified price
    
    final newSignal = TradingSignal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      asset: asset,
      type: type,
      timestamp: DateTime.now(),
      entryPrice: double.parse(price.toStringAsFixed(5)),
      timeframe: '${1 + _random.nextInt(5)} min',
      confidence: 85 + _random.nextInt(15), // 85-99% confidence
    );

    _currentSignals.insert(0, newSignal);
    
    // Keep list manageable
    if (_currentSignals.length > 20) {
      _currentSignals.removeLast();
    }

    _streamController.add(List.from(_currentSignals));
  }

  void dispose() {
    _timer?.cancel();
    _streamController.close();
  }
}
