import 'dart:math';
import 'package:lurp/src/core/utils/format_utils.dart';

class DecideViewCommentsText {
  static String viewCommentsText(int commentCount, int topCommentCount) {
    if (commentCount == 0) {
      var phrases = <String>[
        'Be the first to comment!',
        'Comment now!',
        'Share your thoughts!',
        'Start a conversation!',
        'Have anything to say?',
        'Help others decide.',
      ];

      var index = Random().nextInt(phrases.length);
      return phrases[index];
    }

    if (commentCount - topCommentCount > 0) {
      return '+${FormatUtils.shortenNumber(commentCount - topCommentCount)} more';
    }

    var phrases = <String>[
      'Thoughts?',
      'Your take?',
      'Weigh in.',
      'Comment!',
      'Comment?',
      'Reply!',
      'Add!',
      'Join in!',
    ];

    var index = Random().nextInt(phrases.length);
    return phrases[index];
  }
}
