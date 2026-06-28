import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/date_utils.dart';
import 'package:lurp/src/comments/domain/entities/comment.dart';
import 'package:lurp/src/domain/entities/post.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key, required this.post, required this.comment});
  final Post post;
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.5),
        border: Border.all(color: colorScheme.surface, width: 3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // top bar
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich(
                  maxLines: 1,
                  TextSpan(
                    children: [
                      // username
                      TextSpan(
                        text: comment.creator.username,
                        style: textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: comment.createdBySiu
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      // time posted
                      TextSpan(
                        text:
                            ', ${DateFormat.dateToWords(comment.createdAt)}\n',
                        style: textTheme.bodySmall!.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // main content
          RichText(
            text: TextSpan(
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.8),
              ),
              children: [
                if (comment.replyToUsername != null)
                  WidgetSpan(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: colorScheme.secondary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '@${comment.replyToUsername}',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ),
                TextSpan(text: comment.text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
