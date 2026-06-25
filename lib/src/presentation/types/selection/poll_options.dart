import 'package:flutter/material.dart';
import 'package:lurp/src/config/theme/poll_colors.dart';
import 'package:lurp/src/domain/entities/selection.dart';
import 'package:lurp/src/domain/entities/post.dart';
import 'package:lurp/src/presentation/types/selection/poll_option_button.dart';

class PollOptionsWidget extends StatelessWidget {
  final Post post;

  const PollOptionsWidget({super.key, required this.post});

  SelectionPoll get poll => post.selection!;
  List<PollOption> get options => post.selection!.options;

  static const double _buttonSpacing = 6;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double buttonWidth = (constraints.maxWidth - _buttonSpacing) / 2;
        double buttonHeight = _buttonHeight(context, buttonWidth);

        bool singleColumn = buttonHeight > 130;
        if (singleColumn) buttonWidth = constraints.maxWidth;
        return Wrap(
          spacing: _buttonSpacing,
          runSpacing: _buttonSpacing,
          children: [
            for (PollOption option in options)
              PollOptionButton(
                isActive: true,
                buttonWidth: buttonWidth,
                buttonHeight: singleColumn ? null : buttonHeight,
                singleColumn: singleColumn,
                proportion: option.voteProportion,
                optionColor:
                    Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? PollColors.list[option.colorIndex]
                    : PollColors.lightList[option.colorIndex],
                text: option.text,
                showBorder: false,
              ),
          ],
        );
      },
    );
  }

  double _buttonHeight(BuildContext context, double buttonWidth) {
    double maxHeight = 0;

    for (var option in options) {
      final textSpan = TextSpan(
        text: option.text,
        style: Theme.of(context).textTheme.bodyMedium,
      );

      final textPainter = TextPainter(
        text: textSpan,
        maxLines: null,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: buttonWidth - 33.4);

      if (textPainter.height > maxHeight) {
        maxHeight = textPainter.height;
      }
    }

    maxHeight += 13.4;

    if (options.length == 2) {
      if (maxHeight < 70) maxHeight = 70;
    } else if (options.length <= 4) {
      if (maxHeight < 62.5) maxHeight = 62.5;
    } else {
      if (maxHeight < 55) maxHeight = 55;
    }
    return maxHeight;
  }
}
