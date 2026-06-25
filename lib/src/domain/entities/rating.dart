import 'package:lurp/src/domain/entities/selection.dart';

class RatingPoll {
  final String title;
  final int starCount;

  double averageValue;
  int voteCount;
  int? siuVote;

  RatingPoll({
    required this.title,
    required this.siuVote,
    required this.averageValue,
    required this.voteCount,
    required this.starCount,
  });

  // Fallback helper to prevent any division-by-zero layout bugs
  int get safeStarCount => starCount <= 0 ? defaultStarCount : starCount;

  String get formattedVote => (siuVote ?? 0).toStringAsFixed(1);
  String get formattedAverage => averageValue.toStringAsFixed(1);

  // constants
  static const int minTitleLength = SelectionPoll.minTitleLength;
  static const int maxTitleLength = SelectionPoll.maxTitleLength;
  static const int defaultStarCount = 5;

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
