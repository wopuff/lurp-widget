import 'package:lurp/src/config/logger/logger.dart';
import 'package:lurp/src/domain/entities/post.dart';
import 'package:lurp/src/domain/repositories/post_repository.dart';

class GetPost {
  GetPost({required this.repository});
  final PostRepository repository;

  Future<Post?> call(String postId) async {
    try {
      final post = await repository.getPost(postId);
      return post;
    } catch (e) {
      logger.e('GetPosts.singlePost: $e');
      return null;
    }
  }
}
