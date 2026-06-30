import 'package:lurp/src/core/api/api_client.dart';
import 'package:lurp/src/core/logger.dart';
import 'package:lurp/src/data/models/lurp_post_model.dart';
import 'package:lurp/src/domain/repositories/lurp_post_repository.dart';
import 'package:lurp/src/domain/entities/entities.dart';

class LurpPostRepositoryImpl implements LurpPostRepository {
  LurpPostRepositoryImpl();

  @override
  Future<LurpPost?> getPost(String postId) async {
    try {
      final result = await ApiClient.get('posts/post/$postId');
      final data = result.data;

      if (data['success'] == true) {
        final model = LurpPostModel.fromData(data['post']);
        final entity = model.toEntity();
        return entity;
      } else {
        logger.e('Error getting post: ${data['message']}');
      }
    } catch (e) {
      logger.e('Error getting post: $e');
    }

    return null;
  }
}
