import 'package:lurp/src/config/api_client.dart';
import 'package:lurp/src/config/logger/logger.dart';
import 'package:lurp/src/data/models/post_model.dart';
import 'package:lurp/src/domain/repositories/post_repository.dart';
import 'package:lurp/src/core/entities/common.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl();

  @override
  Future<Post?> getPost(String postId) async {
    try {
      final result = await ApiClient.get('posts/post/$postId');
      final data = result.data;

      if (data['success'] == true) {
        final model = PostModel.fromData(data['post']);
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
