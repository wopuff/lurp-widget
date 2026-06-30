import 'package:flutter/material.dart';

class AnimatedStats extends StatelessWidget {
  const AnimatedStats({
    super.key,
    required this.hasVoted,
    this.text,
    this.child,
  });
  final bool hasVoted;
  final String? text;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInCubic,
      opacity: hasVoted ? 1.0 : 0.0,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
        child: ClipRect(
          child: SizedBox(
            height: hasVoted ? null : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 3),
              child:
                  child ??
                  Text(
                    text ?? '',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
