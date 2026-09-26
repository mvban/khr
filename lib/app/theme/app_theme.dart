import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color terracotta = Color(0xFFB84A2E);
  static const Color terracottaLight = Color(0xFFD96B4E);
  static const Color bananaLeafGreen = Color(0xFF2E6F40);
  static const Color bananaLeafLight = Color(0xFF47915B);
  static const Color turmericGold = Color(0xFFE69F1D);
  static const Color sandBackground = Color(0xFFFAF7F2);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color darkCharcoal = Color(0xFF1A1817);
  static const Color mutedText = Color(0xFF6B6661);
  static const Color chipBackground = Color(0xFFEFE8DF);
  static const Color borderGrey = Color(0xFFE2D9CE);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.outfitTextTheme();
    final headerTextTheme = GoogleFonts.playfairDisplayTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: terracotta,
        secondary: bananaLeafGreen,
        tertiary: turmericGold,
        surface: cardSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkCharcoal,
      ),
      scaffoldBackgroundColor: sandBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: terracotta,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: headerTextTheme.titleLarge?.copyWith(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardSurface,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderGrey, width: 0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: terracotta,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: baseTextTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: terracotta,
          side: const BorderSide(color: terracotta, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: baseTextTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: chipBackground,
        selectedColor: bananaLeafGreen,
        secondarySelectedColor: terracotta,
        labelStyle: baseTextTheme.bodyMedium?.copyWith(color: darkCharcoal),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide.none,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: headerTextTheme.displayLarge?.copyWith(color: darkCharcoal, fontWeight: FontWeight.bold),
        displayMedium: headerTextTheme.displayMedium?.copyWith(color: darkCharcoal, fontWeight: FontWeight.bold),
        headlineLarge: headerTextTheme.headlineLarge?.copyWith(color: darkCharcoal, fontWeight: FontWeight.bold),
        headlineMedium: headerTextTheme.headlineMedium?.copyWith(color: darkCharcoal, fontWeight: FontWeight.w700),
        titleLarge: headerTextTheme.titleLarge?.copyWith(color: darkCharcoal, fontWeight: FontWeight.w700),
        titleMedium: baseTextTheme.titleMedium?.copyWith(color: darkCharcoal, fontWeight: FontWeight.w600),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: darkCharcoal),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: darkCharcoal),
        bodySmall: baseTextTheme.bodySmall?.copyWith(color: mutedText),
      ),
    );
  }
}
