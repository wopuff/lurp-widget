import 'package:flutter/material.dart';

class PostTitle extends StatelessWidget {
  const PostTitle({super.key, required this.title, this.padding});
  final String title;
  final EdgeInsets? padding;

  double get titleFontSize {
    // decide title font size based on title length
    double titleFontSize = 18;
    if (title.length >= 120) {
      titleFontSize = 17;
    }
    return titleFontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 2),
      child: SelectableText(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: titleFontSize,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
