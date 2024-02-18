import 'dart:convert';

import 'package:alpha_tenders_mobile_app/main.dart';
import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';

class AccountStorage {

  static storeAccount(Account account) {
    sharedPreferences.setString(ACCOUNT_SHARED_PREFERENCES_KEY, json.encode(account.toJson()));
  }

  static Account getAccount() {
    return Account.fromJson(json.decode(sharedPreferences.getString(ACCOUNT_SHARED_PREFERENCES_KEY)));
  }

  static clear() {
    sharedPreferences.remove(ACCOUNT_SHARED_PREFERENCES_KEY);
  }

}