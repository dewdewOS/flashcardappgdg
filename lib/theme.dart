import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: GoogleFonts.quicksandTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primarySwatch: Colors.pink,
    ).copyWith(secondary: Colors.purpleAccent),
  );

  static ThemeData darkTheme = ThemeData(
    textTheme: GoogleFonts.quicksandTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
    ).copyWith(secondary: Colors.pinkAccent),
  );
}
