import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lurp/src/core/entities/common.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final int? maxLength;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final bool autoFocus;
  final void Function(String)? onChange;
  final Color? backgroundColor;
  final Color? selectionColor;
  final Color? textColor;
  final Color? cursorColor;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final bool allowEnter;
  final Border? border;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final double? height;
  final double? minHeight;
  final bool enabled;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.maxLength = User.maxUsernameLength,
    this.obscureText = false,
    this.textInputType = TextInputType.multiline,
    this.textCapitalization = TextCapitalization.sentences,
    this.autoFocus = false,
    this.onChange,
    this.padding,
    this.focusNode,
    this.backgroundColor,
    this.selectionColor,
    this.textColor,
    this.cursorColor,
    this.allowEnter = false,
    this.border,
    this.borderRadius,
    this.maxLines,
    this.height,
    this.minHeight,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(12.5),
        border:
            border ??
            Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
      ),
      child: Row(
        children: [
          Flexible(
            child: Theme(
              data: Theme.of(context).copyWith(
                textSelectionTheme: TextSelectionThemeData(
                  selectionColor: selectionColor,
                ),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                obscureText: obscureText,
                maxLength: maxLength,
                keyboardType: textInputType,
                textCapitalization: textCapitalization,
                autofocus: autoFocus,
                autocorrect: true,
                maxLines: maxLines,
                canRequestFocus: true,
                keyboardAppearance: Theme.of(context).brightness,
                enableInteractiveSelection: true,
                dragStartBehavior: DragStartBehavior.down,
                textInputAction: allowEnter
                    ? TextInputAction.newline
                    : TextInputAction.done,
                inputFormatters: allowEnter
                    ? null
                    : [FilteringTextInputFormatter.deny(RegExp(r'\n'))],
                scrollPadding: const EdgeInsets.all(0),
                autofillHints: const [],
                onChanged: onChange,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color:
                        textColor?.withValues(alpha: 0.6) ??
                        Theme.of(
                          context,
                        ).colorScheme.onSecondary.withValues(alpha: 0.6),
                  ),
                  contentPadding: padding ?? const EdgeInsets.all(10),
                  border: InputBorder.none,
                  filled: false,
                  counterText: '',
                  enabled: enabled,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                cursorColor:
                    cursorColor ??
                    textColor ??
                    Theme.of(context).colorScheme.onSurface,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: textColor ?? Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
