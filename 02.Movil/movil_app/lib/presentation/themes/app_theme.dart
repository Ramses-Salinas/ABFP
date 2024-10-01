import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double largeTextSize = screenWidth * 0.065;
    double bodyTextSize = screenWidth * 0.045;

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(fontSize: largeTextSize, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        bodyLarge: TextStyle(fontSize: bodyTextSize, color: AppColors.textSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.secondary.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.buttonPrimary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
