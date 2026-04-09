import 'package:flutter/material.dart';
import 'package:saglixen/core/extension/contex_extension.dart';
import 'package:saglixen/core/widgets_wraper/scale_tap_efekt.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.heigth,
    required this.fontSize,
    required this.fontWeight,
    required this.callback,
  });

  final String text;
  final double heigth;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: heigth,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
    ).scaleTap(onTap: callback);
  }
}
