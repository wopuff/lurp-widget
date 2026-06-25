import 'package:flutter/material.dart';

class LayoutUtils {
  static const double maxContentWidth = 600.0;
  static const double standardPadding = 20.0;

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static double contentMaxWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width.clamp(0.0, maxContentWidth);
  }
}
