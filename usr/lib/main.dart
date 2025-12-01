import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/disclaimer_screen.dart';

void main() {
  runApp(const BinomoSignalsApp());
}

class BinomoSignalsApp extends StatelessWidget {
  const BinomoSignalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binomo Signals Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Dark Navy
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF10B981),
          surface: Color(0xFF1E293B),
          error: Color(0xFFEF4444),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F172A),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DisclaimerScreen(), // Start with disclaimer for safety
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
