import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/url_launcher.dart';

class AppLink extends StatelessWidget {
  const AppLink({
    super.key,
    required this.text,
    required this.link,
    this.style,
    this.color,
  });
  final String text;
  final String link;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => UrlLauncherUtils.openUrl(link),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            text,
            style:
                style ??
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: color ?? Theme.of(context).colorScheme.onSurface,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ),
    );
  }
}
