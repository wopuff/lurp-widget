import 'package:flutter/material.dart';
import 'package:lurp/src/core/widgets/progress_indicator.dart';

class PageOverlay {
  static OverlayEntry? _overlayEntry;
  static String? currentOverlay;

  // show a circular progress indicator
  static void showProgressIndicator(BuildContext context) {
    if (currentOverlay == 'progress') return;
    if (currentOverlay == 'message') hide();

    currentOverlay = 'progress';
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Material(
        color: Colors.black.withValues(alpha: 0.5),
        child: const Center(child: CustomProgressIndicator()),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  static Future<void> hide() async {
    currentOverlay = null;
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
