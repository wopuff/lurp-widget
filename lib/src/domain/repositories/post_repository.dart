import 'package:lurp/src/domain/entities/post.dart';

abstract class PostRepository {
  Future<Post?> getPost(String postId);
}
