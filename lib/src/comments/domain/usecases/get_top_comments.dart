import 'package:lurp/src/config/logger/logger.dart';
import 'package:lurp/src/comments/domain/repositories/comment_repository.dart';
import 'package:lurp/src/core/entities/common.dart';

class GetTopComments {
  GetTopComments({required this.repository});
  final CommentRepository repository;

  Future<List<Comment>> call(Post post) async {
    if (post.id.isEmpty) return [];

    try {
      int minLikeCount = 1;
      int maxCommentCount = 3;
      final comments = await repository.getTopComments(
        post.id,
        minLikeCount,
        maxCommentCount,
      );

      // Filter out null comments and comments with unknown users
      comments.removeWhere(
        (comment) => comment == null || comment.creator.isUnknown(),
      );

      return comments.cast();
    } catch (e) {
      logger.e('GetTopComments: $e');
      return [];
    }
  }
}
