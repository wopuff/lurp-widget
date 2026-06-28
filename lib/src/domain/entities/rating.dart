import 'package:lurp/src/domain/entities/selection.dart';

/// Represents a star-rating poll where users can cast numeric votes.
class RatingPoll {
  /// The title or question of the rating poll.
  final String title;

  /// The total number of stars/levels available for voting.
  final int starCount;

  /// The running average value of all cast votes.
  double averageValue;

  /// The total number of votes cast.
  int voteCount;

  /// The vote value cast by the currently signed-in user (SIU), if any.
  int? siuVote;

  /// Creates a new [RatingPoll] instance.
  RatingPoll({
    required this.title,
    required this.siuVote,
    required this.averageValue,
    required this.voteCount,
    required this.starCount,
  });

  /// The helper that guarantees a non-zero count of stars, falling back to [defaultStarCount].
  int get safeStarCount => starCount <= 0 ? defaultStarCount : starCount;

  /// The string representation of the currently signed-in user's vote.
  String get formattedVote => (siuVote ?? 0).toStringAsFixed(1);

  /// The string representation of the average vote score.
  String get formattedAverage => averageValue.toStringAsFixed(1);

  /// The minimum length required for the poll's title.
  static const int minTitleLength = SelectionPoll.minTitleLength;

  /// The maximum length allowed for the poll's title.
  static const int maxTitleLength = SelectionPoll.maxTitleLength;

  /// The default maximum stars/options for a rating poll if none is provided.
  static const int defaultStarCount = 5;

  /// Casts a new vote in the poll with [newValue].
  void addVote(int newValue) {
    if (siuVote != null) return;

    if (voteCount <= 0) {
      averageValue = newValue.toDouble();
      voteCount = 1;
      siuVote = newValue;
      return;
    }

    averageValue = (averageValue * voteCount + newValue) / (voteCount + 1);
    voteCount++;
    siuVote = newValue;
  }

  /// Removes the currently signed-in user's vote from the poll.
  void removeVote() {
    if (siuVote == null) return;

    if (voteCount <= 1) {
      averageValue = 0;
      voteCount = 0;
      siuVote = null;
      return;
    }

    averageValue = (averageValue * voteCount - siuVote!) / (voteCount - 1);
    voteCount--;
    siuVote = null;
  }
}
