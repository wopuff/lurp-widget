import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lurp/src/config/logger.dart';
import 'connection_error/connection_error_stub.dart'
    if (dart.library.io) 'connection_error/connection_error_io.dart';

class ApiClient {
  ApiClient._({required this.apiKey, bool isProd = true})
    : baseUrl = isProd ? 'https://api.lurp.it/' : 'https://dev.api.lurp.it/' {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'X-Platform': _platformHeader,
          'X-Lurp-API-Key': apiKey,
        },
      ),
    );
  }
  static ApiClient? _instance;

  static ApiClient get instance {
    if (_instance == null) {
      throw Exception(
        'ApiClient must be initialized before use. Call Lurp.initialize(...) or ApiClient.initialize(...)',
      );
    }
    return _instance!;
  }

  static void initialize({required String apiKey, bool isProd = true}) {
    _instance = ApiClient._(apiKey: apiKey, isProd: isProd);
  }

  final String apiKey;
  final String baseUrl;
  late final Dio _dio;

  static const _platformHeader = kIsWeb ? 'web' : 'flutter';

  /// Static delegators for get and post
  static Future<Response> get(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    return instance._get(path, queryParameters: queryParameters);
  }

  static Future<Response> post(String path, [Map<String, dynamic>? data]) {
    return instance._post(path, data: data);
  }

  Future<Response> _get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      _logDioError(e);
      rethrow;
    }
  }

  Future<Response> _post(String path, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      _logDioError(e);
      rethrow;
    }
  }

  void _logDioError(DioException e) {
    logger.i(
      'Dio error:\n'
      '  [URL]: ${e.requestOptions.uri}\n'
      '  [Message]: ${e.message}\n'
      '  [Status]: ${e.response?.statusCode}\n'
      '  [Data]: ${e.response?.data}\n'
      '  [Path]: ${e.requestOptions.path}',
    );
  }

  static bool isNetworkError(DioException e) {
    final t = e.type;
    return t == DioExceptionType.connectionError ||
        t == DioExceptionType.connectionTimeout ||
        (t == DioExceptionType.unknown && isSocketException(e.error));
  }

  static int? getRateLimitSecondsRemaining(DioException e) {
    return e.response?.data['retryAfterSeconds'];
  }

  Dio get dio => _dio;
}
