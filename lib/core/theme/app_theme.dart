import 'package:flutter/material.dart';

/// Global app theme
final appTheme = ThemeData(
  // SnackBar theme customization
  snackBarTheme: SnackBarThemeData(
    // Background color of all snackbars
    backgroundColor: Colors.blue,

    // Style for the main snackbar text (content)
    contentTextStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),

    // Rounded corners for a modern look
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
    ),
  ),
  // Style for SnackBarAction label in Snackbar
  textTheme: TextTheme(labelLarge: TextStyle(fontSize: 18)),

  // Style for ElevatedButton
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
);
