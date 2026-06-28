/// Represents a ranking-based poll where users can rank options.
class RankingPoll {
  /// Creates a new [RankingPoll] instance with the specified [text].
  RankingPoll({required this.text});

  /// The question or title text of the ranking poll.
  final String text;

  /// The minimum length required for the poll's text.
  static const int minTextLength = 11;

  /// The maximum length allowed for the poll's text.
  static const int maxTextLength = 1999;

  /// Casts a vote on the ranking poll.
  void addVote() {}

  /// Removes a vote from the ranking poll.
  void removeVote() {}
}
