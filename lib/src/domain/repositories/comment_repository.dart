import 'package:lurp/src/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<(List<Comment?>, String?)> getCommentsFeed(
    String postId,
    String? cursor,
  );
  Future<List<Comment?>> getTopComments(
    String postId,
    int minLikes,
    int maxComments,
  );
}
