import 'package:flutter/material.dart';

class AppColorTheme {
  final Color background;
  final Color surface;
  final Color primary;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  factory AppColorTheme.ligth() {
    return AppColorTheme._(
      background: const Color(0xFFFDFBF7),
      surface: const Color(0xFFFFFFFF),
      primary: const Color(0xFFD4A373),
      textPrimary: const Color(
        0xFF1A1A2E,
      ), // neredeyse siyah, background'a karşı güçlü
      textSecondary: const Color(
        0xFF4A4A6A,
      ), // soluk değil ama primary kadar koyu da değil
      border: const Color.fromARGB(255, 219, 208, 196),
    );
  }

  factory AppColorTheme.dark() {
    return AppColorTheme._(
      background: Color(
        0xFF1A1612,
      ), // light background'un karanlık versiyonu
      surface: Color(
        0xFF2A2420,
      ), // light surface'in karanlık versiyonu
      primary: Color(0xFFD4A373), // primary aynı kalır — marka rengi
      textPrimary: Color(0xFFF5EFE6), // light textPrimary'nin tersi
      textSecondary: Color(0xFFADA89C), // biraz açık gri
      border: Color(0xFF3A3430), // dark surface'e uygun border
    );
  }

  AppColorTheme._({
    required this.background,
    required this.surface,
    required this.primary,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });
}
