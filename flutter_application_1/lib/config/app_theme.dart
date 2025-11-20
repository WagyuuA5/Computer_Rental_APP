import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Poppins',

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // cardTheme: CardTheme(
      //   color: AppColors.cardBackground,
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      // ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
      //  Dark Theme 
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: const Color(0xFF1A1A1A),
      fontFamily: 'Poppins',

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // cardTheme: CardTheme(
      //   color: const Color(0xFF262626),
      //   elevation: 0,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      // ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Color(0xFFCCCCCC)),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
