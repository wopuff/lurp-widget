import 'package:flutter/material.dart';
import 'package:lurp/src/domain/entities/selection.dart';
import 'package:lurp/src/domain/entities/lurp_post.dart';
import 'package:lurp/src/present/posts/selection/poll_options.dart';
import 'package:lurp/src/present/posts/selection/selection_stats.dart';

class SelectionWidget extends StatelessWidget {
  const SelectionWidget({super.key, required this.post});
  final LurpPost post;

  SelectionPoll get poll => post.selection!;
  List<PollOption> get options => post.selection!.options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PollOptionsWidget(post: post),
        const SizedBox(height: 12),
        SelectionStats(post: post),
      ],
    );
  }
}
