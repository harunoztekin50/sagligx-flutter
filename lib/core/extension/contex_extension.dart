import 'package:flutter/material.dart';
import 'package:saglixen/core/contants/app_color_theme.dart';

extension BuildContextExt on BuildContext {
  AppColorTheme get colors {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? AppColorTheme.dark()
        : AppColorTheme.ligth();
  }

  TextTheme get textTheme => Theme.of(this).textTheme;
}
