import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class IntentHandler {

  static launchPhoneNumber(String phoneNumber) async {
    if (await canLaunchUrl(Uri(scheme: 'tel', path: phoneNumber))) {
      await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
    } else {
      //print('Could not launch $url');
    }
  }

  static launchEmail(String email) async {
    await launchUrl(Uri(scheme: 'mailto', path: email));
  }

  static launchTelegramChannel() async {
      await launch(TELEGRAM_CHANNEL_URL);

  }
}