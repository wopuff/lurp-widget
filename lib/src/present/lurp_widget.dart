import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lurp/src/core/lurp_config.dart';
import 'package:lurp/src/core/api/api_client.dart';
import 'package:lurp/src/domain/entities/entities.dart';
import 'package:lurp/src/present/common/post_media_gallery.dart';
import 'package:lurp/src/present/common/progress_indicator.dart';
import 'package:lurp/src/data/repositories/lurp_post_repository_impl.dart';
import 'package:lurp/src/domain/usecases/get_post.dart';
import 'package:lurp/src/present/comments/top_comments.dart';
import 'package:lurp/src/present/posts/rating/rating_widget.dart';
import 'package:lurp/src/present/posts/selection/selection_widget.dart';
import 'package:lurp/src/present/posts/slider/slider_widget.dart';
import 'package:lurp/src/present/posts/thought/thought_widget.dart';
import 'package:lurp/src/present/posts/shared/infobar.dart';
import 'package:lurp/src/present/posts/shared/post_title.dart';

/// A widget that displays a [LurpPost]. It can either render a local/in-memory `LurpPost` model
/// immediately or fetch a post by its ID dynamically from the Lurp API.
class Lurp extends StatefulWidget {
  /// Renders a post directly using the provided [LurpPost] entity.
  const Lurp.local({
    super.key,
    required LurpPost post,
    this.onCreatorTap,
    this.onShareTap,
  }) : _post = post,
       _postId = null;

  /// Fetches a post by its ID from the Lurp API and renders it.
  const Lurp({
    super.key,
    required String postId,
    this.onCreatorTap,
    this.onShareTap,
  }) : _post = null,
       _postId = postId;

  /// Initializes the Lurp configuration and network clients.
  ///
  /// Optionally accepts an [apiKey] if you have a Lurp API key to authenticate requests.
  static void initialize({String? apiKey}) {
    ApiClient.initialize(apiKey: apiKey);
  }

  /// The web base URL used for posts and profile links.
  static String get baseUrl => LurpConfig.baseUrl;
  static set baseUrl(String value) => LurpConfig.baseUrl = value;

  final LurpPost? _post;
  final String? _postId;

  /// Callback function triggered when the user taps on the post creator's avatar or username.
  final void Function(LurpUser creator)? onCreatorTap;

  /// Callback function triggered when the user taps the share button on the post.
  final void Function(LurpPost post)? onShareTap;

  @override
  State<Lurp> createState() => _LurpState();
}

class _LurpState extends State<Lurp> {
  Future<LurpPost?>? _postFuture;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  @override
  void didUpdateWidget(covariant Lurp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._postId != widget._postId) {
      _loadPost();
    }
  }

  void _loadPost() {
    if (widget._postId != null) {
      final getPost = GetPost(repository: LurpPostRepositoryImpl());
      _postFuture = getPost.call(widget._postId!);
    } else {
      _postFuture = null;
    }
  }

  void _sharePost(BuildContext context, LurpPost post) {
    if (widget.onShareTap != null) {
      widget.onShareTap!(post);
    } else {
      Clipboard.setData(ClipboardData(text: post.fullUrl));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copied to clipboard!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildPostContent(BuildContext context, LurpPost post) {
    if (!post.hasContent) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(12.5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12.5),
          ),
          child: const Text('This post isn\'t available.'),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // post info
        PostInfoBar(
          post: post,
          onCreatorTap: widget.onCreatorTap,
          sharePost: () => _sharePost(context, post),
        ),
        SizedBox(height: post.isSelection ? 14 : 12.5),

        // title
        if (post.title != null)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 6),
            child: PostTitle(title: post.title!),
          ),

        // potential image
        if (post.media.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
            child: PostMediaGallery(post: post),
          ),

        // content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Builder(
            builder: (context) {
              if (post.isThought) return ThoughtWidget(thought: post.thought!);
              if (post.isSelection) return SelectionWidget(post: post);
              if (post.isSlider) return SliderWidget(post: post);
              if (post.isRating) return RatingWidget(post: post);
              return const SizedBox.shrink();
            },
          ),
        ),

        const SizedBox(height: 7),

        // top comments
        PostTopComments(post: post),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget._post != null) {
      return _buildPostContent(context, widget._post!);
    }

    return FutureBuilder<LurpPost?>(
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
        return _buildPostContent(context, snapshot.data!);
      },
    );
  }
}
