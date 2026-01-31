import 'package:flutter/material.dart';

/// Application color palette following Neumorphic design system.
/// All colors are static constants for consistent usage across the app.
abstract class AppColors {
  // Background Colors
  static const Color background = Color(0xFFE0E5EC);
  static const Color backgroundDark = Color(0xFFD1D9E6);

  // Neumorphic Shadow Colors
  static const Color shadowLight = Color(0xFFFFFFFF);
  static const Color shadowDark = Color(0xFFA3B1C6);

  // Player Colors
  static const Color playerX = Color(0xFF6C63FF);
  static const Color playerXLight = Color(0xFF8B85FF);
  static const Color playerO = Color(0xFFFF6B6B);
  static const Color playerOLight = Color(0xFFFF8A8A);

  // Text Colors
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textLight = Color(0xFF95A5A6);

  // State Colors
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color error = Color(0xFFE17055);

  // Accent Colors
  static const Color accent = Color(0xFF6C63FF);
  static const Color accentLight = Color(0xFF8B85FF);

  // Board Colors
  static const Color boardBackground = Color(0xFFE0E5EC);
  static const Color cellBackground = Color(0xFFE0E5EC);
  static const Color cellBorder = Color(0xFFD1D9E6);

  // Winning Line Color
  static const Color winningLine = Color(0xFF00B894);
}
