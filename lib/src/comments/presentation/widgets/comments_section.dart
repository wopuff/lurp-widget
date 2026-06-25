import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/core/widgets/bottom_sheet.dart';
import 'package:lurp/src/comments/presentation/widgets/comments_section_content.dart';
import 'package:lurp/src/domain/entities/post.dart';

class CommentsSection extends StatelessWidget {
  final Post post;

  const CommentsSection({super.key, required this.post});

  void show(BuildContext context) {
    CustomBottomSheet bottomSheet = CustomBottomSheet(
      title: '${post.commentCount} ${'comment'.plural(post.commentCount)}',
      content: CommentsSection(post: post),
      padding: const EdgeInsets.only(bottom: 10),
    );
    bottomSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Comments list
        Flexible(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            child: CommentsSectionContent(post: post),
          ),
        ),

        // Mobile keyboard padding
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          child: SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ),
      ],
    );
  }
}
