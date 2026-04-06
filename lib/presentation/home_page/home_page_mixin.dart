import 'package:flutter/material.dart';
import 'package:saglixen/presentation/home_page/home_page.dart';

mixin HomePageMixin on State<HomePage> {
  late final PageController controler;

  @override
  void initState() {
    super.initState();
    controler = PageController();
  }

  @override
  void dispose() {
    controler.dispose();
    super.dispose();
  }
}
