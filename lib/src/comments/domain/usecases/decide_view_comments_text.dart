import 'dart:math';
import 'package:lurp/src/core/utils/format_utils.dart';

class DecideViewCommentsText {
  static String viewCommentsText(int commentCount, int topCommentCount) {
    if (commentCount == 0) {
      List<String> phrases = [
        'Be the first to comment!',
        'Comment now!',
        'Share your thoughts!',
        'Start a conversation!',
        'Have anything to say?',
        'Help others decide.',
      ];

      int index = Random().nextInt(phrases.length);
      return phrases[index];
    }

    if (commentCount - topCommentCount > 0) {
      return '+${FormatUtils.shortenNumber(commentCount - topCommentCount)} more';
    }

    List<String> phrases = [
      'Thoughts?',
      'Your take?',
      'Weigh in.',
      'Comment!',
      'Comment?',
      'Reply!',
      'Add!',
      'Join in!',
    ];

    int index = Random().nextInt(phrases.length);
    return phrases[index];
  }
}
