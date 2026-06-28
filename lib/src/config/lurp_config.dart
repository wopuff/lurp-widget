import 'package:lurp/src/config/api_client.dart';
import 'package:lurp/src/config/links.dart';

/// Configuration entry point for the Lurp library.
class Lurp {
  /// Initializes the Lurp configuration and network clients.
  ///
  /// Requires an [apiKey] to authenticate requests, and an optional [isProd]
  /// flag to toggle between production and staging environments (defaults to true).
  static void initialize({required String apiKey, bool isProd = true}) {
    ApiClient.initialize(apiKey: apiKey, isProd: isProd);
    Links.setProdMode(isProd);
  }
}
