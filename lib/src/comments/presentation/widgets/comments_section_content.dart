import 'package:flutter/material.dart';
import 'package:lurp/src/core/widgets/progress_indicator.dart';
import 'package:lurp/src/comments/domain/entities/comment.dart';

import 'package:lurp/src/comments/domain/usecases/get_comment_feed.dart';
import 'package:lurp/src/comments/data/comment_repository_impl.dart';
import 'package:lurp/src/comments/presentation/widgets/comment_widget.dart';
import 'package:lurp/src/domain/entities/post.dart';

class CommentsSectionContent extends StatefulWidget {
  const CommentsSectionContent({super.key, required this.post});
  final Post post;

  @override
  State<CommentsSectionContent> createState() => _CommentsSectionContentState();
}

class _CommentsSectionContentState extends State<CommentsSectionContent> {
  final List<Comment> _comments = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String? _cursor;
  late final GetCommentFeed _getCommentFeed;

  @override
  void initState() {
    super.initState();
    _getCommentFeed = GetCommentFeed(repository: CommentRepositoryImpl());
    _loadMoreComments();
  }

  Future<void> _loadMoreComments() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final feed = await _getCommentFeed.call(widget.post, _cursor);
      setState(() {
        _comments.addAll(feed.comments);
        _hasMore = feed.hasMore;
        _cursor = feed.cursor;
      });
    } catch (e) {
      // Log or handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_comments.isEmpty && _isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CustomProgressIndicator()],
        ),
      );
    }

    if (_comments.isEmpty) {
      return const SizedBox.shrink();
    }

    final itemCount = _comments.length + (_hasMore ? 1 : 0);

    return ListView.builder(
      cacheExtent: 50,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 15, bottom: 2.5),
      itemCount: itemCount,
      itemBuilder: (context, i) {
        if (i == _comments.length) {
          // Trigger loading more comments
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _loadMoreComments();
          });
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(child: CustomProgressIndicator()),
          );
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 12.5),
            child: CommentWidget(post: widget.post, comment: _comments[i]),
          ),
        );
      },
    );
  }
}
