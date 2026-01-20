import 'package:flutter/material.dart';

/// App color constants
/// Primary color family: Green
class AppColors {
  AppColors._();

  // Primary Colors (Green Family)
  static const Color primary = Color(0xFF9a2617);
  static const Color primaryLight = Color(0xFF81C784);
  static const Color primaryDark = Color(0xFF1f0401);
  static const Color primaryVariant = Color(0xFF66BB6A);

  // Secondary Colors
  static const Color secondary = Color(0xFF8BC34A);
  static const Color secondaryLight = Color(0xFFAED581);
  static const Color secondaryDark = Color(0xFF689F38);

  // Accent Colors
  static const Color accent = Color(0xFF009688);
  static const Color accentLight = Color(0xFF4DB6AC);

  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Divider & Border Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);

  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    primary,
    primaryDark,
  ];

  static const List<Color> secondaryGradient = [
    secondary,
    secondaryDark,
  ];
}
