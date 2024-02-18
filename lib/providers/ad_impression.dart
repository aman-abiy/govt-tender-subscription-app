import 'package:alpha_tenders_mobile_app/dtos/Ad_Impression.dart';
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

class AdImpressionProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();

  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final AdImpressionProvider _singleton = AdImpressionProvider._internal();

  factory AdImpressionProvider() {
    return _singleton;
  }

  AdImpressionProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future logAdImpression(AdImpression adImpression) => asyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.AD_IMPRESSION_URL,
      method: RequestMethod.POST,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: adImpression.toMap(),
      forceRefresh: true
    );
    notifyListeners();
    isLoading = false;
    return null;
  });

  void clearAdImpressionIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
