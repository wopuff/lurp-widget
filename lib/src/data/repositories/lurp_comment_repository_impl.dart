import 'package:lurp/src/config/api_client.dart';
import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/data/models/lurp_comment_model.dart';
import 'package:lurp/src/domain/repositories/lurp_comment_repository.dart';
import 'package:lurp/src/core/entities/common.dart';

class LurpCommentRepositoryImpl implements LurpCommentRepository {
  LurpCommentRepositoryImpl();

  final int _initialQueryLimit = 7;
  final int _paginationQueryLimit = 8;

  @override
  Future<(List<LurpComment?>, String?)> getCommentsFeed(
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
          .map((p) => LurpCommentModel.fromData(p).toEntity())
          .toList();

      return (commentEntities, newCursor);
    } catch (e, st) {
      logger.e('getFeed failed', error: e, stackTrace: st);
      return (List<LurpComment?>.empty(), null);
    }
  }

  @override
  Future<List<LurpComment?>> getTopComments(
    String postId,
    int minLikes,
    int maxComments,
  ) async {
    try {
      final response = await ApiClient.get('comments/top/$postId');
      final data = response.data;

      final commentsData = data['comments'] as List<dynamic>? ?? [];
      final commentEntities = commentsData
          .map((p) => LurpCommentModel.fromData(p).toEntity())
          .toList();

      return commentEntities;
    } catch (e, st) {
      logger.e('getFeed failed', error: e, stackTrace: st);
      return List<LurpComment>.empty();
    }
  }
}
