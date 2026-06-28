import 'package:flutter/material.dart';
import 'package:lurp/src/domain/usecases/get_post.dart';
import 'package:lurp/src/data/repositories/post_repository_impl.dart';
import 'package:lurp/src/presentation/widgets/post_widget.dart';
import 'package:lurp/src/core/widgets/progress_indicator.dart';
import 'package:lurp/src/core/entities/common.dart';

/// A stateful widget that fetches a post by its ID and renders a [PostWidget].
class LurpPostWidget extends StatefulWidget {
  /// The unique ID of the post to fetch and display.
  final String postId;

  /// Callback function triggered when the user taps on the post creator's avatar or username.
  final void Function(User creator)? onCreatorTap;

  /// Callback function triggered when the user taps the share button on the post.
  final void Function(Post post)? onShareTap;

  /// Creates a new [LurpPostWidget] widget instance.
  const LurpPostWidget({
    super.key,
    required this.postId,
    this.onCreatorTap,
    this.onShareTap,
  });

  @override
  State<LurpPostWidget> createState() => _LurpPostWidgetState();
}

class _LurpPostWidgetState extends State<LurpPostWidget> {
  late Future<Post?> _postFuture;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  @override
  void didUpdateWidget(covariant LurpPostWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.postId != widget.postId) {
      _loadPost();
    }
  }

  void _loadPost() {
    final getPost = GetPost(repository: PostRepositoryImpl());
    _postFuture = getPost.call(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Post?>(
      future: _postFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CustomProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12.5),
              ),
              child: Text(
                'This post isn\'t available.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          );
        }
        return PostWidget(
          post: snapshot.data!,
          onCreatorTap: widget.onCreatorTap,
          onShareTap: widget.onShareTap,
        );
      },
    );
  }
}
