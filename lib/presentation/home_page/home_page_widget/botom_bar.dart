import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/application/botom_nav_bar/botom_nav_bar_cubit.dart';
import 'package:saglixen/core/extension/botom_bar_extension.dart';
import 'package:saglixen/core/extension/contex_extension.dart';

class HomePageBotomBar extends StatelessWidget {
  const HomePageBotomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BotomNavBarCubit, BotomNavBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: context.colors.surface,
          currentIndex: state.curentIndex,
          onTap: (value) {
            context.read<BotomNavBarCubit>().selcetTab(
              BotomNavBarTab.values[value],
            );
          },
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          selectedItemColor: context.colors.primary,
          unselectedItemColor: context.colors.textSecondary,
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
          items: state.tabs.map((tab) => tab.barItem).toList(),
        );
      },
    );
  }
}
