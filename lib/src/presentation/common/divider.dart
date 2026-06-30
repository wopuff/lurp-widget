import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
    this.vertical = false,
    this.thickness = 3,
    this.height = 3,
    this.width = 3,
    this.color,
    this.padding = EdgeInsets.zero,
  });
  final bool vertical;
  final double thickness;
  final double height;
  final double width;
  final Color? color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // vertical
    if (vertical) {
      return Padding(
        padding: padding,
        child: VerticalDivider(
          thickness: thickness,
          width: width,
          color: color ?? Theme.of(context).colorScheme.surface,
        ),
      );
    }

    // horizontal
    return Padding(
      padding: padding,
      child: Divider(
        thickness: thickness,
        height: height,
        color: color ?? Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
