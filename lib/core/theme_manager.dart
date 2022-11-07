import 'package:flutter/material.dart';
import 'package:posts_app/core/color_manager.dart';
ThemeData lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorManager.primaryColor,
    elevation: 0.0,
    centerTitle: true
  ),
  brightness: Brightness.light,
  primaryColor: ColorManager.primaryColor,
  colorScheme: const ColorScheme.light(
    primary: ColorManager.primaryColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorManager.primaryColor
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorManager.primaryColor,
    foregroundColor: ColorManager.secondaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(
      color: ColorManager.primaryColor,
    ),
    iconColor: ColorManager.secondaryColor,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorManager.secondaryColor
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ColorManager.primaryColor,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);