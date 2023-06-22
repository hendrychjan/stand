import 'package:flutter/material.dart';

class MainTheme {
  static final ThemeData lightTheme = buildLightTheme();
  static final ThemeData darkTheme = buildDarkTheme();

  static const Color primaryColor = Color.fromARGB(255, 255, 183, 138);
  static const Color secondaryColor = Color.fromARGB(255, 163, 195, 255);

  static ThemeData buildDarkTheme() {
    final ThemeData base = ThemeData.dark(useMaterial3: true);

    return base.copyWith(
      // Colors
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),

      // Text selection
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: secondaryColor,
        selectionColor: secondaryColor.withOpacity(0.4),
        selectionHandleColor: secondaryColor,
      ),

      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Colors.black,
        foregroundColor: primaryColor,
      ),

      scaffoldBackgroundColor: Colors.black,

      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),

      // Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: secondaryColor,
          surfaceTintColor: secondaryColor.withOpacity(0.4),
        ),
      ),

      // Text input
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        hintStyle: const TextStyle(
          color: secondaryColor,
        ),
        labelStyle: const TextStyle(
          color: secondaryColor,
        ),
        iconColor: secondaryColor,
      ),
    );
  }

  static ThemeData buildLightTheme() {
    final ThemeData base = ThemeData.light(useMaterial3: true);

    return base.copyWith(
      // Colors
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
      ),

      scaffoldBackgroundColor: Colors.white,

      // Text selection
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: secondaryColor,
        selectionColor: secondaryColor.withOpacity(0.4),
        selectionHandleColor: secondaryColor,
      ),

      // Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: secondaryColor,
          surfaceTintColor: secondaryColor.withOpacity(0.4),
        ),
      ),

      // Text input
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        alignLabelWithHint: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: secondaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        hintStyle: const TextStyle(
          color: secondaryColor,
        ),
        labelStyle: const TextStyle(
          color: secondaryColor,
        ),
        iconColor: secondaryColor,
      ),
    );
  }
}
