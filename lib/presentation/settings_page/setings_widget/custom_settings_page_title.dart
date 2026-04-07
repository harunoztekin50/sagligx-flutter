import 'package:flutter/material.dart';
import 'package:saglixen/core/extension/contex_extension.dart';

class SettingPageTitle extends StatelessWidget {
  const SettingPageTitle({
    super.key,
    required this.leadingIcon,
    required this.traidingIcon,
    required this.title,
    required this.onTab,
  });

  final IconData leadingIcon;
  final IconData traidingIcon;
  final String title;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary,
              ),
              width: 33,
              height: 33,
              child: Icon(
                leadingIcon,
                color: context.colors.surface,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: context.colors.textPrimary,
              ),
            ),
            const Spacer(),
            Icon(traidingIcon, color: context.colors.textSecondary),
          ],
        ),
      ),
    );
  }
}
