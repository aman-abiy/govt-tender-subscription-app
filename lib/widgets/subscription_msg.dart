import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';

class SubscriptionMsgHandler {

  static List<dynamic> subscriptionMsg(Account account) {
    if(account.hasActiveSubscription) {
      return ['ACTIVE', HexColor('#28a745')];
    } 

    if(account.lastActiveSubscription == null && !account.hasActiveSubscription) {
      return ['PENDING', HexColor('#6c757d')];
    }

    if(account.lastActiveSubscription != null && !account.hasActiveSubscription) {
      return ['EXPIRED', HexColor('#dc3545')];
    }

    return ['', HexColor('#6c757d')];
  }
}