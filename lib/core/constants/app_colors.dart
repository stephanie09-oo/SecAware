
import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF06070C);
  static const Color primary = Color(0xFF00C995);
  static const Color cyan = Color(0xFF16D9F2);
  static const Color card = Color(0xFF0B1220);
  static const Color white = Color(0xFFF8FAFC);
  static const Color grey = Color(0xFF94A3B8);
  static const Color purple = Color(0xFF7C3AED);
  static const Color purple2 = Color(0xFF4C1D95);
  static const Color border = Color(0xFF1E293B);
  static const Color inputBackground = Color(0xFF080D19);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF102B3D),
      Color(0xFF0B1428),
      Color(0xFF06070C),
    ],
    stops: [
      0.0,
      0.85,
      1.0,
    ],
  );
}

