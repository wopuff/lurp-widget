import 'package:lurp/src/config/links.dart';
import 'package:lurp/src/core/misc/post_type.dart';
import 'package:lurp/src/media/domain/media_entity.dart';
import 'package:lurp/src/domain/entities/selection.dart';
import 'package:lurp/src/domain/entities/ranking.dart';
import 'package:lurp/src/domain/entities/rating.dart';
import 'package:lurp/src/domain/entities/slider.dart';
import 'package:lurp/src/domain/entities/thought.dart';
import 'package:lurp/src/core/entities/common.dart';

class Post {
  // Info
  final String id;

  final String type;
  final String state;
  final DateTime createdAt;

  final User creator;
  final List<Comment>? topComments;
  final List<MediaEntity> media;

  // Variable data
  int commentCount;
  int upvoteCount;
  int downvoteCount;

  String siuRating;
  String? viewCommentsText;

  // Content types
  final ThoughtPost? thought;
  final SelectionPoll? selection;
  final SliderPoll? slider;
  final RatingPoll? rating;
  final RankingPoll? ranking;

  Post({
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

  // Link getters
  String get path => '/p/$id';
  String get fullUrl => '${Links.currentBaseUrl}/p/$id';

  // Content getters
  bool get isThought => type == thoughtType && thought != null;
  bool get isPoll => type != thoughtType;

  bool get isSelection => type == optionType && selection != null;
  bool get isSlider => type == sliderType && slider != null;
  bool get isRating => type == ratingType && rating != null;
  bool get isRanking => type == rankingType && ranking != null;

  List<Object?> get allContentTypes => [
    thought,
    selection,
    slider,
    rating,
    ranking,
  ];
  List<Object?> get allPollContent => [selection, slider, rating, ranking];
  bool get hasContent => allContentTypes.any((content) => content != null);

  String? get title => selection?.title ?? slider?.title ?? rating?.title;

  // Poll getters
  // ** IMPLEMENT POLL CLASS AND MAKE OTHER CLASSESS INHERIT THIS. THAT WILL SIMPLIFY THIS PROCESS **
  // int get voteCount {
  //   for (var content in allPollContent) {
  //     if (content != null) {
  //       if (content is SliderPoll) return content.voteCount;
  //     }
  //   }
  // }

  void addVote(PollOption? option, double? value) {
    selection?.addVote(option);
    slider?.addVote(value ?? 0);
    rating?.addVote(value?.toInt() ?? 0);
    ranking?.addVote();
  }

  void removeVote() {
    selection?.removeVote();
    slider?.removeVote();
    rating?.removeVote();
    ranking?.removeVote();
  }

  factory Post.fromEmpty({
    String? id,
    String? type,
    String? state,
    DateTime? createdAt,
    int? commentCount,
    int? upvoteCount,
    int? downvoteCount,
    User? creator,
    List<Comment>? topComments,
    List<MediaEntity>? media,
    String? viewCommentsText,
    SelectionPoll? poll,
    ThoughtPost? thought,
    SliderPoll? slider,
  }) {
    return Post(
      id: id ?? '',
      type: type ?? '',
      state: state ?? '',
      createdAt: createdAt ?? DateTime.now(),
      commentCount: commentCount ?? 0,
      upvoteCount: upvoteCount ?? 0,
      downvoteCount: downvoteCount ?? 0,
      creator: creator ?? User.unknown(),
      topComments: topComments ?? [],
      media: media ?? [],
      siuRating: '',
      selection: poll,
      thought: thought,
      slider: slider,
    );
  }

  static final String thoughtType = PostType.thought.name;
  static final String optionType = PostType.selection.name;
  static final String sliderType = PostType.slider.name;
  static final String ratingType = PostType.rating.name;
  static final String rankingType = PostType.ranking.name;
}
