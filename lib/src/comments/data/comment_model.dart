import 'package:lurp/src/core/entities/common.dart';
import 'package:lurp/src/config/logger/logger.dart';

class CommentModel {
  CommentModel({
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

  factory CommentModel.fromData(Map<String, dynamic> data) {
    try {
      return CommentModel(
        id: data['id'] ?? 'unknown_id',
        auhtorId: data['authorId'] ?? User.unknownUid,
        authorUsername: data['authorUsername'] ?? User.unknownUsername,
        authorFlatUsername: data['authorFlatUsername'] ?? User.unknownUsername,
        authorRank: data['authorRank'] ?? User.defaultRank,
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
      logger.e('CommentModel: Error converting from data: $e');
      return CommentModel.unknown();
    }
  }

  factory CommentModel.unknown() {
    return CommentModel(
      id: 'unknown_id',
      auhtorId: User.unknownUid,
      authorUsername: User.unknownUsername,
      authorFlatUsername: User.unknownUsername,
      authorRank: User.defaultRank,
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

  Comment toEntity() {
    final creator = User.fromEmpty(
      uid: auhtorId,
      username: authorUsername,
      flatUsername: authorFlatUsername,
      rank: authorRank,
    );

    return Comment(
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
