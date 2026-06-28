import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lurp/src/media/present/post_media_gallery.dart';
import 'package:lurp/src/presentation/types/rating/rating_widget.dart';
import 'package:lurp/src/presentation/widgets/infobar.dart';
import 'package:lurp/src/presentation/types/selection/selection_widget.dart';
import 'package:lurp/src/presentation/types/slider/slider_widget.dart';
import 'package:lurp/src/presentation/types/thought/thought_widget.dart';
import 'package:lurp/src/presentation/widgets/post_title.dart';
import 'package:lurp/src/comments/presentation/widgets/top_comments.dart';
import 'package:lurp/src/core/entities/common.dart';

/// A widget that displays the full content of a [Post], including its header, title, media, and interactive poll/thought element.
class PostWidget extends StatelessWidget {
  /// The [Post] data entity to display.
  final Post post;

  /// Callback function triggered when the user taps on the post creator's avatar or username.
  final void Function(User creator)? onCreatorTap;

  /// Callback function triggered when the user taps the share button on the post.
  final void Function(Post post)? onShareTap;

  /// Creates a new [PostWidget] widget instance.
  const PostWidget({
    super.key,
    required this.post,
    this.onCreatorTap,
    this.onShareTap,
  });

  void _sharePost(BuildContext context) {
    if (onShareTap != null) {
      onShareTap!(post);
    } else {
      Clipboard.setData(ClipboardData(text: post.fullUrl));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!post.hasContent) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12.5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12.5),
          ),
          child: const Text('This post isn\'t available.'),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // post info
        PostInfoBar(
          post: post,
          onCreatorTap: onCreatorTap,
          sharePost: () => _sharePost(context),
        ),
        SizedBox(height: post.isSelection ? 14 : 12.5),

        // title
        if (post.title != null)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 6),
            child: PostTitle(title: post.title!),
          ),

        // potential image
        if (post.media.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
            child: PostMediaGallery(post: post),
          ),

        // content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Builder(
            builder: (context) {
              if (post.isThought) return ThoughtWidget(thought: post.thought!);
              if (post.isSelection) return SelectionWidget(post: post);
              if (post.isSlider) return SliderWidget(post: post);
              if (post.isRating) return RatingWidget(post: post);
              return const SizedBox.shrink();
            },
          ),
        ),

        const SizedBox(height: 7),

        // top comments
        PostTopComments(post: post),
      ],
    );
  }
}
