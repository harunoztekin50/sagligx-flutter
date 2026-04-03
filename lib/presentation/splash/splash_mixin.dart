import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/presentation/splash/splash_page.dart';

mixin SplashMixin on State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authCubit = context.read<AuthCubit>();
      authCubit.initialize();
    });
  }
}
