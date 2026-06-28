import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/domain/entities/comment.dart';
import 'package:lurp/src/domain/entities/comments_feed.dart';
import 'package:lurp/src/domain/repositories/comment_repository.dart';
import 'package:lurp/src/domain/entities/post.dart';

class GetCommentFeed {
  GetCommentFeed({required this.repository});
  final CommentRepository repository;

  /// Fetch a page of comments
  Future<CommentsFeed> call(Post post, String? cursor) async {
    if (post.commentCount == 0) {
      return CommentsFeed.empty();
    }

    try {
      final (List<Comment?> comments, String? newCursor) = await repository
          .getCommentsFeed(post.id, cursor);

      final cleanedComments = comments
          .where((c) => c != null && !c.creator.isUnknown())
          .cast<Comment>()
          .toList();

      final hasMore = comments.isNotEmpty && newCursor != null;
      return CommentsFeed(
        comments: cleanedComments,
        hasMore: hasMore,
        cursor: newCursor,
      );
    } catch (e) {
      logger.e('Failed to fetch comments: $e');
      return CommentsFeed(comments: [], hasMore: false, cursor: cursor);
    }
  }
}
