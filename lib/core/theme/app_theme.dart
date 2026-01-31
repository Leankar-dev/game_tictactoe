import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.accent,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.accent,
      secondary: AppColors.playerO,
      surface: AppColors.background,
      error: AppColors.error,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: AppDimensions.fontTitle,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: AppDimensions.fontXXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: AppDimensions.fontXLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: AppDimensions.fontLarge,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: AppDimensions.fontLarge,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: AppDimensions.fontMedium,
        color: AppColors.textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: AppDimensions.fontMedium,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),

    iconTheme: const IconThemeData(
      color: AppColors.textPrimary,
      size: AppDimensions.iconMedium,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        minimumSize: const Size(
          AppDimensions.buttonMinWidth,
          AppDimensions.buttonHeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.accent),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.accent,
    scaffoldBackgroundColor: const Color(0xFF2D2D2D),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.playerO,
      surface: Color(0xFF2D2D2D),
      error: AppColors.error,
    ),
  );
}
