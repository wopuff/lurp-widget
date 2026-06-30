import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key, this.color, this.size = 40});
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final dotSize = size * 0.2;

    return SizedBox(
      width: size,
      height: dotSize * 2,
      child: _ThreeBounceDots(
        color: color ?? Theme.of(context).colorScheme.onSurface,
        dotSize: dotSize,
      ),
    );
  }
}

class _ThreeBounceDots extends StatefulWidget {
  const _ThreeBounceDots({required this.color, required this.dotSize});
  final Color color;
  final double dotSize;

  @override
  State<_ThreeBounceDots> createState() => _ThreeBounceDotsState();
}

class _ThreeBounceDotsState extends State<_ThreeBounceDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(double offset) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = (_controller.value + offset) % 1.0;
        const minScale = 0.55;
        final scale = minScale + (1.0 - minScale) * (0.5 - (t - 0.5).abs()) * 2;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDot(0.0), // First dot
        _buildDot(0.2), // Slightly later
        _buildDot(0.4), // Even later
      ],
    );
  }
}
