import 'package:alpha_tenders_mobile_app/dtos/Login_Credentials.dart';
import 'package:alpha_tenders_mobile_app/dtos/Registration_Credentials.dart';
import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/models/Alert_Email.dart';
import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Meta.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/storage/account.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/pagination_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class AlertEmailsProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();

  AlertEmail alertEmail;
  List<AlertEmail> alertEmails = [];
  String sessionToken;
  bool isLoading = false;

  Meta alertEmailsMeta;

  //////////////// Singleton Constructor ///////////////////
  static final AlertEmailsProvider _singleton = AlertEmailsProvider._internal();

  factory AlertEmailsProvider() {
    return _singleton;
  }

  AlertEmailsProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future<List<AlertEmail>> getAlertEmails({bool refresh = false}) => alertEmailListAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    if(refresh) alertEmailsMeta = null;
    customHttpResponse = await NetworkHandler().request(
      url: URLs.ALERT_EMIALS_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'type': 'alert',
        'account': AccountProvider().account.id,
        'sort': '-createdAt',
        'page': PaginationHandler.pageNumber(alertEmailsMeta)
      },
      body: null,
      forceRefresh: refresh
    );

    if(customHttpResponse.status) {
      if(refresh) alertEmails.clear();
      alertEmailsMeta = customHttpResponse.meta;
      customHttpResponse.data.forEach((e) => alertEmails.add(AlertEmail.fromJson(e)));
      isLoading = false;
      notifyListeners();
      return alertEmails;
    }
    isLoading = false;
    return null;
  });

  Future<AlertEmail> getAlertEmail(String id) => alertEmailAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.ALERT_EMIALS_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        '_id': id,
        'account': AccountProvider().account.id,
        'sort': '-createdAt'
      },
      body: null
    );

    if(customHttpResponse.status) {
      alertEmail = AlertEmail.fromJson(customHttpResponse.data[0]);
      isLoading = false;
      notifyListeners();
      return alertEmail;
    }
    isLoading = false;
    return null;
  });

  Future setAlertEmailRead(int readCheckKey) => asyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.SET_ALERT_EMAIL_READ_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'readCheckKey': readCheckKey
      },
      body: null
    );

    if(customHttpResponse.status) {
      int index = alertEmails.indexWhere((AlertEmail element) => element.readCheckKey == readCheckKey);
      alertEmails[index].isOpened = true;
      notifyListeners();
    }
    print('email is already read');
  });

  void clearAlertEmailsIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
