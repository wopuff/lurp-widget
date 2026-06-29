import 'package:lurp/src/config/lurp_config.dart';
import 'package:lurp/src/core/misc/post_type.dart';
import 'package:lurp/src/core/entities/media_entity.dart';
import 'package:lurp/src/domain/entities/selection.dart';
import 'package:lurp/src/domain/entities/ranking.dart';
import 'package:lurp/src/domain/entities/rating.dart';
import 'package:lurp/src/domain/entities/slider.dart';
import 'package:lurp/src/domain/entities/thought.dart';
import 'package:lurp/src/core/entities/common.dart';

/// Represents a post within the Lurp system, which can be of various types (e.g. thought, selection, slider, rating, ranking).
class LurpPost {
  /// Creates a new [LurpPost] instance.
  LurpPost({
    required this.id,
    required this.type,
    required this.state,
    required this.createdAt,
    required this.commentCount,
    required this.upvoteCount,
    required this.downvoteCount,
    required this.creator,
    required this.topComments,
    required this.media,
    required this.siuRating,
    this.selection,
    this.thought,
    this.slider,
    this.rating,
    this.ranking,
  });

  /// Factory constructor to create an empty [LurpPost] template with optional overrides.
  factory LurpPost.fromEmpty({
    String? id,
    String? type,
    String? state,
    DateTime? createdAt,
    int? commentCount,
    int? upvoteCount,
    int? downvoteCount,
    LurpUser? creator,
    List<LurpComment>? topComments,
    List<MediaEntity>? media,
    String? viewCommentsText,
    SelectionPoll? poll,
    ThoughtPost? thought,
    SliderPoll? slider,
  }) {
    return LurpPost(
      id: id ?? '',
      type: type ?? '',
      state: state ?? '',
      createdAt: createdAt ?? DateTime.now(),
      commentCount: commentCount ?? 0,
      upvoteCount: upvoteCount ?? 0,
      downvoteCount: downvoteCount ?? 0,
      creator: creator ?? LurpUser.unknown(),
      topComments: topComments ?? [],
      media: media ?? [],
      siuRating: '',
      selection: poll,
      thought: thought,
      slider: slider,
    );
  }

  /// The unique identifier of the post.
  final String id;

  /// The type of post (e.g. "thought", "selection", etc.).
  final String type;

  /// The state of the post (e.g. active, deleted, flagged).
  final String state;

  /// The timestamp when the post was created.
  final DateTime createdAt;

  /// The user who created the post.
  final LurpUser creator;

  /// The list of top comments associated with this post.
  final List<LurpComment>? topComments;

  /// The media attachments (images, videos, etc.) in this post.
  final List<MediaEntity> media;

  /// The total count of comments on this post.
  int commentCount;

  /// The total count of upvotes on this post.
  int upvoteCount;

  /// The total count of downvotes on this post.
  int downvoteCount;

  /// The rating action of the currently signed-in user (SIU) on this post.
  String siuRating;

  /// The customized button text for viewing comments.
  String? viewCommentsText;

  /// The selection poll content, if this is a selection/options post.
  final ThoughtPost? thought;

  /// The selection poll content, if this is a selection poll.
  final SelectionPoll? selection;

  /// The slider poll content, if this is a slider poll.
  final SliderPoll? slider;

  /// The rating poll content, if this is a rating poll.
  final RatingPoll? rating;

  /// The ranking poll content, if this is a ranking poll.
  final RankingPoll? ranking;

  /// The relative URL route path for the post.
  String get path => '/p/$id';

  /// The absolute URL for the post.
  String get fullUrl => '${LurpConfig.baseUrl}/p/$id';

  /// Returns true if this is a plain text/thought post.
  bool get isThought => type == thoughtType && thought != null;

  /// Returns true if this post contains a poll (selection, slider, rating, or ranking).
  bool get isPoll => type != thoughtType;

  /// Returns true if this is a selection/options poll.
  bool get isSelection => type == optionType && selection != null;

  /// Returns true if this is a slider poll.
  bool get isSlider => type == sliderType && slider != null;

  /// Returns true if this is a rating poll.
  bool get isRating => type == ratingType && rating != null;

  /// Returns true if this is a ranking poll.
  bool get isRanking => type == rankingType && ranking != null;

  /// Returns a list of all content type models in this post.
  List<Object?> get allContentTypes => [
    thought,
    selection,
    slider,
    rating,
    ranking,
  ];

  /// Returns a list of all poll content type models in this post.
  List<Object?> get allPollContent => [selection, slider, rating, ranking];

  /// Returns true if the post has any valid content.
  bool get hasContent => allContentTypes.any((content) => content != null);

  /// The title of the post (retrieved from selection, slider, or rating sub-elements).
  String? get title => selection?.title ?? slider?.title ?? rating?.title;

  /// Casts a vote on the active poll type.
  void addVote(PollOption? option, double? value) {
    selection?.addVote(option);
    slider?.addVote(value ?? 0);
    rating?.addVote(value?.toInt() ?? 0);
    ranking?.addVote();
  }

  /// Removes a vote from the active poll type.
  void removeVote() {
    selection?.removeVote();
    slider?.removeVote();
    rating?.removeVote();
    ranking?.removeVote();
  }

  /// String constant matching the type name for a thought post.
  static final String thoughtType = PostType.thought.name;

  /// String constant matching the type name for an option/selection poll.
  static final String optionType = PostType.selection.name;

  /// String constant matching the type name for a slider poll.
  static final String sliderType = PostType.slider.name;

  /// String constant matching the type name for a rating poll.
  static final String ratingType = PostType.rating.name;

  /// String constant matching the type name for a ranking poll.
  static final String rankingType = PostType.ranking.name;
}
