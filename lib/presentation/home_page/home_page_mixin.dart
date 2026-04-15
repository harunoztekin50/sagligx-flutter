import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saglixen/application/botom_nav_bar/botom_nav_bar_cubit.dart';
import 'package:saglixen/presentation/home_page/home_page.dart';

mixin HomePageMixin on State<HomePage> {
  late final PageController controler;

  @override
  void initState() {
    super.initState();
    controler = PageController();
    context.read<BotomNavBarCubit>().selcetTab(BotomNavBarTab.album);
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }
}
