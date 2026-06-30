import 'package:dio/dio.dart';
import 'package:lurp/src/core/api/api_client.dart';

class RateLimitException implements Exception {
  // seconds remaining of rate limit

  RateLimitException({
    this.e,
    this.message = 'Too many requests.',
    int? seconds,
  }) : seconds =
           seconds ??
           (e != null ? ApiClient.getRateLimitSecondsRemaining(e) : null);
  final DioException? e;
  final String message;
  final int? seconds;

  @override
  String toString() => 'RateLimitException: $message';
}
