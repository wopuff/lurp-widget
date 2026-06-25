import 'package:lurp/src/domain/entities/selection.dart';

class SliderPoll {
  final String title;

  List<double> votes;
  double averageValue;
  int voteCount;
  double? siuVote;
  double? valueStart;
  double? valueEnd;
  int? valueSegments;

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

  String get formattedVote => ((siuVote ?? 0) * 10).toStringAsFixed(1);
  String get formattedAverage => (averageValue * 10).toStringAsFixed(1);

  // constants
  static const int minTitleLength = SelectionPoll.minTitleLength;
  static const int maxTitleLength = SelectionPoll.maxTitleLength;

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

  void _updateStats() {
    final uniqueVotes = votes.toSet();
    if (siuVote != null) {
      uniqueVotes.remove(siuVote);
    }
    votes = uniqueVotes.toList();
  }
}
