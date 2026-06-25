class PollOption {
  final String key;
  final String text;

  int voteCount;
  double voteProportion = 0;
  int colorIndex = 0;

  PollOption({required this.key, required this.text, required this.voteCount});

  void incrementVoteCount() => voteCount++;
  void decrementVoteCount() => voteCount--;
}

class SelectionPoll {
  final String title;
  final List<PollOption> options;

  String? siuVote;
  int voteCount;

  SelectionPoll({
    required this.title,
    required this.options,
    required this.siuVote,
    required this.voteCount,
  }) {
    _updateStats(shuffleOptions: true);
  }

  int get optionCount => options.length;

  // presentation related
  List<List<PollOption>> votedOptionGroups = [];
  String viewCommentsText = 'Create a comment!';

  // constants
  static const int minOptionCount = 2;
  static const int maxOptionCount = 6;
  static const int minTitleLength = 11;
  static const int maxTitleLength = 227;
  static const int minOptionLength = 1;
  static const int maxOptionLength = 199;

  // Factory constructor for creating an empty poll with optional overrides
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

  void addVote(PollOption? voteOption) {
    if (voteOption == null || siuVote != null) return;

    for (PollOption option in options) {
      if (option.key == voteOption.key) {
        option.incrementVoteCount();
        break;
      }
    }

    voteCount++;
    siuVote = voteOption.key;

    _updateStats();
  }

  void removeVote() {
    if (siuVote == null || siuVote!.isEmpty) return;

    for (PollOption option in options) {
      if (option.key == siuVote) {
        option.decrementVoteCount();
        break;
      }
    }

    voteCount--;
    siuVote = null;

    _updateStats();
  }

  void _updateStats({bool shuffleOptions = false}) {
    // avoid updates if no votes exist
    if (voteCount == 0) return;

    // calculate proportions
    for (PollOption option in options) {
      option.voteProportion = option.voteCount / voteCount;
    }

    // group options
    Map<int, List<PollOption>> groupedOptionsMap = {};
    for (PollOption option in options) {
      groupedOptionsMap.putIfAbsent(option.voteCount, () => []).add(option);
    }
    List<List<PollOption>> groupedOptions = groupedOptionsMap.values.toList();

    // shuffle options
    if (shuffleOptions) {
      groupedOptions.shuffle();
      options.clear();
      for (List<PollOption> group in groupedOptions) {
        group.shuffle();
        for (PollOption option in group) {
          options.add(option);
        }
      }
    }

    // assign voted option groups
    votedOptionGroups = groupedOptions
        .where((group) => group.isNotEmpty && group.first.voteCount > 0)
        .toList();
    votedOptionGroups = votedOptionGroups;

    // sort option groups with highest vote count first
    groupedOptions.sort(
      (a, b) => b.first.voteCount.compareTo(a.first.voteCount),
    );

    // create random color indexes, at least 4 different colors
    List<int> colorIndexes = List.generate(
      groupedOptions.length < 4 ? 3 : groupedOptions.length - 1,
      (index) => index + 1,
    );
    colorIndexes.shuffle();
    colorIndexes.insert(0, 0); // most voted always gets index 0

    // options in each group get the same color index
    for (int i = 0; i < groupedOptions.length; i++) {
      for (int j = 0; j < groupedOptions[i].length; j++) {
        groupedOptions[i][j].colorIndex = colorIndexes[i];
      }
    }
  }
}
