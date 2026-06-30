import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/color_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.action,
    this.text,
    this.isBackButton = false,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.textColor,
    this.borderRadius = 12.5,
    this.padding,
    this.fontWeight,
    this.borderColor,
    this.borderWidth,
    this.fixedSize,
    this.minSize,
  });
  final VoidCallback? action;
  final String? text;
  final bool isBackButton;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final Color? borderColor;
  final double? borderWidth;
  final Size? fixedSize;
  final Size? minSize;

  @override
  Widget build(BuildContext context) {
    final VoidCallback? finalAction = getFinalAction(context);

    return ElevatedButton(
      onPressed: finalAction,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        surfaceTintColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
        foregroundColor: textColor ?? Theme.of(context).colorScheme.onPrimary,
        disabledBackgroundColor:
            disabledBackgroundColor ??
            Theme.of(context).colorScheme.secondary.dim(1.3),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 2,
          ),
        ),
        fixedSize: fixedSize,
        minimumSize: fixedSize ?? minSize ?? const Size.fromHeight(65),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text ?? (isBackButton ? 'GO BACK' : 'CLICK HERE!'),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: finalAction != null
                  ? (textColor ?? Theme.of(context).colorScheme.onPrimary)
                  : (textColor?.dim(0.1) ??
                        Theme.of(context).colorScheme.onPrimary.dim(0.7)),
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  VoidCallback? getFinalAction(BuildContext context) {
    if (action != null) return action!;
    if (isBackButton) return () => Navigator.of(context).pop();
    return null;
  }
}
