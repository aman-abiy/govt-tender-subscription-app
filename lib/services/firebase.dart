import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/widgets/subscription_msg.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseService extends ChangeNotifier {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
  String token;

  //////////////// Singleton Constructor ///////////////////
  static final FirebaseService _singleton = FirebaseService._internal();

  factory FirebaseService() {
    return _singleton;
  }

  FirebaseService._internal();

  //////////////// Singleton Constructor ///////////////////
  
  Future<void> init() async {
    try {
      await Firebase.initializeApp();
      token = await FirebaseService().getFCMToken();
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    } catch (e) {
      print('firebase error ${e.toString()}');
    } 
  }

  Future<String> getFCMToken() async {
    token = await FirebaseMessaging.instance.getToken();
    notifyListeners();
    return token;
  }

  Future logLogin(String loginMethod) async {
    print('loginMethod $loginMethod');
    await analytics.logLogin(loginMethod: loginMethod);
  }

  Future logRegistration() async {
    await analytics.logSignUp(signUpMethod: 'email & mobile'); 
  }

  Future setUserProperties(Account account) async {
    await analytics.setUserId(id: account.id);
    await analytics.setUserProperty(name: 'subscription_status', value: SubscriptionMsgHandler.subscriptionMsg(account)[0]);
  }

  Future logPageViewEvent({String pageName}) async {
    analytics.logEvent(
      name: 'page_view',
      parameters: {
        'page_name': pageName,
      },
    );
  }
}
