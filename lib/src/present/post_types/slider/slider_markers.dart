import 'package:flutter/material.dart';
import 'package:lurp/src/config/theme/poll_colors.dart';

class SliderMarkers extends StatelessWidget {
  const SliderMarkers({super.key, required this.votes, required this.average});
  final List<double> votes;
  final double average;

  double xFor(double v, double trackWidth, {double thumbRadius = 15.0}) {
    final usableWidth = trackWidth - 2 * thumbRadius;
    final fraction = v;
    const offset = -1.5;
    return thumbRadius + fraction * usableWidth + offset;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        const double arrowSize = 20;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            // --- Individual votes (Circles) ---
            for (int i = 0; i < votes.length; i++)
              Positioned(
                left: xFor(votes[i], trackWidth) - 7.5,
                top: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        color: PollColors
                            .lightList[(i + 1) % PollColors.lightList.length],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // --- Average marker (Arrow pointing up) ---
            Positioned(
              left:
                  xFor(average, trackWidth) -
                  ((arrowSize - 2) / 2) -
                  (average > 0.5 ? 51.3 : 0),
              top: 35,
              child: IgnorePointer(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: average > 0.5
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  spacing: 6,
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: arrowSize,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.5),
                      child: Text(
                        'AVERAGE',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 13.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
