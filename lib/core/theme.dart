import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BinderfulThemeData {
  static ThemeData lightTheme() {
    final lightTheme = ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(
          fontSize: 12,
        ),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(),
      ),
      useMaterial3: true,
    );

    return lightTheme;
  }

  static ThemeData darkTheme() {
    final darkTheme = ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(),
        bodyMedium: TextStyle(),
        bodySmall: TextStyle(),
        displayLarge: TextStyle(),
        displayMedium: TextStyle(),
        displaySmall: TextStyle(),
        headlineLarge: TextStyle(),
        headlineMedium: TextStyle(),
        headlineSmall: TextStyle(),
        labelLarge: TextStyle(),
        labelMedium: TextStyle(),
        labelSmall: TextStyle(),
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(),
      ),
      useMaterial3: true,
    );

    return darkTheme;
  }
}
