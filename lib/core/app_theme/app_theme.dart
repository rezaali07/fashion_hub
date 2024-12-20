import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFF6600),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Montserrat',
      ),
      centerTitle: true,
    ),
    fontFamily: 'Montserrat',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: const Color(0xFFFF6600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}
