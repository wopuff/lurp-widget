import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/color_utils.dart';

class PostInfoBarButton extends StatelessWidget {
  const PostInfoBarButton({
    super.key,
    this.child,
    this.action,
    this.isActive = false,
    this.roundedLeft = true,
    this.roundedRight = true,
    this.spacingRight = false,
    this.connectedSpacing = false,
    this.minWidth,
    this.padding,
    this.iconPath,
    this.iconSize = 14,
  });
  final Widget? child;
  final String? iconPath;
  final VoidCallback? action;
  final bool isActive;

  final bool roundedLeft;
  final bool roundedRight;

  final bool spacingRight;
  final bool connectedSpacing;

  final double? minWidth;
  final EdgeInsets? padding;
  final double iconSize;

  static const double _height = 30;
  static const double _radius = 10;
  static const double _smallRadius = 3.5;
  static const double _minWidth = 40;
  static const double _spacing = 4;
  static const double _connectedSpacing = 2.5;

  IconData _getIcon() {
    if (iconPath == null) return Icons.share;
    if (iconPath!.contains('share')) return Icons.share;
    if (iconPath!.contains('menu') || iconPath!.contains('more')) {
      return Icons.more_vert;
    }
    return Icons.share;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: spacingRight
            ? (connectedSpacing ? _connectedSpacing : _spacing)
            : 0,
      ),
      child: ElevatedButton(
        onPressed: action,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(roundedLeft ? _radius : _smallRadius),
              right: Radius.circular(roundedRight ? _radius : _smallRadius),
            ),
            side: BorderSide.none,
          ),
          backgroundColor: isActive
              ? Theme.of(context).colorScheme.onSurface.withAlpha(65)
              : Theme.of(context).colorScheme.surface,
          disabledBackgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          padding: padding ?? EdgeInsets.zero,
          minimumSize: Size(minWidth ?? _minWidth, _height + 10),
        ),
        child:
            child ??
            Icon(
              _getIcon(),
              color: Theme.of(context).colorScheme.onSurface.dim(0.5),
              size: iconSize,
            ),
      ),
    );
  }
}
