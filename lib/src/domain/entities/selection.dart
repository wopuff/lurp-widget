/// Represents a single option in a selection poll.
class PollOption {
  /// Creates a new [PollOption] instance.
  PollOption({required this.key, required this.text, required this.voteCount});

  /// The unique key identifying this option.
  final String key;

  /// The human-readable text display for this option.
  final String text;

  /// The total number of votes this option has received.
  int voteCount;

  /// The proportion of total votes cast in the poll that went to this option (0.0 to 1.0).
  double voteProportion = 0;

  /// The index of the color assigned to this option for statistics rendering.
  int colorIndex = 0;

  /// Increments the vote count of this option.
  void incrementVoteCount() => voteCount++;

  /// Decrements the vote count of this option.
  void decrementVoteCount() => voteCount--;
}

/// Represents a multiple-choice selection poll.
class SelectionPoll {
  /// Creates a new [SelectionPoll] instance.
  SelectionPoll({
    required this.title,
    required this.options,
    required this.siuVote,
    required this.voteCount,
  }) {
    _updateStats(shuffleOptions: true);
  }

  /// Factory constructor for creating an empty poll template with optional parameter overrides.
  factory SelectionPoll.fromEmpty({
    String? title,
    List<PollOption>? options,
    String? siuVote,
  }) {
    return SelectionPoll(
      title: title ?? '',
      options: options ?? [],
      siuVote: siuVote ?? '',
      voteCount: 0,
    );
  }

  /// The title or question of the selection poll.
  final String title;

  /// The list of options available in this poll.
  final List<PollOption> options;

  /// The key of the option chosen by the currently signed-in user (SIU), if any.
  String? siuVote;

  /// The total count of votes cast in this poll.
  int voteCount;

  /// The total number of options in the poll.
  int get optionCount => options.length;

  /// Voted option groups, grouped by vote count (highest to lowest).
  List<List<PollOption>> votedOptionGroups = <List<PollOption>>[];

  /// Customized text displaying comment prompts.
  String viewCommentsText = 'Create a comment!';

  /// The minimum number of options allowed in a selection poll.
  static const int minOptionCount = 2;

  /// The maximum number of options allowed in a selection poll.
  static const int maxOptionCount = 6;

  /// The minimum length required for the poll's title.
  static const int minTitleLength = 11;

  /// The maximum length allowed for the poll's title.
  static const int maxTitleLength = 227;

  /// The minimum length required for any poll option's text.
  static const int minOptionLength = 1;

  /// The maximum length allowed for any poll option's text.
  static const int maxOptionLength = 199;

  /// Casts a vote on [voteOption].
  void addVote(PollOption? voteOption) {
    if (voteOption == null || siuVote != null) return;

    for (var option in options) {
      if (option.key == voteOption.key) {
        option.incrementVoteCount();
        break;
      }
    }

    voteCount++;
    siuVote = voteOption.key;

    _updateStats();
  }

  /// Removes the currently signed-in user's vote from the poll.
  void removeVote() {
    if (siuVote == null || siuVote!.isEmpty) return;

    for (var option in options) {
      if (option.key == siuVote) {
        option.decrementVoteCount();
        break;
      }
    }

    voteCount--;
    siuVote = null;

    _updateStats();
  }

  /// Updates internal statistics (proportions, color indexes, groupings, etc.).
  void _updateStats({bool shuffleOptions = false}) {
    // avoid updates if no votes exist
    if (voteCount == 0) return;

    // calculate proportions
    for (var option in options) {
      option.voteProportion = option.voteCount / voteCount;
    }

    // group options
    var groupedOptionsMap = <int, List<PollOption>>{};
    for (var option in options) {
      groupedOptionsMap
          .putIfAbsent(option.voteCount, () => <PollOption>[])
          .add(option);
    }
    var groupedOptions = groupedOptionsMap.values.toList();

    // shuffle options
    if (shuffleOptions) {
      groupedOptions.shuffle();
      options.clear();
      for (var group in groupedOptions) {
        group.shuffle();
        for (var option in group) {
          options.add(option);
        }
      }
    }

    // assign voted option groups
    votedOptionGroups = groupedOptions
        .where(
          (List<PollOption> group) =>
              group.isNotEmpty && group.first.voteCount > 0,
        )
        .toList();
    votedOptionGroups = votedOptionGroups;

    // sort option groups with highest vote count first
    groupedOptions.sort(
      (List<PollOption> a, List<PollOption> b) =>
          b.first.voteCount.compareTo(a.first.voteCount),
    );

    // create random color indexes, at least 4 different colors
    var colorIndexes = List<int>.generate(
      groupedOptions.length < 4 ? 3 : groupedOptions.length - 1,
      (int index) => index + 1,
    );
    colorIndexes.shuffle();
    colorIndexes.insert(0, 0); // most voted always gets index 0

    // options in each group get the same color index
    for (var i = 0; i < groupedOptions.length; i++) {
      for (var j = 0; j < groupedOptions[i].length; j++) {
        groupedOptions[i][j].colorIndex = colorIndexes[i];
      }
    }
  }
}
