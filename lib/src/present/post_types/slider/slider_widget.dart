import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/domain/entities/slider.dart';
import 'package:lurp/src/present/post_types/slider/slider_markers.dart';
import 'package:lurp/src/present/post_widgets/animated_stats.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({super.key, required this.post});
  final LurpPost post;

  SliderPoll get slider => post.slider!;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 30,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.centerLeft,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 30,
                        thumbShape: SliderComponentShape.noThumb,
                      ),
                      child: Slider(
                        value: slider.averageValue,
                        min: 0,
                        max: 1,
                        activeColor: colorScheme.primary,
                        inactiveColor: colorScheme.secondary,
                        onChanged: null, // Read-only!
                      ),
                    ),
                    Positioned.fill(
                      child: SliderMarkers(
                        votes: slider.votes,
                        average: slider.averageValue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        AnimatedStats(
          hasVoted: true,
          text:
              '${slider.voteCount} ${'vote'.plural(slider.voteCount)}, ${slider.formattedAverage} average',
        ),
      ],
    );
  }
}
