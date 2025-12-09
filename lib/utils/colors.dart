import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightFillColor = Color(0xFFF5F5F5);
  static const Color lightBorderColor = Color(0xFFDDDDDD);
  static const Color lightTextPrimary = Color(0xFF000000);
  static const Color lightTextSecondary = Color(0xFF555555);
  static const Color lightText = Color(0xFF000000);
  static const Color lightPrimary = Color(0xFF6750A4);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkFillColor = Color(0xFF1E1E1E);
  static const Color darkBorderColor = Color(0xFF444444);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFAAAAAA);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkPrimary = Color(0xFFCFBCFF);

  // Common Colors
  static const Color primaryBlue = Color(0xFF2962FF);
  static const Color error = Color(0xFFB00020);


  // Theme Helpers
  static Color textColor(bool isDark) =>
      isDark ? darkTextPrimary : lightTextPrimary;

  static Color backgroundColor(bool isDark) =>
      isDark ? darkBackground : lightBackground;

}