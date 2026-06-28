import 'package:lurp/src/config/logger/logger.dart';
import 'package:lurp/src/core/entities/common.dart';
import 'package:lurp/src/users/domain/entities/profile.dart';

class ProfileModel {
  ProfileModel({
    required this.uid,
    required this.username,
    required this.flatUsername,
    required this.isCurrentUser,
    required this.bio,
    required this.createdPolls,
    required this.createdThoughts,
    required this.votedPolls,
    required this.receivedUpvotes,
    required this.receivedDownvotes,
    required this.givenUpvotes,
    required this.givenDownvotes,
    required this.selfUpvotes,
    required this.givenCommentLikes,
    required this.receivedCommentLikes,
    required this.writtenComments,
    required this.receivedComments,
    required this.createdPollOptions,
    required this.agreeableScore,
  });

  factory ProfileModel.fromData(Map<String, dynamic> data) {
    try {
      return ProfileModel(
        uid: data['id'] ?? User.unknownUid,
        username: data['username'] ?? User.unknownUsername,
        flatUsername: data['flatUsername'] ?? User.unknownUsername,
        isCurrentUser: data['isCurrentUser'] ?? false,
        bio: data['bio'] ?? '',
        createdPolls: data['createdPolls'] ?? 0,
        createdThoughts: data['createdThoughts'] ?? 0,
        votedPolls: data['votedPolls'] ?? 0,
        receivedUpvotes: data['receivedUpvotes'] ?? 0,
        receivedDownvotes: data['receivedDownvotes'] ?? 0,
        givenUpvotes: data['givenUpvotes'] ?? 0,
        givenDownvotes: data['givenDownvotes'] ?? 0,
        selfUpvotes: data['selfUpvotes'] ?? 0,
        givenCommentLikes: data['givenCommentLikes'] ?? 0,
        receivedCommentLikes: data['receivedCommentLikes'] ?? 0,
        writtenComments: data['writtenComments'] ?? 0,
        receivedComments: data['receivedComments'] ?? 0,
        createdPollOptions: data['createdPollOptions'] ?? 0,
        agreeableScore: data['agreeableScore'] != null
            ? (data['agreeableScore'] as num).toDouble()
            : 0.0,
      );
    } catch (e) {
      logger.e('ProfileModel: Error converting from data: $e');
      return ProfileModel.unknown();
    }
  }

  factory ProfileModel.unknown() {
    return ProfileModel(
      uid: User.unknownUid,
      username: User.unknownUsername,
      flatUsername: User.unknownUsername,
      isCurrentUser: false,
      bio: '',
      createdPolls: 0,
      createdThoughts: 0,
      votedPolls: 0,
      receivedUpvotes: 0,
      receivedDownvotes: 0,
      givenUpvotes: 0,
      givenDownvotes: 0,
      selfUpvotes: 0,
      givenCommentLikes: 0,
      receivedCommentLikes: 0,
      writtenComments: 0,
      receivedComments: 0,
      createdPollOptions: 0,
      agreeableScore: 0.0,
    );
  }
  final String uid;
  final String username;
  final String flatUsername;
  final bool isCurrentUser;
  final String bio;

  final int createdPolls;
  final int createdThoughts;
  final int votedPolls;
  final int receivedUpvotes;
  final int receivedDownvotes;
  final int givenUpvotes;
  final int givenDownvotes;
  final int selfUpvotes;
  final int givenCommentLikes;
  final int receivedCommentLikes;
  final int writtenComments;
  final int receivedComments;
  final int createdPollOptions;
  final double agreeableScore;

  Profile toEntity() {
    return Profile(
      user: User(
        uid: uid,
        username: username,
        flatUsername: flatUsername,
        bio: bio,
      ),
      siu: isCurrentUser,
      thoughtsCreated: createdThoughts,
      pollsCreated: createdPolls,
      pollsVoted: votedPolls,
      receivedUpvotes: receivedUpvotes,
      receivedDownvotes: receivedDownvotes,
      givenUpvotes: givenUpvotes,
      givenDownvotes: givenDownvotes,
      selfUpvotes: selfUpvotes,
      givenCommentLikes: givenCommentLikes,
      receivedCommentLikes: receivedCommentLikes,
      writtenComments: writtenComments,
      receivedComments: receivedComments,
      createdPollOptions: createdPollOptions,
      agreeableScore: agreeableScore,
    );
  }
}
