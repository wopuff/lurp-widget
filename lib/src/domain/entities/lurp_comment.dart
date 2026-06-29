import 'package:lurp/src/data/models/lurp_comment_model.dart';
import 'package:lurp/src/core/entities/common.dart';

/// Represents a user comment on a post within the widget system.
class LurpComment {
  /// Creates a new [LurpComment] instance.
  LurpComment({
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

  /// Factory constructor to create an empty [LurpComment] template with optional parameter overrides.
  factory LurpComment.fromEmpty({
    String? id,
    LurpCommentModel? model,
    LurpUser? creator,
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
    return LurpComment(
      id: id ?? '',
      creator: creator ?? LurpUser.unknown(),
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

  /// The unique identifier of the comment.
  final String id;

  /// The user who created the comment.
  final LurpUser creator;

  /// The text content of the comment.
  final String text;

  /// The timestamp when the comment was created.
  final DateTime createdAt;

  /// Whether the comment was created by the currently signed-in user (SIU).
  final bool createdBySiu;

  /// The username of the user this comment is replying to, if any.
  final String? replyToUsername;

  /// The state of the comment (e.g. active, deleted, flagged).
  String state;

  /// The total number of likes received by this comment.
  int likeCount;

  /// The total number of dislikes received by this comment.
  int dislikeCount;

  /// The total number of replies to this comment.
  int replyCount;

  /// Whether the currently signed-in user has liked this comment.
  bool siuHasLiked;

  /// Whether the currently signed-in user has disliked this comment.
  bool siuHasDisliked;

  /// The minimum length required for a comment's text content.
  static const int minTextLength = 2;

  /// The maximum length allowed for a comment's text content.
  static const int maxTextLength = 349;

  /// Creates a copy of this comment with the given fields replaced by new values.
  LurpComment copyWith({
    LurpCommentModel? model,
    String? id,
    LurpUser? creator,
    String? text,
    DateTime? createdAt,
    String? state,
    int? likeCount,
    int? dislikeCount,
    int? replyCount,
    bool? userHasLiked,
    bool? createdBySiu,
  }) {
    return LurpComment(
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
