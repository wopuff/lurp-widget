import 'package:lurp/src/comments/data/comment_model.dart';
import 'package:lurp/src/core/entities/common.dart';

class Comment {
  final String id;
  final User creator;
  final String text;
  final DateTime createdAt;
  final bool createdBySiu;
  final String? replyToUsername;

  String state;
  int likeCount;
  int dislikeCount;
  int replyCount;

  bool siuHasLiked;
  bool siuHasDisliked;

  // constants
  static const int minTextLength = 2;
  static const int maxTextLength = 349;

  Comment({
    required this.id,
    required this.creator,
    required this.text,
    required this.state,
    required this.createdAt,
    required this.likeCount,
    required this.dislikeCount,
    required this.replyCount,
    this.replyToUsername,
    this.siuHasLiked = false,
    this.siuHasDisliked = false,
    this.createdBySiu = false,
  });

  factory Comment.fromEmpty({
    String? id,
    CommentModel? model,
    User? creator,
    String? text,
    DateTime? createdAt,
    String? state,
    int? likeCount,
    int? dislikeCount,
    int? replyCount,
    bool? siuHasLiked,
    bool? diuHasDisliked,
    bool? createdBySiu,
  }) {
    return Comment(
      id: id ?? '',
      creator: creator ?? User.unknown(),
      text: text ?? '',
      createdAt: createdAt ?? DateTime.now(),
      state: state ?? '',
      likeCount: likeCount ?? 0,
      dislikeCount: dislikeCount ?? 0,
      replyCount: replyCount ?? 0,
      siuHasLiked: siuHasLiked ?? false,
      siuHasDisliked: diuHasDisliked ?? false,
      createdBySiu: createdBySiu ?? false,
    );
  }

  Comment copyWith({
    CommentModel? model,
    String? id,
    User? creator,
    String? text,
    DateTime? createdAt,
    String? state,
    int? likeCount,
    int? dislikeCount,
    int? replyCount,
    bool? userHasLiked,
    bool? createdBySiu,
  }) {
    return Comment(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      state: state ?? this.state,
      likeCount: likeCount ?? this.likeCount,
      dislikeCount: dislikeCount ?? this.dislikeCount,
      replyCount: replyCount ?? this.replyCount,
      siuHasLiked: userHasLiked ?? siuHasLiked,
      createdBySiu: createdBySiu ?? this.createdBySiu,
    );
  }
}
