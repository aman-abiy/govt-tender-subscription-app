import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/models/Company_Info.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class CompanyInfoProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  CompanyInfo companyInfo;
  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final CompanyInfoProvider _singleton = CompanyInfoProvider._internal();

  factory CompanyInfoProvider() {
    return _singleton;
  }

  CompanyInfoProvider._internal();

  //////////////// Singleton Constructor ///////////////////
  
  Future<CompanyInfo> getCompanyInfo() => companyInfoAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.COMPANY_INFO_URL,
      method: RequestMethod.GET,
      headers: null,
      queryParams: null,
      body: null
    );

    if(customHttpResponse.status) {
      print('customHttpResponse.data coinfo ${customHttpResponse.data}');
      companyInfo = CompanyInfo.fromJson(customHttpResponse.data);
      isLoading = false;
      notifyListeners();
      return companyInfo;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  void clearCompanyIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
