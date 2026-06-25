import 'package:lurp/src/comments/domain/entities/comment.dart';

class CommentsFeed {
  final List<Comment> comments;
  final bool hasMore;
  final String? cursor;

  CommentsFeed({required this.comments, required this.hasMore, this.cursor});

  CommentsFeed copyWith({
    List<Comment>? comments,
    bool? hasMore,
    String? cursor,
  }) {
    return CommentsFeed(
      comments: comments ?? this.comments,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
    );
  }

  factory CommentsFeed.empty() {
    return CommentsFeed(comments: [], hasMore: false);
  }
}
