import 'package:lurp/src/domain/entities/lurp_post.dart';

abstract class LurpPostRepository {
  Future<LurpPost?> getPost(String postId);
}
