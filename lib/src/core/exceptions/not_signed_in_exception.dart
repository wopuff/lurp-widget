class NotSignedInException implements Exception {
  final String message;

  NotSignedInException([this.message = 'User is not signed in.']);

  @override
  String toString() => 'UserNotSignedInException: $message';
}
