
import 'package:flutter/material.dart';

class AppDimensions {
  AppDimensions._();

  // Screen breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  // Screen size
  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  // Device type
  static bool isMobile(BuildContext context) =>
      screenWidth(context) < mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= mobileBreakpoint &&
          screenWidth(context) < tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= tabletBreakpoint;

  // Shared spacing
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 40;

  // Shared component sizes
  static const double buttonHeight = 50;
  static const double inputRadius = 12;
  static const double cardRadius = 12;
  static const double iconSize = 20;

  // Shared content width
  static double contentWidth(BuildContext context) {
    final width = screenWidth(context);

    if (width >= tabletBreakpoint) return 560;
    if (width >= mobileBreakpoint) return 500;

    return width;
  }
}
