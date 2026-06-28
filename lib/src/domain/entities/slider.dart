import 'package:lurp/src/domain/entities/selection.dart';

/// Represents a slider-based poll where users can vote by choosing a value along a range.
class SliderPoll {
  /// The title or question of the slider poll.
  final String title;

  /// The list of existing votes (stored or normalized).
  List<double> votes;

  /// The running average value of all cast votes.
  double averageValue;

  /// The total number of votes cast.
  int voteCount;

  /// The vote value chosen by the currently signed-in user (SIU), if any.
  double? siuVote;

  /// The starting value of the slider range.
  double? valueStart;

  /// The ending value of the slider range.
  double? valueEnd;

  /// The number of discrete segments the slider range is divided into.
  int? valueSegments;

  /// Creates a new [SliderPoll] instance.
  SliderPoll({
    required this.title,
    required this.siuVote,
    required this.averageValue,
    required this.voteCount,
    required this.votes,
    required this.valueStart,
    required this.valueEnd,
    required this.valueSegments,
  }) {
    _updateStats();
  }

  /// The string representation of the currently signed-in user's vote.
  String get formattedVote => ((siuVote ?? 0) * 10).toStringAsFixed(1);

  /// The string representation of the average vote score.
  String get formattedAverage => (averageValue * 10).toStringAsFixed(1);

  /// The minimum length required for the poll's title.
  static const int minTitleLength = SelectionPoll.minTitleLength;

  /// The maximum length allowed for the poll's title.
  static const int maxTitleLength = SelectionPoll.maxTitleLength;

  /// Casts a new vote in the poll with [newValue].
  void addVote(double newValue) {
    if (siuVote != null) return;

    if (voteCount <= 0) {
      averageValue = newValue;
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

  /// Updates internal stats by deduplicating and cleaning up the vote list.
  void _updateStats() {
    final uniqueVotes = votes.toSet();
    if (siuVote != null) {
      uniqueVotes.remove(siuVote);
    }
    votes = uniqueVotes.toList();
  }
}
