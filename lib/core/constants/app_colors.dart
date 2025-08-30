import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const primaryPurple = Color(0xFF8B5CF6);
  static const primaryPink = Color(0xFFEC4899);
  static const primaryOrange = Color(0xFFF97316);
  static const primaryGreen = Color(0xFF4ECDC4);
  static const primaryBlue = Color(0xFF45B7D1);

  // Accent Colors
  static const accentPurple = Color(0xFFA78BFA);
  static const accentPink = Color(0xFFF472B6);
  static const accentOrange = Color(0xFFFB923C);
  static const accentGreen = Color(0xFF96CEB4);
  static const accentYellow = Color(0xFFFBBF24);

  // Background Colors
  static const backgroundLight = Color(0xFFFFF5F5);
  static const backgroundCard = Color(0xFFFFFFFF);
  static const backgroundGradientStart = Color(0xFFFFF1F2);
  static const backgroundGradientMiddle = Color(0xFFFFF7ED);
  static const backgroundGradientEnd = Color(0xFFFEF9C3);

  // Text Colors
  static const textDark = Color(0xFF1F2937);
  static const textMedium = Color(0xFF6B7280);
  static const textLight = Color(0xFF9CA3AF);
  static const textWhite = Color(0xFFFFFFFF);

  // Status Colors
  static const successGreen = Color(0xFF34D399);
  static const warningOrange = Color(0xFFFBBF24);
  static const errorRed = Color(0xFFEF4444);

  // Border and Shadow Colors
  static const borderColor = Color(0xFFE5E7EB);
  static const shadowColor = Color(0xFF000000);

  // Navigation Colors
  static const primaryNavy = Color(0xFF1F2937);
  static const navSelected = primaryPurple;
  static const navUnselected = textLight;

  // Utility Colors
  static const primaryWhite = Color(0xFFFFFFFF);
  static const primaryBlack = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  // Gradient Colors
  static List<Color> purpleToOrangeGradient = [
    primaryPurple,
    primaryPink,
    primaryOrange,
  ];

  static List<Color> purpleToPinkGradient = [
    primaryPurple,
    primaryPink,
  ];

  static List<Color> greenToTealGradient = [
    primaryGreen,
    accentGreen,
  ];

  static List<Color> blueToIndigoGradient = [
    primaryBlue,
    primaryPurple,
  ];

  // Background Gradient
  static List<Color> backgroundGradient = [
    backgroundGradientStart,
    backgroundGradientMiddle,
    backgroundGradientEnd,
  ];
}