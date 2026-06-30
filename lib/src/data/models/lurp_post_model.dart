import 'package:lurp/src/domain/entities/entities.dart';
import 'package:lurp/src/domain/entities/media_entity.dart';
import 'package:lurp/src/domain/entities/selection.dart';
import 'package:lurp/src/domain/entities/ranking.dart';
import 'package:lurp/src/domain/entities/rating.dart';
import 'package:lurp/src/domain/entities/slider.dart';
import 'package:lurp/src/domain/entities/thought.dart';
import 'package:lurp/src/core/logger.dart';

class LurpPostModel {
  LurpPostModel({
    required this.id,
    required this.type,
    required this.state,
    required this.authorId,
    required this.authorUsername,
    required this.authorFlatUsername,
    required this.authorRank,
    required this.userReaction,
    required this.createdAt,
    required this.commentCount,
    required this.likeCount,
    required this.dislikeCount,
    required this.voteCount,
    this.title,
    this.text,
    this.options,
    this.media,
    this.averageValue,
    this.valueVotes,
    this.valueStart,
    this.valueEnd,
    this.valueSegments,
    this.starCount,
    this.userVoteValue,
    this.userVoteOption,
  });

  factory LurpPostModel.fromData(Map<String, dynamic> data) {
    try {
      // Extremely safe numeric parsers
      double? toDouble(dynamic val) {
        if (val == null) return null;
        if (val is num) return val.toDouble();
        return double.tryParse(val.toString());
      }

      int toInt(dynamic val, {int defaultValue = 0}) {
        if (val == null) return defaultValue;
        if (val is num) return val.toInt();
        return int.tryParse(val.toString()) ?? defaultValue;
      }

      // Safely extract lists without using "as List"
      List<dynamic> getList(dynamic val) {
        if (val is List) return val;
        return [];
      }

      return LurpPostModel(
        id: data['id']?.toString() ?? 'unknown_id',
        type: data['type']?.toString() ?? 'unknown_type',
        state: data['state']?.toString() ?? 'unknown_state',
        authorId: data['authorId']?.toString() ?? LurpUser.unknownUid,
        authorUsername:
            data['authorUsername']?.toString() ?? LurpUser.unknownUsername,
        authorFlatUsername:
            data['authorFlatUsername']?.toString() ?? LurpUser.unknownUsername,
        authorRank: data['authorRank']?.toString() ?? 'member',
        createdAt:
            DateTime.tryParse(data['createdAt']?.toString() ?? '') ??
            DateTime.now(),
        userReaction: data['userReaction']?.toString(),

        commentCount: toInt(data['commentCount']),
        likeCount: toInt(data['likeCount']),
        dislikeCount: toInt(data['dislikeCount']),
        voteCount: toInt(data['voteCount']),

        averageValue: toDouble(data['averageValue']),
        title: data['title']?.toString(),
        text: data['text']?.toString(),

        // Use the safe list helper here
        options: data['pollOptions'] != null
            ? getList(
                data['pollOptions'],
              ).map((e) => Map<String, dynamic>.from(e as Map)).toList()
            : null,
        media: data['media'] != null
            ? getList(
                data['media'],
              ).map((e) => Map<String, dynamic>.from(e as Map)).toList()
            : null,

        userVoteOption: data['userVoteOptionId']?.toString(),
        userVoteValue: toDouble(data['userVoteValue']),

        valueStart: toDouble(data['valueStart']),
        valueEnd: toDouble(data['valueEnd']),
        valueSegments: toInt(data['valueSegments']),

        // Use the safe list helper here too
        valueVotes: data['valueVotes'] != null
            ? getList(
                data['valueVotes'],
              ).map((e) => toDouble(e) ?? 0.0).toList()
            : [],
      );
    } catch (e, stack) {
      // Include the stack trace so we can see EXACTLY which line is failing
      logger.e('LurpPostModel: Error converting from data: $e \n $stack');
      return LurpPostModel.unknown();
    }
  }

  factory LurpPostModel.unknown() {
    return LurpPostModel(
      id: 'unknown_id',
      type: 'unknown_type',
      state: 'unknown_state',
      authorId: LurpUser.unknownUid,
      authorUsername: LurpUser.unknownUsername,
      authorFlatUsername: LurpUser.unknownUsername,
      authorRank: 'member',
      userReaction: null,
      createdAt: DateTime.now(),
      commentCount: 0,
      likeCount: 0,
      dislikeCount: 0,
      voteCount: 0,
    );
  }
  // Info
  final String id;
  final String type;
  final String state;
  final DateTime createdAt;

  final String authorId;
  final String authorUsername;
  final String authorFlatUsername;
  final String authorRank;

  final int commentCount;
  final int likeCount;
  final int dislikeCount;
  final int voteCount;

  // Type-specific
  final String? title;
  final String? text;
  final List<Map<String, dynamic>>? options;
  final List<Map<String, dynamic>>? media;
  final double? averageValue;
  final List<double>? valueVotes;
  final double? valueStart;
  final double? valueEnd;
  final int? valueSegments;
  final int? starCount;

  // User-specific
  final String? userVoteOption;
  final double? userVoteValue;
  final String? userReaction;

  static String? ratingFromData(String? reaction) {
    if (reaction == 'like') return 'positive';
    if (reaction == 'dislike') return 'negative';
    return null;
  }

  LurpPost toEntity() {
    SelectionPoll? poll;
    ThoughtPost? thought;
    SliderPoll? slider;
    RatingPoll? rating;
    RankingPoll? ranking;

    switch (type) {
      case 'thought':
        if (text != null) {
          thought = ThoughtPost(text: text!);
        }
        break;
      case 'selection':
        if (options != null) {
          final mappedOptions = options!.map((o) {
            return PollOption(
              key: o['id'],
              text: o['text'],
              voteCount: o['voteCount'] ?? 0,
            );
          }).toList();

          poll = SelectionPoll(
            title: title ?? '',
            options: mappedOptions,
            siuVote: userVoteOption,
            voteCount: voteCount,
          );
        }
        break;
      case 'slider':
        slider = SliderPoll(
          title: title ?? '',
          averageValue: averageValue ?? 0,
          siuVote: userVoteValue,
          voteCount: voteCount,
          votes: valueVotes ?? [],
          valueStart: valueStart,
          valueEnd: valueEnd,
          valueSegments: valueSegments,
        );
        break;
      case 'rating':
        rating = RatingPoll(
          title: title ?? '',
          voteCount: voteCount,
          averageValue: averageValue ?? 0,
          siuVote: userVoteValue?.toInt(),
          starCount: starCount ?? RatingPoll.defaultStarCount,
        );
        break;
      case 'ranking':
        break;
    }

    final creator = LurpUser.fromEmpty(
      uid: authorId,
      username: authorUsername,
      flatUsername: authorFlatUsername,
      rank: authorRank,
    );

    final mappedMedia =
        media?.map((m) {
          return MediaEntity(
            key: m['id'],
            url: m['url'],
            sortOrder: m['sortOrder'],
          );
        }).toList() ??
        [];

    return LurpPost(
      id: id,
      creator: creator,
      type: type,
      state: state,
      createdAt: createdAt,
      commentCount: commentCount,
      upvoteCount: likeCount,
      downvoteCount: dislikeCount,
      topComments: null,
      media: mappedMedia,
      siuRating: ratingFromData(userReaction) ?? '',
      selection: poll,
      thought: thought,
      slider: slider,
      rating: rating,
      ranking: ranking,
    );
  }
}
