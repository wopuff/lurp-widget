import 'package:flutter/material.dart';
import 'package:lurp/src/config/theme/poll_colors.dart';
import 'package:lurp/src/config/theme/theme_values.dart';

class CustomOutline extends StatelessWidget {
  final Widget child;

  final bool putAboveChild;

  final double radius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool isRainbow;
  final bool isChristmas;
  final double gradientRotation;

  // outline
  final double width;
  final Color? color;
  final Gradient? gradient;

  // border around outline
  final double borderWidth;
  final Color? borderColor;

  const CustomOutline({
    super.key,
    required this.child,
    this.putAboveChild = false,
    this.width = 3,
    this.borderWidth = 0,
    this.color,
    this.gradient,
    this.padding,
    this.margin,
    this.isRainbow = false,
    this.isChristmas = false,
    this.radius = 0,
    this.borderColor,
    this.gradientRotation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      padding: padding ?? EdgeInsets.all(width - borderWidth),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(10),
        gradient: _gradient(),
        border: _border(context),
      ),
      child: child,
    );
  }

  Border? _border(BuildContext context) {
    if (borderWidth > 0) {
      return Border.all(
        color: borderColor ?? Theme.of(context).colorScheme.onSurface,
        width: borderWidth,
        strokeAlign: BorderSide.strokeAlignInside,
      );
    }
    return null;
  }

  Gradient? _gradient() {
    // christmas
    if (isChristmas) {
      List<Object> generateSegments(int n, Color color1, Color color2) {
        final List<Color> colors = [];
        final List<double> stops = [];
        final double unit = 1.0 / n;

        for (int i = 0; i < n; i++) {
          // Determine the color for the current segment
          final currentColor = (i % 2 == 0) ? color1 : color2;

          // Define the start and end point for the segment
          final startStop = i * unit;
          final endStop = (i + 1) * unit;

          // 1. Start the color at the start stop
          colors.add(currentColor);
          stops.add(startStop);

          // 2. End the color at the end stop, creating a hard edge
          colors.add(currentColor);
          stops.add(endStop);
        }
        return [colors, stops];
      }

      final result = generateSegments(
        15,
        ThemeValues.christmasRed,
        Colors.white,
      );
      final List<Color> segmentColors = result[0] as List<Color>;
      final List<double> segmentStops = result[1] as List<double>;

      return LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        transform: GradientRotation(gradientRotation),
        tileMode: TileMode.clamp,
        colors: segmentColors,
        stops: segmentStops,
      );
    }
    // rainbow
    else if (isRainbow) {
      return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        transform: GradientRotation(gradientRotation),
        colors: [
          for (int i in [3, 2, 1, 0, 3, 2, 1, 0, 3, 2]) PollColors.lightList[i],
        ],
      );
    }
    return null;
  }
}
