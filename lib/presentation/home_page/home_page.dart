import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saglixen/application/botom_nav_bar/botom_nav_bar_cubit.dart';
import 'package:saglixen/presentation/album_page/album_page.dart';
import 'package:saglixen/presentation/home_page/home_page_mixin.dart';
import 'package:saglixen/presentation/home_page/home_page_widget/botom_bar.dart';
import 'package:saglixen/presentation/settings_page/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage._();

  static PageTransition<dynamic> route() {
    return PageTransition(
      type: PageTransitionType.fade,
      childBuilder: (_) => HomePage._(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BotomNavBarCubit, BotomNavBarState>(
      listener: (context, state) {
        controler.jumpToPage(state.curentIndex);
      },
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controler,
          children: BotomNavBarTab.values.map((i) {
            switch (i) {
              case BotomNavBarTab.album:
                return AlbumPage();
              case BotomNavBarTab.settings:
                return SettingPage();
            }
          }).toList(),
        ),

        bottomNavigationBar: HomePageBotomBar(),
      ),
    );
  }
}
