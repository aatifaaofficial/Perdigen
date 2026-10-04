import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const deepGreen = Color(0xFF174B3A);
  static const freshGreen = Color(0xFF24A866);
  static const mint = Color(0xFFE8F7EE);
  static const canvas = Color(0xFFF5FBF7);
  static const ink = Color(0xFF17312B);
  static const mutedInk = Color(0xFF71837D);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: freshGreen,
      brightness: Brightness.light,
      surface: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      fontFamily: 'Roboto',
      splashFactory: InkSparkle.splashFactory,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(color: ink, fontWeight: FontWeight.w800),
        titleLarge: TextStyle(color: ink, fontWeight: FontWeight.w800),
        bodyMedium: TextStyle(color: mutedInk),
      ),
    );
  }
}
