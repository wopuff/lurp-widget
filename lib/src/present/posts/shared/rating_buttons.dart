import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/color_utils.dart';
import 'package:lurp/src/core/utils/format_utils.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/present/posts/shared/infobar_button.dart';

class PostRatingButtons extends StatelessWidget {
  const PostRatingButtons({
    super.key,
    required this.post,
    this.isInteractable = false,
  });
  final LurpPost post;
  final bool isInteractable;

  @override
  Widget build(BuildContext context) {
    Color upColor = post.siuRating == 'positive'
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.dim(0.5);

    Color downColor = post.siuRating == 'negative'
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.dim(0.5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PostInfoBarButton(
          connectedSpacing: true,
          spacingRight: true,
          roundedRight: false,
          minWidth: 53,
          padding: const EdgeInsets.only(left: 2.5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                FormatUtils.shortenNumber(post.upvoteCount),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 6),
              Icon(Icons.arrow_upward, color: upColor, size: 13),
            ],
          ),
        ),
        PostInfoBarButton(
          spacingRight: true,
          roundedLeft: false,
          padding: const EdgeInsets.only(right: 2.5),
          child: Icon(Icons.arrow_downward, color: downColor, size: 13),
        ),
      ],
    );
  }
}
