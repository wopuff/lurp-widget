import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/domain/entities/lurp_comment.dart';
import 'package:lurp/src/domain/entities/comments_feed.dart';
import 'package:lurp/src/domain/repositories/lurp_comment_repository.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';

class GetCommentFeed {
  GetCommentFeed({required this.repository});
  final LurpCommentRepository repository;

  /// Fetch a page of comments
  Future<CommentsFeed> call(LurpPost post, String? cursor) async {
    if (post.commentCount == 0) {
      return CommentsFeed.empty();
    }

    try {
      final (List<LurpComment?> comments, String? newCursor) = await repository
          .getCommentsFeed(post.id, cursor);

      final cleanedComments = comments
          .where((c) => c != null && !c.creator.isUnknown())
          .cast<LurpComment>()
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
