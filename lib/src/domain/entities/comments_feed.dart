import 'package:lurp/src/domain/entities/lurp_comment.dart';

class CommentsFeed {
  CommentsFeed({required this.comments, required this.hasMore, this.cursor});

  factory CommentsFeed.empty() {
    return CommentsFeed(comments: [], hasMore: false);
  }
  final List<LurpComment> comments;
  final bool hasMore;
  final String? cursor;

  CommentsFeed copyWith({
    List<LurpComment>? comments,
    bool? hasMore,
    String? cursor,
  }) {
    return CommentsFeed(
      comments: comments ?? this.comments,
      hasMore: hasMore ?? this.hasMore,
      cursor: cursor ?? this.cursor,
    );
  }
}
