import 'package:lurp/src/config/logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> openUrl(String url, {bool isExternal = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isExternal ? '_blank' : '_self',
    );
  }

  static Future<void> sendMail(
    String email,
    String subject,
    String body,
  ) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    try {
      if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $emailUri');
      }
    } catch (e) {
      logger.e('Failed to send email in UrlLauncherUtils.');
    }
  }
}
