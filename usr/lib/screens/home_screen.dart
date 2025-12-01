import 'package:flutter/material.dart';
import '../services/mock_signal_service.dart';
import '../models/signal.dart';
import '../widgets/signal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MockSignalService _signalService = MockSignalService();

  @override
  void initState() {
    super.initState();
    _signalService.startGeneratingSignals();
  }

  @override
  void dispose() {
    _signalService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_graph, color: Color(0xFF10B981)),
            SizedBox(width: 8),
            Text('Binomo Signals Pro'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications enabled for high accuracy signals')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatusHeader(),
          Expanded(
            child: StreamBuilder<List<TradingSignal>>(
              stream: _signalService.signalsStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Waiting for market signals...'));
                }

                final signals = snapshot.data!;

                return ListView.builder(
                  itemCount: signals.length,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (context, index) {
                    return SignalCard(signal: signals[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Market Status',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                'ACTIVE • REAL-TIME',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.wifi, color: Colors.white, size: 16),
                SizedBox(width: 6),
                Text(
                  'Connected',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
