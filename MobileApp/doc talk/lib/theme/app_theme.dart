import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightGray,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryBlue,
      secondary: AppColors.primaryTeal,
      background: AppColors.lightGray,
      error: AppColors.errorRed,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: AppColors.darkGray,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: AppColors.darkGray,
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        color: AppColors.lightGray,
        fontSize: 14.0,
      ),
      button: TextStyle(
        color: AppColors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primaryBlue,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.darkPrimaryBlue,
    scaffoldBackgroundColor: AppColors.darkGrayBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimaryBlue,
      secondary: AppColors.darkPrimaryTeal,
      background: AppColors.darkGrayBackground,
      surface: AppColors.darkSurface,
      error: AppColors.errorRed,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: AppColors.darkText,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        color: AppColors.darkText,
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        color: AppColors.darkText,
        fontSize: 14.0,
      ),
      button: TextStyle(
        color: AppColors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.darkPrimaryBlue,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
