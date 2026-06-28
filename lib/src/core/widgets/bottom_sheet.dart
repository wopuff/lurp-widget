import 'package:flutter/material.dart';
import 'package:lurp/src/core/entities/return_data.dart';
import 'package:lurp/src/core/widgets/appbar.dart';

class CustomBottomSheet {
  CustomBottomSheet({
    this.error,
    this.title = '',
    this.content,
    this.padding = EdgeInsets.zero,
    this.topMargin = 40,
  });
  final ReturnData? error;
  final String title;
  final Widget? content;
  final EdgeInsets padding;
  final double topMargin;

  void show(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide.none,
      ),
      constraints: BoxConstraints(
        maxWidth: 620,
        maxHeight: MediaQuery.of(context).size.height - topMargin,
      ),
      barrierColor: const Color.fromARGB(150, 0, 0, 0),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext buildContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(title: title, alwaysShowDivider: true),

              // content
              Flexible(
                child: Padding(
                  padding: padding,
                  child: content ?? const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BottomMenuItem extends StatelessWidget {
  const BottomMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.action,
  });
  final Widget icon;
  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 15),
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
