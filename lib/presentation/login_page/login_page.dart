import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saglixen/application/auth_cubit/auth_cubit.dart';
import 'package:saglixen/core/contants/app_assets.dart';
import 'package:saglixen/core/contants/string_constansts.dart';
import 'package:saglixen/core/core_widgets/primary_buton.dart';
import 'package:saglixen/core/extension/contex_extension.dart';
import 'package:saglixen/core/extension/dart_extension.dart';
import 'package:saglixen/core/failure/handle_failure.dart';
import 'package:saglixen/core/widgets_wraper/scale_tap_efekt.dart';
import 'package:saglixen/presentation/home_page/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static PageTransition<dynamic> route() {
    return PageTransition(
      type: PageTransitionType.fade,
      childBuilder: (_) => const LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthCubitState>(
            listenWhen: (previous, current) {
              return previous.userOption.isNone() &&
                  current.userOption.isSome();
            },
            listener: (context, state) async {
              await Navigator.pushReplacement(
                context,
                HomePage.route(),
              );
            },
          ),
          BlocListener<AuthCubit, AuthCubitState>(
            listenWhen: (previous, current) {
              return previous.processFailOption.isNone() &&
                  current.processFailOption.isSome();
            },
            listener: (context, state) {
              handleFailure(
                context,
                state.processFailOption.getOrCrash(),
              );
            },
          ),
        ],
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginPageHeaderImage(size: size),
              const LoginPageHeaderTitle(),
              LoginPageDesciriptionText(size: size),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: PrimaryButton(
                  text: StringConstants.startButtonText,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  heigth: 50,
                  callback: HapticFeedback.lightImpact,
                ),
              ),
              const LoginPaheHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPaheHaveAccount extends StatelessWidget {
  const LoginPaheHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          StringConstants.haveAccountText,
          style: TextStyle(
            color: context.colors.textSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            StringConstants.loginText,
            style: TextStyle(
              fontSize: 18,
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ).scaleTap(
          onTap: () async {
            await context.read<AuthCubit>().loginAnonymus();
          },
        ),
      ],
    );
  }
}

class LoginPageDesciriptionText extends StatelessWidget {
  const LoginPageDesciriptionText({required this.size, super.key});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 7,
          ),
          child: Text(
            textAlign: TextAlign.center,
            StringConstants.descriptionText,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 25,
              color: context.colors.textSecondary,
            ),
          ),
        ),
        Divider(
          endIndent: size.width * 0.2,
          indent: size.width * 0.2,
          color: context.colors.primary,
          thickness: 2,
        ),
      ],
    );
  }
}

class LoginPageHeaderTitle extends StatelessWidget {
  const LoginPageHeaderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      color: context.colors.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: context.colors.textPrimary,
              ),
              children: [
                const TextSpan(
                  text: StringConstants.headerTitleLine1,
                ),
                TextSpan(
                  text: StringConstants.headerTitleLine2,
                  style: TextStyle(
                    color: context.colors.primary,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPageHeaderImage extends StatelessWidget {
  const LoginPageHeaderImage({required this.size, super.key});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppAssets.carLogo.path,
          width: size.width,
          height: size.height * 0.6,
          fit: BoxFit.fitHeight,
        ),

        Positioned(
          bottom: size.height * 0.06,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  indent: size.width * 0.3,
                  color: context.colors.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  StringConstants.brandName,
                  style: TextStyle(
                    fontFamily: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                    ).fontFamily,
                    fontSize: 30,
                    color: context.colors.primary,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  endIndent: size.width * 0.3,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          child: Container(
            height: 170,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: [
                  Colors.transparent,
                  Colors.blueAccent.shade100.withValues(alpha: 0.2),
                  Colors.blueAccent.shade100.withValues(alpha: 0.4),
                  Colors.blueAccent.shade100.withValues(alpha: 0.6),
                  Colors.blueAccent.shade100.withValues(alpha: 0.8),
                  context.colors.background,
                  context.colors.surface,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
