import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/core/contants/string_constansts.dart';
import 'package:saglixen/core/extension/contex_extension.dart';
import 'package:saglixen/presentation/settings_page/setings_widget/custom_setings_appbar.dart';
import 'package:saglixen/presentation/settings_page/setings_widget/custom_settings_page_title.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomSetingsAppbar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: context.colors.surface,
                  border: Border.all(color: context.colors.border),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SettingPageTitle(
                      leadingIcon: LucideIcons.circleQuestionMark,
                      traidingIcon: Icons.launch,
                      title: StringConstants.helpCenter,
                      onTab: HapticFeedback.lightImpact,
                    ),

                    const Divider(),

                    SettingPageTitle(
                      leadingIcon: Icons.exit_to_app_outlined,
                      traidingIcon: Icons.chevron_right_outlined,
                      title: StringConstants.logOut,
                      onTab: () async {
                        await HapticFeedback.lightImpact();
                        if (!context.mounted) return;
                        await context.read<AuthCubit>().logOut();
                        debugPrint('logout çalıştı');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
