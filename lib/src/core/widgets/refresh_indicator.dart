import 'dart:math';
import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatefulWidget {
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.size = 32,
  });
  final Widget child;
  final Future<void> Function() onRefresh;
  final double size;

  @override
  State<CustomRefreshIndicator> createState() => _CustomRefreshIndicatorState();
}

class _CustomRefreshIndicatorState extends State<CustomRefreshIndicator>
    with SingleTickerProviderStateMixin {
  static const double triggerDistance = 100;

  double dragOffset = 0;
  bool isRefreshing = false;

  late final AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  Future<void> _startRefresh() async {
    setState(() => isRefreshing = true);
    _spinController.repeat();

    await widget.onRefresh();

    _spinController.stop();
    setState(() {
      dragOffset = 0;
      isRefreshing = false;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    final atTop = notification.metrics.extentBefore == 0;

    if (notification is ScrollUpdateNotification && atTop && !isRefreshing) {
      setState(() {
        dragOffset -= notification.scrollDelta ?? 0;
        dragOffset = dragOffset.clamp(0.0, 150.0);
      });
    }

    if (notification is ScrollEndNotification &&
        dragOffset >= triggerDistance &&
        !isRefreshing) {
      _startRefresh();
    }

    if (notification is ScrollEndNotification && !isRefreshing) {
      setState(() => dragOffset = 0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (dragOffset / triggerDistance).clamp(0.0, 1.0);
    final double angle = isRefreshing
        ? _spinController.value * 2 * pi
        : progress * 2 * pi;

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Stack(
        children: [
          widget.child,
          if (dragOffset > 0 || isRefreshing)
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Center(
                child: Transform.rotate(
                  angle: angle,
                  child: Icon(
                    Icons.refresh,
                    size: widget.size,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
