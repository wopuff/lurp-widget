import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lurp/src/core/utils/color_utils.dart';
import 'package:lurp/src/core/utils/layout_utils.dart';

class SmartText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Color? viewMoreColor;
  final bool isSelectable;

  const SmartText({
    super.key,
    required this.text,
    this.style,
    this.viewMoreColor,
    this.isSelectable = true,
  });

  @override
  State<SmartText> createState() => _SmartTextState();

  static const int initialTextRowCount = 8;
  static const int textRowIncrement = 12;
}

class _SmartTextState extends State<SmartText> {
  int _textRowCount = SmartText.initialTextRowCount;
  bool _isOverflowing = false;
  double? _textHeight;
  int _textRowIncrement = SmartText.textRowIncrement;
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  Future<void> _handleLinkTap(String urlString) async {
    final Uri url = Uri.parse(
      urlString.startsWith('http') ? urlString : 'https://$urlString',
    );
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not open link: $urlString')),
          );
        }
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open link: $urlString')),
        );
      }
    }
  }

  void _checkOverflow() {
    if (!mounted) return;
    final double width = LayoutUtils.contentMaxWidth(context) - 51;
    final baseStyle = widget.style ?? Theme.of(context).textTheme.bodyMedium;

    final spans = _buildSpans(baseStyle);

    final textPainter = TextPainter(
      text: TextSpan(style: baseStyle, children: spans),
      maxLines: _textRowCount,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: width);

    setState(() {
      _isOverflowing = textPainter.didExceedMaxLines;
      _textHeight = textPainter.height;
    });
  }

  void _viewMorePressed() {
    _textRowCount += _textRowIncrement;
    _textRowIncrement += 4;
    _checkOverflow();
  }

  List<InlineSpan> _buildSpans(TextStyle? baseStyle) {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final RegExp linkRegExp = RegExp(
      r'(https?:\/\/[^\s]+)|(www\.[^\s]+)',
      caseSensitive: false,
    );

    final List<InlineSpan> spans = [];
    int start = 0;

    final colorScheme = Theme.of(context).colorScheme;
    final linkStyle = TextStyle(
      color: colorScheme.primary,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );

    for (final Match match in linkRegExp.allMatches(widget.text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: widget.text.substring(start, match.start)));
      }

      final String url = match.group(0)!;
      final recognizer = TapGestureRecognizer()
        ..onTap = () => _handleLinkTap(url);
      _recognizers.add(recognizer);

      spans.add(TextSpan(text: url, style: linkStyle, recognizer: recognizer));
      start = match.end;
    }

    if (start < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(start)));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final baseStyle = widget.style ?? textTheme.bodyMedium;
    final spans = _buildSpans(baseStyle);

    final baseTextContent = Text.rich(
      TextSpan(children: spans),
      style: baseStyle,
      maxLines: _textRowCount,
      overflow: TextOverflow.ellipsis,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          height: _textHeight,
          child: ClipRect(
            child: widget.isSelectable
                ? SelectionArea(child: baseTextContent)
                : baseTextContent,
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          opacity: _isOverflowing ? 1 : 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            height: _isOverflowing ? 20 : 0,
            child: GestureDetector(
              onTap: _isOverflowing ? _viewMorePressed : null,
              child: MouseRegion(
                cursor: _isOverflowing
                    ? SystemMouseCursors.click
                    : MouseCursor.uncontrolled,
                child: Text(
                  'View more',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:
                        widget.viewMoreColor ??
                        Theme.of(context).colorScheme.onSurface.dim(0.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
