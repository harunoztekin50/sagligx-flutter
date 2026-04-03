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
      background: Color(0xFFFDFBF7),
      surface: Color(0xFFFFFFFF),
      primary: Color(0xFFD4A373),
      textPrimary: Color(0xFF2c241b),
      textSecondary: Color(0xFF857f72),
      border: Color(0xFFF2F2F2),
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
