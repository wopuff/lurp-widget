import 'package:lurp/src/config/api_client.dart';
import 'package:lurp/src/config/links.dart';

class Lurp {
  static void initialize({required String apiKey, bool isProd = true}) {
    ApiClient.initialize(apiKey: apiKey, isProd: isProd);
    Links.setProdMode(isProd);
  }
}
