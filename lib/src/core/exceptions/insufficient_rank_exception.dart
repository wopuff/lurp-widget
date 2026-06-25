class InsufficientRankException implements Exception {
  final String message;

  InsufficientRankException([this.message = 'User rank is too low.']);

  @override
  String toString() => 'InSufficientRankException: $message';
}
