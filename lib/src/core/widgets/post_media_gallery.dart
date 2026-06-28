import 'package:flutter/material.dart';
import 'package:lurp/src/domain/entities/post.dart';

class PostMediaGallery extends StatelessWidget {
  const PostMediaGallery({super.key, required this.post});
  final Post post;

  void _openFullScreenViewer(BuildContext context, String url) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.9),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onVerticalDragDown: (_) => Navigator.of(context).pop(),
                    child: InteractiveViewer(
                      clipBehavior: Clip.none,
                      minScale: 1.0,
                      maxScale: 4.0,
                      child: Image.network(
                        url,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  right: 16,
                  child: SafeArea(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (post.media.isEmpty) return const SizedBox.shrink();

    final primaryMedia = post.media.first;

    const double targetWidth = 1.0;
    const double targetHeight = 1.0;
    const double maxAllowedRatio = targetWidth / targetHeight;

    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _openFullScreenViewer(context, primaryMedia.url),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.5),
            child: Stack(
              children: [
                ConstraintsTransformBox(
                  constraintsTransform: (constraints) {
                    final double maxWidth = constraints.maxWidth;
                    final double maxPossibleHeight = maxWidth / maxAllowedRatio;

                    return constraints.copyWith(
                      maxHeight: maxPossibleHeight,
                      minHeight: 0,
                    );
                  },
                  alignment: Alignment.center,
                  child: Image.network(
                    primaryMedia.url,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const AspectRatio(
                        aspectRatio: maxAllowedRatio,
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const AspectRatio(
                          aspectRatio: maxAllowedRatio,
                          child: Center(
                            child: Text(
                              '⚠',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
