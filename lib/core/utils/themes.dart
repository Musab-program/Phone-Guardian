import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_color.dart';

class AppThemes {
  // ================================================================
  // ======================= LIGHT THEME =============================
  // ================================================================
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Cairo',

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.textIcons,
      secondary: AppColors.accentColor,
      onSecondary: AppColors.textIcons,
      surface: Colors.white,
      onSurface: AppColors.primaryText,
    ),

    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,

    // cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      foregroundColor: AppColors.primaryText,
      centerTitle: true,
      elevation: 0,
      actionsIconTheme: IconThemeData(color: AppColors.primaryText),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5.0,
      foregroundColor: AppColors.primaryColor,
      splashColor: AppColors.textIcons,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.primaryText, fontSize: 18),
      bodyMedium: TextStyle(color: AppColors.primaryText, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.secondaryText, fontSize: 14),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
        foregroundColor: WidgetStatePropertyAll(AppColors.textIcons),
        overlayColor: WidgetStatePropertyAll(AppColors.darkPrimaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.darkPrimaryColor),
        foregroundColor: WidgetStatePropertyAll(AppColors.textIcons),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
        overlayColor: WidgetStatePropertyAll(AppColors.lightPrimaryColor),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStatePropertyAll(
          BorderSide(color: AppColors.primaryColor, width: 1.2),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),

    // TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.secondaryText),
      contentPadding: const EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.textIcons,
      elevation: 1.5,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Navigation Bar
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 1,
      indicatorColor: AppColors.primaryColor.withOpacity(0.2),
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: AppColors.primaryColor),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkPrimaryColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    // Switches & Checkboxes
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.primaryColor),
      trackColor: WidgetStatePropertyAll(
        AppColors.primaryColor.withOpacity(0.4),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.primaryColor),
    ),

    // Text selection (السحب في التكست)
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.lightPrimaryColor,
      selectionHandleColor: AppColors.primaryColor,
    ),

    iconTheme: IconThemeData(color: AppColors.primaryText),
  );

  // ================================================================
  // ======================= DARK THEME =============================
  // ================================================================
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Cairo',

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      brightness: Brightness.dark,
      primary: AppColors.primaryColor,
      onPrimary: AppColors.textIcons,
      secondary: AppColors.accentColor,
      onSecondary: AppColors.textIcons,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkText,
    ),

    scaffoldBackgroundColor: AppColors.darkBackground,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
      centerTitle: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5.0,
      foregroundColor: AppColors.textIcons,
      splashColor: AppColors.darkPrimaryColor,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkText, fontSize: 18),
      bodyMedium: TextStyle(color: AppColors.darkText, fontSize: 16),
      bodySmall: TextStyle(color: AppColors.darkSecondaryText, fontSize: 14),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
        foregroundColor: WidgetStatePropertyAll(AppColors.textIcons),
        overlayColor: WidgetStatePropertyAll(AppColors.lightPrimaryColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.accentColor),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: WidgetStatePropertyAll(
          BorderSide(color: AppColors.darkText, width: 1.2),
        ),
      ),
    ),

    // TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      hintStyle: const TextStyle(color: AppColors.darkSecondaryText),
      contentPadding: const EdgeInsets.all(14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkSecondaryText),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkSecondaryText),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
      ),
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkPrimaryColor,
      contentTextStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      indicatorColor: AppColors.primaryColor.withOpacity(0.2),
      iconTheme: WidgetStatePropertyAll(
        IconThemeData(color: AppColors.darkText),
      ),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.accentColor),
      trackColor: WidgetStatePropertyAll(
        AppColors.accentColor.withOpacity(0.4),
      ),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.accentColor),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStatePropertyAll(AppColors.accentColor),
    ),

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.accentColor,
      selectionColor: AppColors.lightPrimaryColor,
      selectionHandleColor: AppColors.accentColor,
    ),
    iconTheme: IconThemeData(color: AppColors.textIcons),
  );
}
