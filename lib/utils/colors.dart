import 'package:flutter/material.dart';

class AppColor {
  // Primary Colors
  static const Color kPrimary = Color(0xFFFF6600); // Bright orange (Daraz-like)
  static const Color kSecondary =
      Color(0xFFFFA726); // Lighter orange for highlights

  // Background Colors
  static const Color kBackGroundColor =
      Color(0xFFF5F5F5); // Light neutral background
  static const Color kSurface = Color(0xFFFFFFFF); // Pure white

  // Text Colors
  static const Color kTextPrimary = Color(0xFF333333); // Dark text
  static const Color kTextSecondary = Color(0xFF757575);
  static const Color kText = Color.fromARGB(255, 255, 255, 255);
  // Gray text

  // Borders and Dividers
  static const Color kBorder =
      Color(0xFFDDDDDD); // Light gray for dividers and borders

  // Accent Colors
  static const Color kAccent =
      Color(0xFF0066FF); // Bold blue for action buttons
  static const Color kAccentLight =
      Color(0xFF82B1FF); // Light blue for hover effects

  // Gradients
  static const Gradient kPrimaryGradient = LinearGradient(
    colors: [Color(0xFFFF6600), Color(0xFFFFA726)], // Vibrant orange gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient kAccentGradient = LinearGradient(
    colors: [Color(0xFF0066FF), Color(0xFF82B1FF)], // Blue gradient for CTAs
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Neutral Colors
  static const Color kLightGrey = Color(0xFFE0E0E0);
  static const Color kDarkGrey = Color(0xFF616161);

  // Success, Warning, Error
  static const Color kSuccess = Color(0xFF4CAF50); // Green
  static const Color kWarning = Color(0xFFFFC107); // Yellow
  static const Color kError = Color(0xFFF44336); // Red
}
