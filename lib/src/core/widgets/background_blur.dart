import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundBlur extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final BorderRadius? customBorderRadius;
  final double blur;

  const BackgroundBlur({
    super.key,
    required this.child,
    this.customBorderRadius,
    this.borderRadius = 12.5,
    this.blur = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: customBorderRadius ?? BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: child,
      ),
    );
  }
}
