import 'package:dio/dio.dart';
import 'package:lurp/src/config/api_client.dart';

class RateLimitException implements Exception {
  final DioException? e;
  final String message;
  final int? seconds; // seconds remaining of rate limit

  RateLimitException({
    this.e,
    this.message = 'Too many requests.',
    int? seconds,
  }) : seconds =
           seconds ??
           (e != null ? ApiClient.getRateLimitSecondsRemaining(e) : null);

  @override
  String toString() => 'RateLimitException: $message';
}
