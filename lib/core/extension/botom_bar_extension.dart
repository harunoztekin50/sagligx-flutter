import 'package:flutter/material.dart';
import 'package:saglixen/application/botom_nav_bar/botom_nav_bar_cubit.dart';

extension BotomNavBarTabExtension on BotomNavBarTab {
  BottomNavigationBarItem get barItem =>
      BottomNavigationBarItem(icon: Icon(icon), label: label);
}
