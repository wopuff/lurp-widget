import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/color_utils.dart';
import 'package:lurp/src/core/utils/date_utils.dart';

import 'package:lurp/src/core/entities/common.dart';
import 'package:lurp/src/presentation/widgets/infobar_button.dart';
import 'package:lurp/src/presentation/widgets/rating_buttons.dart';

class PostInfoBar extends StatelessWidget {
  const PostInfoBar({
    super.key,
    required this.post,
    this.showInfoSheet,
    this.showDateSheet,
    this.sharePost,
    this.onCreatorTap,
  });
  final Post post;
  final VoidCallback? showInfoSheet;
  final VoidCallback? showDateSheet;
  final VoidCallback? sharePost;
  final void Function(User creator)? onCreatorTap;

  static const double height = 30;
  static const double spacing = 4;
  static const double connectedSpacing = 2.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          ListView(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(left: 10.0),
            children: [
              if (post.state != 'visible')
                PostInfoBarButton(
                  spacingRight: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'HIDDEN',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              PostInfoBarButton(
                spacingRight: true,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                action: onCreatorTap != null
                    ? () => onCreatorTap!(post.creator)
                    : null,
                child: Text(
                  post.creator.username,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              PostInfoBarButton(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                action: showDateSheet,
                child: Text(
                  DateFormat.dateToWords(
                    post.createdAt,
                    endWithAgo: false,
                    shortened: true,
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.dim(0.6),
                  ),
                ),
              ),
              Opacity(
                opacity: 0,
                child: IgnorePointer(
                  child: PostInfoBarRightPart(
                    post: post,
                    isInteractable: false,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: -spacing,
            child: PostInfoBarRightPart(
              post: post,
              sharePost: sharePost,
              showInfoSheet: showInfoSheet,
            ),
          ),
        ],
      ),
    );
  }
}

class PostInfoBarRightPart extends StatelessWidget {
  const PostInfoBarRightPart({
    super.key,
    required this.post,
    this.showInfoSheet,
    this.sharePost,
    this.isInteractable = true,
  });
  final Post post;
  final VoidCallback? showInfoSheet;
  final VoidCallback? sharePost;
  final bool isInteractable;

  static const height = PostInfoBar.height;
  static const spacing = PostInfoBar.spacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height + 2 * spacing,
      padding: const EdgeInsets.only(
        left: spacing,
        top: spacing,
        bottom: spacing,
        right: 10.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(10 + spacing),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PostRatingButtons(post: post),
          if (sharePost != null)
            PostInfoBarButton(
              iconPath:
                  'share', // We'll change it to standard Icons in infobar_button.dart
              action: isInteractable ? sharePost : null,
              spacingRight: true,
              iconSize: 16.5,
              padding: const EdgeInsets.only(bottom: 1),
            ),
          if (showInfoSheet != null)
            PostInfoBarButton(
              iconPath: 'menu',
              iconSize: 15.5,
              action: isInteractable ? showInfoSheet : null,
            ),
        ],
      ),
    );
  }
}
