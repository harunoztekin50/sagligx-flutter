import 'package:flutter/material.dart';
import 'package:saglixen/core/app_init/app_init.dart';
import 'package:saglixen/core/theme/app_theme.dart';
import 'package:saglixen/presentation/splash/splash_page.dart';

void main() async {
  await AppInit.initialize();
  runApp(AppInit.providers(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Saglix",
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: SplashPage(),
    );
  }
}
