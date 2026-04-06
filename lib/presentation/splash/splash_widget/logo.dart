import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:saglixen/core/contants/app_assets.dart';

final class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(24),
                child: Image.asset(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  AppAssets.saglixLogo512.path,
                ),
              )
              .animate(
                onPlay: (controller) =>
                    controller.repeat(reverse: true),
              )
              .scale(
                begin: Offset(0.7, 0.7),
                end: Offset(1.10, 1.10),
                duration: 2000.ms,
                curve: Curves.easeInOut,
              ),
    );
  }
}
