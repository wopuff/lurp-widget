class BadNetworkException implements Exception {
  final String message;

  BadNetworkException([this.message = 'Request timed out.']);

  @override
  String toString() => 'BadNetworkException: $message';
}
