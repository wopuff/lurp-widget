import 'package:lurp/src/config/api_client.dart';
import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/data/models/comment_model.dart';
import 'package:lurp/src/domain/repositories/comment_repository.dart';
import 'package:lurp/src/core/entities/common.dart';

class CommentRepositoryImpl implements CommentRepository {
  CommentRepositoryImpl();

  final int _initialQueryLimit = 7;
  final int _paginationQueryLimit = 8;

  @override
  Future<(List<Comment?>, String?)> getCommentsFeed(
    String postId,
    String? cursor,
  ) async {
    final queryParams = <String, String>{
      'limit': cursor == null
          ? '$_initialQueryLimit'
          : '$_paginationQueryLimit',
      'cursor': ?cursor,
    };

    try {
      final response = await ApiClient.get(
        'comments/feed/$postId',
        queryParams,
      );
      final data = response.data;

      final newCursor = data['nextCursor'] as String?;

      final commentsData = data['comments'] as List<dynamic>? ?? [];
      final commentEntities = commentsData
          .map((p) => CommentModel.fromData(p).toEntity())
          .toList();

      return (commentEntities, newCursor);
    } catch (e, st) {
      logger.e('getFeed failed', error: e, stackTrace: st);
      return (List<Comment?>.empty(), null);
    }
  }

  @override
  Future<List<Comment?>> getTopComments(
    String postId,
    int minLikes,
    int maxComments,
  ) async {
    try {
      final response = await ApiClient.get('comments/top/$postId');
      final data = response.data;

      final commentsData = data['comments'] as List<dynamic>? ?? [];
      final commentEntities = commentsData
          .map((p) => CommentModel.fromData(p).toEntity())
          .toList();

      return commentEntities;
    } catch (e, st) {
      logger.e('getFeed failed', error: e, stackTrace: st);
      return List<Comment>.empty();
    }
  }
}
