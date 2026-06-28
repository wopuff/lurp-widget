import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/core/widgets/outline.dart';

class PollOptionButton extends StatelessWidget {
  const PollOptionButton({
    super.key,
    required this.isActive,
    required this.buttonWidth,
    required this.buttonHeight,
    this.text = '',
    this.optionColor,
    this.proportion = 0,
    this.onPressed,
    this.singleColumn = false,
    this.showBorder = false,
  });
  final bool isActive;
  final double buttonWidth;
  final double? buttonHeight;
  final String text;
  final Color? optionColor;
  final double proportion;
  final VoidCallback? onPressed;
  final bool singleColumn;
  final bool showBorder;

  double get fontSize {
    double fontSize = 17;
    if (graphemeLength(text) <= 4 && isOnlyEmojis(text)) {
      fontSize = 27;
    } else if (text.length <= 21) {
      fontSize += (3 - text.length / 7);
    }
    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = 2;

    return CustomOutline(
      isRainbow: false,
      isChristmas: false,
      gradientRotation: proportion * pi + 0.5 * pi,
      width: borderWidth,
      color: showBorder
          ? Colors.white
          : Theme.of(context).colorScheme.secondary,
      radius: 10,
      putAboveChild: true,
      borderWidth: 0,
      borderColor: Theme.of(context).colorScheme.onSurface,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10 - borderWidth),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: buttonHeight == null
                ? Size.fromWidth(buttonWidth - borderWidth * 2)
                : Size(
                    buttonWidth - borderWidth * 2,
                    buttonHeight! - borderWidth * 2,
                  ),
            padding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            surfaceTintColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: Theme.of(context).colorScheme.onSecondary,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInCubic,
                    width: (isActive && buttonWidth * proportion > 0)
                        ? buttonWidth * proportion
                        : 0,
                    decoration: BoxDecoration(
                      color: optionColor,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.5,
                    vertical: 2.5,
                  ),
                  child: Align(
                    alignment: singleColumn
                        ? Alignment.centerLeft
                        : Alignment.center,
                    child: Text(
                      text,
                      textAlign: singleColumn
                          ? TextAlign.left
                          : TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
