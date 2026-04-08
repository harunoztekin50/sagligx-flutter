import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/core/extension/contex_extension.dart';
import 'package:saglixen/presentation/home_page/home_page.dart';
import 'package:saglixen/presentation/login_page/login_page.dart';
import 'package:saglixen/presentation/splash/splash_mixin.dart';
import 'package:saglixen/presentation/splash/splash_widget/logo.dart';

final class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SplashMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthCubitState>(
          listenWhen: (previous, current) =>
              previous.userOption.isNone() &&
              current.userOption.isSome(),
          listener: (context, state) =>
              Navigator.pushReplacement(context, HomePage.route()),
        ),
        BlocListener<AuthCubit, AuthCubitState>(
          listenWhen: (previous, current) =>
              previous.processFailOption.isNone() &&
              current.processFailOption.isSome(),
          listener: (context, state) =>
              Navigator.pushReplacement(context, LoginPage.route()),
        ),
      ],
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                SplashLogo(size: size),
                _fromText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align _fromText(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        "from Harun",
        style: context.textTheme.headlineSmall?.copyWith(
          color: context.colors.textPrimary,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
