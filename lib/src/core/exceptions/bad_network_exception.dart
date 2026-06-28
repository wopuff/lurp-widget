class BadNetworkException implements Exception {
  BadNetworkException([this.message = 'Request timed out.']);
  final String message;

  @override
  String toString() => 'BadNetworkException: $message';
}
