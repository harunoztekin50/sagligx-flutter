import 'package:flutter/material.dart';
import 'package:saglixen/core/contants/string_constansts.dart';
import 'package:saglixen/core/extension/contex_extension.dart';

class CustomSetingsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomSetingsAppbar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: context.colors.primary,
      elevation: 0.3,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: context.colors.textPrimary,
      ),
      backgroundColor: context.colors.surface,
      title: const Text(StringConstants.settings),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
