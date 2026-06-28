import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/domain/entities/post.dart';
import 'package:lurp/src/domain/entities/rating.dart';
import 'package:lurp/src/present/post_widgets/animated_stats.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.post});
  final Post post;

  RatingPoll get poll => post.rating!;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final totalStars = poll.starCount <= 0 ? 5 : poll.starCount;
    final averageValue = poll.averageValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        // Dynamic Stars Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final double starSize = constraints.maxWidth / totalStars;

            return SizedBox(
              height: starSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(totalStars, (index) {
                  final starIndexValue = index + 1;

                  return SizedBox(
                    width: starSize,
                    height: starSize,
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 1. BASE STAR (EMPTY)
                          Center(
                            child: Icon(
                              Icons.star_border,
                              size: starSize,
                              color: colorScheme.secondary,
                            ),
                          ),

                          // 2. CONDITIONAL INNER OVERLAY STAR (Clipped)
                          Builder(
                            builder: (context) {
                              double targetCutPercentage = 0.0;

                              if (averageValue >= starIndexValue) {
                                targetCutPercentage = 1.0;
                              } else if (averageValue > starIndexValue - 1) {
                                targetCutPercentage =
                                    averageValue - (starIndexValue - 1);
                              }

                              if (targetCutPercentage <= 0.0) {
                                return const SizedBox.shrink();
                              }

                              return Center(
                                child: ClipRect(
                                  clipper: StarArtworkClipper(
                                    fillFactor: targetCutPercentage,
                                  ),
                                  child: Icon(
                                    Icons.star,
                                    size: starSize,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),

        // stats
        AnimatedStats(
          hasVoted: true,
          text:
              '${poll.voteCount} ${'vote'.plural(poll.voteCount)}, ${poll.formattedAverage} average',
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}

class StarArtworkClipper extends CustomClipper<Rect> {
  StarArtworkClipper({required this.fillFactor});
  final double fillFactor;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fillFactor, size.height);
  }

  @override
  bool shouldReclip(StarArtworkClipper oldClipper) {
    return oldClipper.fillFactor != fillFactor;
  }
}
