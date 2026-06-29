import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconAsset extends StatelessWidget {
  const IconAsset(
    this.asset, {
    super.key,
    this.color,
    this.size,
    this.width,
    this.height,
  });

  final String asset;
  final Color? color;
  final double? size;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      package: 'lurp',
      height: height ?? size,
      width: width ?? size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
