class InsufficientRankException implements Exception {
  InsufficientRankException([this.message = 'User rank is too low.']);
  final String message;

  @override
  String toString() => 'InSufficientRankException: $message';
}
