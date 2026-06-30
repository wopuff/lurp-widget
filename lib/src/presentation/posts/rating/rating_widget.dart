import 'package:flutter/material.dart';
import 'package:lurp/src/core/assets.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/presentation/common/icon_asset.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/domain/entities/rating.dart';
import 'package:lurp/src/presentation/posts/shared/animated_stats.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key, required this.post});

  final LurpPost post;

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  RatingPoll get poll => widget.post.rating!;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final hasVoted = poll.siuVote != null;
    final totalStars = poll.starCount <= 0 ? 5 : poll.starCount;
    final averageValue = poll.averageValue;

    final currentVoteValue = poll.siuVote ?? 0;
    final selectedStarsCount = currentVoteValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),

        // Dynamic Stars Layout
        LayoutBuilder(
          builder: (context, constraints) {
            final double starSize = constraints.maxWidth / totalStars;
            const double artworkRatio = 0.55;

            return SizedBox(
              height: starSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(totalStars, (index) {
                  final starIndexValue = index + 1;
                  final isUserVotedStar =
                      hasVoted && (starIndexValue <= selectedStarsCount);

                  return SizedBox(
                    width: starSize,
                    height: starSize,
                    child: MouseRegion(
                      cursor: hasVoted
                          ? SystemMouseCursors.basic
                          : SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: hasVoted
                            ? null
                            : () {
                                setState(() {
                                  widget.post.addVote(
                                    null,
                                    starIndexValue.toDouble(),
                                  );
                                });
                              },
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // 1. BACKGROUND GLOWING STAR
                              if (isUserVotedStar)
                                Center(
                                  child: IconAsset(
                                    Assets.ratingStarBig,
                                    size: starSize,
                                    color: colorScheme.onSurface,
                                  ),
                                ),

                              // 2. BASE STAR
                              Center(
                                child: IconAsset(
                                  Assets.ratingStarMedium,
                                  size: starSize,
                                  color: colorScheme.secondary,
                                ),
                              ),

                              // 3. CONDITIONAL INNER OVERLAY STAR (With Left-to-Right Wipe Animation)
                              Builder(
                                builder: (context) {
                                  bool shouldRender = false;
                                  double targetCutPercentage = 1.0;
                                  Color fillColor = colorScheme.onSurface;

                                  if (hasVoted) {
                                    if (averageValue >= starIndexValue) {
                                      shouldRender = true;
                                      targetCutPercentage = 1.0;
                                    } else if (averageValue >
                                        starIndexValue - 1) {
                                      shouldRender = true;
                                      targetCutPercentage =
                                          averageValue - (starIndexValue - 1);
                                    }
                                    fillColor = colorScheme.primary;
                                  } else {
                                    shouldRender = false;
                                    targetCutPercentage = 0.0;
                                    fillColor = Colors.white;
                                  }

                                  if (!shouldRender) {
                                    return const SizedBox.shrink();
                                  }

                                  return Center(
                                    child: TweenAnimationBuilder<double>(
                                      // Animate the averageValue results on reveal
                                      tween: Tween<double>(
                                        begin: 0.0,
                                        end: targetCutPercentage,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 1000,
                                      ),
                                      curve: Curves.easeInCubic,
                                      builder: (context, animatedFill, child) {
                                        return ClipRect(
                                          clipper: StarArtworkClipper(
                                            fillFactor: animatedFill,
                                            visibleArtworkRatio: artworkRatio,
                                          ),
                                          child: IconAsset(
                                            Assets.ratingStarSmall,
                                            size: starSize,
                                            color: fillColor,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
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
          hasVoted: hasVoted,
          text:
              '${poll.voteCount} ${'vote'.plural(poll.voteCount)}, ${poll.formattedAverage} average',
        ),

        const SizedBox(height: 15),
      ],
    );
  }
}

class StarArtworkClipper extends CustomClipper<Rect> {
  StarArtworkClipper({
    required this.fillFactor,
    required this.visibleArtworkRatio,
  });

  final double fillFactor;
  final double visibleArtworkRatio;

  @override
  Rect getClip(Size size) {
    if (fillFactor >= 1.0) {
      return Rect.fromLTWH(0, 0, size.width, size.height);
    }

    double totalPaddingWidth = size.width * (1.0 - visibleArtworkRatio);
    double starLeftEdge = totalPaddingWidth / 2;
    double starVisibleWidth = size.width * visibleArtworkRatio;
    double dynamicClipWidth = starLeftEdge + (starVisibleWidth * fillFactor);

    return Rect.fromLTWH(0, 0, dynamicClipWidth, size.height);
  }

  @override
  bool shouldReclip(StarArtworkClipper oldClipper) {
    return oldClipper.fillFactor != fillFactor ||
        oldClipper.visibleArtworkRatio != visibleArtworkRatio;
  }
}
