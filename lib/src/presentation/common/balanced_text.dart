import 'package:flutter/material.dart';

class BalancedText extends StatelessWidget {
  const BalancedText({
    super.key,
    required this.text,
    this.style,
    this.minLineCount = 1, // Default to 1 (no forced extra lines)
  });
  final String text;
  final TextStyle? style;
  final int minLineCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return FutureBuilder<String>(
          future: _balanceText(text, constraints.maxWidth, style, minLineCount),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return Text(
              snapshot.data ?? text, // Always show text
              textAlign: TextAlign.center,
              style: style,
              softWrap: true,
            );
          },
        );
      },
    );
  }

  Future<String> _balanceText(
    String text,
    double maxWidth,
    TextStyle? style,
    int minLines,
  ) async {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: null,
    )..layout(maxWidth: maxWidth);

    // Get the natural number of lines
    var actualLines = textPainter.computeLineMetrics().length;

    // Ensure we have at least minLines
    var requiredLines = actualLines < minLines ? minLines : actualLines;

    if (requiredLines < 2) return text; // No need to adjust single-line text

    final List<String> words = text.split(' ');
    return _splitIntoLines(words, requiredLines);
  }

  String _splitIntoLines(List<String> words, int requiredLines) {
    var wordsPerLine = (words.length / requiredLines).ceil();
    var lines = <String>[];
    var index = 0;

    while (index < words.length) {
      var end = (index + wordsPerLine).clamp(0, words.length);
      lines.add(words.sublist(index, end).join(' '));
      index = end;
    }

    // If we still have fewer than minLines, add empty lines
    while (lines.length < requiredLines) {
      lines.add('');
    }

    return lines.join('\n');
  }
}
