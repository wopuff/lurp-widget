class NotSignedInException implements Exception {
  NotSignedInException([this.message = 'User is not signed in.']);
  final String message;

  @override
  String toString() => 'UserNotSignedInException: $message';
}
