
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,

    fontFamily: GoogleFonts.inter().fontFamily,

    textTheme: GoogleFonts.interTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 34,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
        height: 1.2,
      ),
      displayMedium: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 30,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        height: 1.2,
      ),
      headlineSmall: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      titleLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        color: AppColors.white,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      labelMedium: GoogleFonts.inter(
        color: AppColors.grey,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ).apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.white,
      elevation: 0,
    ),

    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(fontSize: 11),
      hintStyle: TextStyle(fontSize: 11),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
