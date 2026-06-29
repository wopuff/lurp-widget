import 'package:lurp/src/config/logger.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/domain/repositories/lurp_post_repository.dart';

class GetPost {
  GetPost({required this.repository});
  final LurpPostRepository repository;

  Future<LurpPost?> call(String postId) async {
    try {
      final post = await repository.getPost(postId);
      return post;
    } catch (e) {
      logger.e('GetPosts.singlePost: $e');
      return null;
    }
  }
}
