import 'dart:convert';

import 'package:alpha_tenders_mobile_app/main.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';

class SessionStorage {

  static storeSessionToken(String sessionToken) {
    sharedPreferences.setString(SESSION_TOKEN_SHARED_PREFERENCES_KEY, sessionToken);
  }

  static String getSessionToken() {
    return sharedPreferences.getString(SESSION_TOKEN_SHARED_PREFERENCES_KEY);
  }

  static clear() {
    sharedPreferences.remove(SESSION_TOKEN_SHARED_PREFERENCES_KEY);
  }

}