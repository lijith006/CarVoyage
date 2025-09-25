// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  double? height, width;
  String? text;
  Color? color;
  final Widget child;
  final VoidCallback? onTap;

  AppButton(
      {super.key,
      this.text,
      this.color = const Color.fromARGB(233, 231, 227, 227),
      this.height,
      this.width,
      required this.onTap,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: color),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
