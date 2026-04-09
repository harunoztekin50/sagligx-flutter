import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:saglixen/core/contants/app_assets.dart';
import 'package:saglixen/core/core_widgets/primary_buton.dart';
import 'package:saglixen/core/extension/contex_extension.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static PageTransition<dynamic> route() {
    return PageTransition(
      type: PageTransitionType.fade,
      childBuilder: (_) => LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginPageHeaderImage(size: size),
            LoginPageHeaderTitle(),
            LoginPageDesciriptionText(size: size),
            PrimaryButton(
              text: "Start Restoring",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              heigth: 50,
              callback: () {
                HapticFeedback.lightImpact();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPageDesciriptionText extends StatelessWidget {
  const LoginPageDesciriptionText({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 7,
          ),
          child: Text(
            textAlign: TextAlign.center,
            "Eksi aile fotoğraflarını canlandırın ve güzeleleştiren yardımcı AI asistanı",
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
                TextSpan(text: "Bring Your Past\n"),
                TextSpan(
                  text: "Back to life",
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
  const LoginPageHeaderImage({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
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
                  "Saglix AI",
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

        /* 
        Positioned(
          bottom: size.height * 0.05,
          right: 0,
          left: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                //context.read<AuthCubit>().loginAnonymus();
              },
              child: Text("Login"),
            ),
          ),
        ), */
      ],
    );
  }
}
