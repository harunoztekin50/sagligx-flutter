import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglixen/core/contants/app_color_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() =>
      _buildTheme(AppColorTheme.ligth(), Brightness.light);
  static ThemeData dark() =>
      _buildTheme(AppColorTheme.dark(), Brightness.dark);

  static ThemeData _buildTheme(
    AppColorTheme colors,
    Brightness brightness,
  ) {
    return ThemeData(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      brightness: brightness,
      scaffoldBackgroundColor: colors.background,
      colorScheme: brightness == Brightness.light
          ? ColorScheme.light(
              primary: colors.primary,
              surface: colors.surface,
              onSurface: colors.textPrimary,
            )
          : ColorScheme.dark(
              primary: colors.primary,
              surface: colors.surface,
              onPrimary: Colors.white,
              onSurface: colors.textPrimary,
            ),
      textTheme: GoogleFonts.nunitoTextTheme().copyWith(
        displayLarge: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: colors.textPrimary,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colors.textPrimary,
        ),
        bodyLarge: GoogleFonts.nunito(
          fontSize: 16,
          color: colors.textPrimary,
        ),
        bodyMedium: GoogleFonts.nunito(
          fontSize: 14,
          color: colors.textSecondary,
        ),
        labelSmall: GoogleFonts.nunito(
          fontSize: 12,
          color: colors.textSecondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        hintStyle: GoogleFonts.nunito(
          color: colors.textSecondary,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.border,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colors.border),
        ),
      ),
    );
  }
}
