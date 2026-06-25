import 'package:lurp/src/core/entities/common.dart';

class Profile {
  final User user;
  final bool siu;

  final int thoughtsCreated;
  final int pollsCreated;
  final int pollsVoted;
  final int votes;
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

  Profile({
    required this.user,
    this.siu = false,
    this.thoughtsCreated = 0,
    this.pollsCreated = 0,
    this.pollsVoted = 0,
    this.votes = 0,
    this.receivedUpvotes = 0,
    this.receivedDownvotes = 0,
    this.givenUpvotes = 0,
    this.givenDownvotes = 0,
    this.selfUpvotes = 0,
    this.givenCommentLikes = 0,
    this.receivedCommentLikes = 0,
    this.writtenComments = 0,
    this.receivedComments = 0,
    this.createdPollOptions = 0,
    this.agreeableScore = 0,
  });

  factory Profile.fromEmpty({
    User? user,
    bool? siu,
    int? thoughtsCreated,
    int? pollsCreated,
    int? pollsVoted,
    int? votes,
    int? receivedUpvotes,
    int? receivedDownvotes,
    int? givenUpvotes,
    int? givenDownvotes,
    int? selfUpvotes,
    int? givenCommentLikes,
    int? receivedCommentLikes,
    int? writtenComments,
    int? receivedComments,
    int? createdPollOptions,
    double? agreeableScore,
  }) {
    return Profile(
      user: user ?? User.fromEmpty(),
      siu: siu ?? false,
      thoughtsCreated: thoughtsCreated ?? 0,
      pollsCreated: pollsCreated ?? 0,
      pollsVoted: pollsVoted ?? 0,
      votes: votes ?? 0,
      receivedUpvotes: receivedUpvotes ?? 0,
      receivedDownvotes: receivedDownvotes ?? 0,
      givenUpvotes: givenUpvotes ?? 0,
      givenDownvotes: givenDownvotes ?? 0,
      selfUpvotes: selfUpvotes ?? 0,
      givenCommentLikes: givenCommentLikes ?? 0,
      receivedCommentLikes: receivedCommentLikes ?? 0,
      writtenComments: writtenComments ?? 0,
      receivedComments: receivedComments ?? 0,
      createdPollOptions: createdPollOptions ?? 0,
      agreeableScore: agreeableScore ?? 0,
    );
  }

  factory Profile.unknown() {
    return Profile(
      user: User.unknown(),
      siu: false,
      thoughtsCreated: 0,
      pollsCreated: 0,
      pollsVoted: 0,
      votes: 0,
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
      agreeableScore: 0,
    );
  }

  Profile copyWith({
    User? user,
    bool? siu,
    int? thoughtsCreated,
    int? pollsCreated,
    int? pollsVoted,
    int? votes,
    int? receivedUpvotes,
    int? receivedDownvotes,
    int? givenUpvotes,
    int? givenDownvotes,
    int? selfUpvotes,
    int? givenCommentLikes,
    int? receivedCommentLikes,
    int? writtenComments,
    int? receivedComments,
    int? createdPollOptions,
    double? agreeableScore,
  }) {
    return Profile(
      user: user ?? this.user,
      siu: siu ?? this.siu,
      thoughtsCreated: thoughtsCreated ?? this.thoughtsCreated,
      pollsCreated: pollsCreated ?? this.pollsCreated,
      pollsVoted: pollsVoted ?? this.pollsVoted,
      votes: votes ?? this.votes,
      receivedUpvotes: receivedUpvotes ?? this.receivedUpvotes,
      receivedDownvotes: receivedDownvotes ?? this.receivedDownvotes,
      givenUpvotes: givenUpvotes ?? this.givenUpvotes,
      givenDownvotes: givenDownvotes ?? this.givenDownvotes,
      selfUpvotes: selfUpvotes ?? this.selfUpvotes,
      givenCommentLikes: givenCommentLikes ?? this.givenCommentLikes,
      receivedCommentLikes: receivedCommentLikes ?? this.receivedCommentLikes,
      writtenComments: writtenComments ?? this.writtenComments,
      receivedComments: receivedComments ?? this.receivedComments,
      createdPollOptions: createdPollOptions ?? this.createdPollOptions,
      agreeableScore: agreeableScore ?? this.agreeableScore,
    );
  }
}
