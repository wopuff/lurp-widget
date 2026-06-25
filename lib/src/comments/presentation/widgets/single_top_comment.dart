import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/color_utils.dart';
import 'package:lurp/src/comments/domain/entities/comment.dart';
import 'package:lurp/src/comments/presentation/widgets/top_comments.dart';
import 'package:lurp/src/domain/entities/post.dart';

class SingleTopCommentWidget extends StatelessWidget {
  final Post post;
  final Comment? comment;
  final bool showButton;
  final String viewMoreText;

  const SingleTopCommentWidget({
    super.key,
    required this.post,
    this.comment,
    this.showButton = false,
    this.viewMoreText = '',
  });

  String _commentText() {
    if (comment != null) {
      if (comment!.text.length > PostTopComments.commentMaxLength) {
        return '${comment?.text.substring(0, PostTopComments.commentMaxLength)}...';
      }
      return comment!.text;
    }

    return 'Create a comment!';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            left: 10.0 + 2.5,
            right: 10.0,
            top: 10,
            bottom: 5,
          ),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.5)),
          child: Text.rich(
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
            TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                const WidgetSpan(child: SizedBox(width: 20)),

                if (comment != null)
                  TextSpan(
                    text: '${comment?.creator.username} ',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),

                TextSpan(
                  text: _commentText(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.dim(comment != null ? 0.6 : 0.8),
                  ),
                ),

                if (showButton) const WidgetSpan(child: SizedBox(width: 120)),
              ],
            ),
          ),
        ),

        Positioned(
          left: 10.0,
          top: 14,
          child: PostTopComments.commentIcon(context),
        ),

        if (showButton && post.commentCount > 0)
          Positioned(
            right: 10.0,
            bottom: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                viewMoreText,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
