import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Teal/Turquoise Theme (from Ngajii)
  static const Color primary = Color(0xFF1BA098); // Teal
  static const Color primaryLight = Color(0xFF26B3A8);
  static const Color primaryDark = Color(0xFF0F8A82);

  // Secondary Colors - Beige/Tan Theme (from Quran app)
  static const Color secondary = Color(0xFFD4A574); // Gold/Tan
  static const Color secondaryLight = Color(0xFFE8C4A0);
  static const Color accent = Color(0xFF8B6F47); // Brown

  // Dark Green Theme (from NurSalam)
  static const Color darkTheme = Color(0xFF1B4D4D);
  static const Color darkThemeLight = Color(0xFF2D6666);

  // Light Theme
  static const Color lightBackground = Color(0xFFFBF8F3); // Warm cream
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightSubText = Color(0xFF6B6B6B);
  static const Color lightDivider = Color(0xFFE8E3D8);

  // Dark Theme
  static const Color darkBackground = Color(0xFF0F3D3D); // Dark teal
  static const Color darkCardBackground = Color(0xFF1A5A5A);
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkSubText = Color(0xFFB0B0B0);
  static const Color darkDivider = Color(0xFF2D6666);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFBC02D);
  static const Color info = Color(0xFF1976D2);

  // Prayer Times Colors
  static const Color fajrColor = Color(0xFF6A4C93); // Purple
  static const Color dhuhrColor = Color(0xFFFFA500); // Orange
  static const Color asrColor = Color(0xFFFF6B35); // Orange-red
  static const Color maghribColor = Color(0xFFD4A574); // Gold
  static const Color ishaColor = Color(0xFF264653); // Dark blue

  // Gradient Colors - Teal
  static const List<Color> gradientColorsTeal = [
    Color(0xFF1BA098),
    Color(0xFF0F8A82),
  ];

  // Gradient Colors - Beige
  static const List<Color> gradientColorsBeige = [
    Color(0xFFD4A574),
    Color(0xFF8B6F47),
  ];

  // Gradient Colors - Dark Green
  static const List<Color> gradientColorsDark = [
    Color(0xFF1B4D4D),
    Color(0xFF0F3D3D),
  ];

  // Islamic Card Gradient
  static const List<Color> arabicCardGradient = [
    Color(0xFF1BA098),
    Color(0xFFD4A574),
  ];

  // Backgrounds for cards
  static const Color fajrBg = Color(0xFFF3E5F5); // Light purple
  static const Color dhuhrBg = Color(0xFFFFF3E0); // Light orange
  static const Color asrBg = Color(0xFFFFEBEE); // Light red
  static const Color maghribBg = Color(0xFFFFF8E1); // Light yellow
  static const Color ishaBg = Color(0xFFE0F2F1); // Light teal
}
