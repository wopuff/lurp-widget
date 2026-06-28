import 'package:lurp/src/core/exceptions/rate_limit_exception.dart';
import 'package:lurp/src/core/utils/format_utils.dart';

class ReturnData {
  ReturnData({
    this.name = 'return-data',
    String? title,
    this.body = '',
    this.isError = true,
    this.data,
  }) : title = title ?? 'An error occurred' {
    // Check if the body contains a specific substring and update the title
    if (title == null &&
        body.length >= 11 &&
        FormatUtils.cleanException(body).substring(0, 11) == 'Please wait') {
      this.title = 'You\'re going too fast!';
    }
  }

  factory ReturnData.fromException(Object error) {
    return ReturnData(
      isError: true,
      title: 'An error occurred',
      body: FormatUtils.cleanException(error),
    );
  }

  factory ReturnData.notSignedInError() {
    return ReturnData(
      isError: true,
      title: 'You\'re not signed in! 😣',
      body: 'Sign in to do this. It only takes a few seconds.',
    );
  }

  factory ReturnData.rateLimitError([RateLimitException? e]) {
    final time = e?.seconds != null ? '${e!.seconds}s' : 'a little while';
    return ReturnData(
      isError: true,
      title: 'You gotta calm down! 😓',
      body:
          'You\'ve sent a bit too many requests, but don\'t worry – just try again in $time.',
    );
  }

  factory ReturnData.insufficientRankError() {
    return ReturnData(
      isError: true,
      title: 'That\'s not possible...',
      body:
          'You don\'t have access to this action. Learn more by going to Rank in Settings.',
    );
  }
  final String name;
  String title;
  final String body;
  final bool isError;
  final dynamic data;

  bool equals(ReturnData error) {
    return error.title == title && error.body == body;
  }
}
