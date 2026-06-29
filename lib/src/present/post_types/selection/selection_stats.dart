import 'package:flutter/material.dart';
import 'package:lurp/src/core/utils/format_utils.dart';
import 'package:lurp/src/core/utils/string_utils.dart';
import 'package:lurp/src/domain/entities/selection.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/config/theme/poll_colors.dart';

class SelectionStats extends StatelessWidget {
  const SelectionStats({super.key, required this.post});
  final LurpPost post;

  SelectionPoll get poll => post.selection!;
  List<List<PollOption>> get groups => post.selection!.votedOptionGroups;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.5,
      runSpacing: 5,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (int i = 0; i < groups.length; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int j = 0; j < groups[i].length; j++)
                Builder(
                  builder: (context) {
                    // show only color indicator
                    if (j < groups[i].length - 1) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 2.5), // spacing
                        child: PollStatsColorIndicator(option: groups[i][j]),
                      );
                    }

                    // show color indicator and text
                    String percentage =
                        '${(groups[i][j].voteProportion * 100).toStringAsFixed(0)}%';
                    int voteCount = groups[i][j].voteCount;
                    String votes =
                        '${FormatUtils.shortenNumber(voteCount)} ${'vote'.plural(voteCount)} ${groups[i].length > 1 ? 'each' : ''}';

                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // color
                        PollStatsColorIndicator(option: groups[i][j]),
                        const SizedBox(width: 3),

                        // percentage
                        Text(
                          percentage,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 6),

                        // votes
                        Text(
                          votes,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  },
                ),
            ],
          ),
      ],
    );
  }
}

class PollStatsColorIndicator extends StatelessWidget {
  const PollStatsColorIndicator({super.key, required this.option});
  final PollOption option;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: PollColors.list[option.colorIndex],
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }
}
