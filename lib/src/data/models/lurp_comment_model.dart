import 'package:lurp/src/domain/entities/entities.dart';
import 'package:lurp/src/core/logger.dart';

class LurpCommentModel {
  LurpCommentModel({
    required this.id,
    required this.auhtorId,
    required this.authorUsername,
    required this.authorFlatUsername,
    required this.authorRank,
    required this.replyToAuthorUsername,
    required this.createdByCurrentUser,
    required this.currentUserReaction,
    required this.createdAt,
    required this.state,
    required this.text,
    required this.likeCount,
    required this.dislikeCount,
    required this.replyCount,
  });

  factory LurpCommentModel.fromData(Map<String, dynamic> data) {
    try {
      return LurpCommentModel(
        id: data['id'] ?? 'unknown_id',
        auhtorId: data['authorId'] ?? LurpUser.unknownUid,
        authorUsername: data['authorUsername'] ?? LurpUser.unknownUsername,
        authorFlatUsername:
            data['authorFlatUsername'] ?? LurpUser.unknownUsername,
        authorRank: data['authorRank'] ?? LurpUser.defaultRank,
        replyToAuthorUsername: data['replyToAuthorUsername'],
        createdByCurrentUser: data['createdByCurrentUser'] ?? false,
        currentUserReaction: data['currentUserReaction'],
        createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
        state: data['state'] ?? 'visible',
        text: data['content'] ?? '',
        likeCount: data['likeCount'] ?? 0,
        dislikeCount: data['dislikeCount'] ?? 0,
        replyCount: data['replyCount'] ?? 0,
      );
    } catch (e) {
      logger.e('LurpCommentModel: Error converting from data: $e');
      return LurpCommentModel.unknown();
    }
  }

  factory LurpCommentModel.unknown() {
    return LurpCommentModel(
      id: 'unknown_id',
      auhtorId: LurpUser.unknownUid,
      authorUsername: LurpUser.unknownUsername,
      authorFlatUsername: LurpUser.unknownUsername,
      authorRank: LurpUser.defaultRank,
      createdByCurrentUser: false,
      currentUserReaction: null,
      replyToAuthorUsername: null,
      createdAt: DateTime.now(),
      state: 'visible',
      text: '',
      likeCount: 0,
      dislikeCount: 0,
      replyCount: 0,
    );
  }
  final String id;

  final String auhtorId;
  final String authorUsername;
  final String authorFlatUsername;
  final String authorRank;

  final String? replyToAuthorUsername;

  final DateTime createdAt;
  final String state;

  final bool createdByCurrentUser;
  final String? currentUserReaction;

  final String text;
  final int likeCount;
  final int dislikeCount;
  final int replyCount;

  LurpComment toEntity() {
    final creator = LurpUser.fromEmpty(
      uid: auhtorId,
      username: authorUsername,
      flatUsername: authorFlatUsername,
      rank: authorRank,
    );

    return LurpComment(
      id: id,
      creator: creator,
      replyToUsername: replyToAuthorUsername,
      text: text,
      likeCount: likeCount,
      dislikeCount: dislikeCount,
      replyCount: replyCount,
      createdAt: createdAt,
      state: state,
      createdBySiu: createdByCurrentUser,
      siuHasLiked: currentUserReaction == 'positive',
      siuHasDisliked: currentUserReaction == 'negative',
    );
  }
}
