import 'package:lurp/src/domain/entities/lurp_comment.dart';

abstract class LurpCommentRepository {
  Future<(List<LurpComment?>, String?)> getCommentsFeed(
    String postId,
    String? cursor,
  );
  Future<List<LurpComment?>> getTopComments(
    String postId,
    int minLikes,
    int maxComments,
  );
}
