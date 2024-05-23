import 'package:blog_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _textFieldBorder(),
      enabledBorder: _textFieldBorder(),
      focusedBorder: _textFieldBorder(color: AppColors.gradient2),
      errorBorder: _textFieldBorder(color: AppColors.errorColor),
    ),
  );

  static OutlineInputBorder _textFieldBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColors.borderColor,
        width: 3.0,
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}
