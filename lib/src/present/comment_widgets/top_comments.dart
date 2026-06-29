import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/domain/usecases/get_top_comments.dart';
import 'package:lurp/src/data/repositories/lurp_comment_repository_impl.dart';
import 'package:lurp/src/present/comment_widgets/comments_section.dart';
import 'package:lurp/src/present/comment_widgets/single_top_comment.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/domain/entities/lurp_comment.dart';

class PostTopComments extends StatefulWidget {
  const PostTopComments({super.key, required this.post});
  final LurpPost post;

  static const int commentMaxLength = 150;

  static Widget commentIcon(BuildContext context) {
    return Icon(
      Icons.chat_bubble_outline,
      color: Theme.of(context).colorScheme.primary,
      size: 17,
    );
  }

  @override
  State<PostTopComments> createState() => _PostTopCommentsState();
}

class _PostTopCommentsState extends State<PostTopComments> {
  late Future<List<LurpComment>> _topCommentsFuture;

  @override
  void initState() {
    super.initState();
    _loadTopComments();
  }

  void _loadTopComments() {
    final getTopComments = GetTopComments(repository: LurpCommentRepositoryImpl());
    _topCommentsFuture = getTopComments.call(widget.post);
  }

  void _onPressed(BuildContext context) {
    CommentsSection commentsSection = CommentsSection(post: widget.post);
    commentsSection.show(context);
  }

  String viewMoreText(int topCommentCount) {
    if (topCommentCount == 0) {
      return 'View ${widget.post.commentCount} ${'comment'.plural(widget.post.commentCount)}';
    }
    if (widget.post.commentCount - topCommentCount == 0) {
      return 'Comment!';
    }
    if (widget.post.commentCount - topCommentCount == 1) {
      return 'View 1 more';
    }
    return '+${widget.post.commentCount - topCommentCount} more';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onPressed(context),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: FutureBuilder<List<LurpComment>>(
          future: _topCommentsFuture,
          builder: (context, snapshot) {
            final commentsData = snapshot.data ?? [];
            final hasError = snapshot.hasError;
            final isLoading =
                snapshot.connectionState == ConnectionState.waiting;

            if (isLoading) {
              return const SizedBox(height: 0);
            }

            return AnimatedSize(
              curve: Curves.fastOutSlowIn,
              clipBehavior: Clip.hardEdge,
              duration: const Duration(milliseconds: 700),
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Builder(
                  builder: (context) {
                    if (hasError || commentsData.isEmpty) {
                      return SingleTopCommentWidget(
                        post: widget.post,
                        showButton: true,
                        viewMoreText: viewMoreText(0),
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < commentsData.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: SingleTopCommentWidget(
                              post: widget.post,
                              comment: commentsData[i],
                              showButton: i == commentsData.length - 1,
                              viewMoreText: viewMoreText(commentsData.length),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
