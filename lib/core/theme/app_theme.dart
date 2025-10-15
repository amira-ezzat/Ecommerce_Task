import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.blue,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      foregroundColor: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.blue,
      secondary: AppColors.blue2,
      onPrimary: AppColors.white,
      background: AppColors.white,
      surface: AppColors.white,
    ),
    cardColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.black2),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.black2),
      bodyMedium: TextStyle(color: AppColors.black2),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.blue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      foregroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.blue,
      secondary: AppColors.blue2,
      onPrimary: AppColors.white,
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
    ),
    cardColor: const Color(0xFF1E1E1E),
    iconTheme: const IconThemeData(color: AppColors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey.shade800,
      selectedColor: AppColors.blue,
      labelStyle: const TextStyle(color: Colors.white),
    ),
  );
}