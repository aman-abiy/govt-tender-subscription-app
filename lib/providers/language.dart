import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  List<Language> languages = [];

  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final LanguageProvider _singleton = LanguageProvider._internal();

  factory LanguageProvider() {
    return _singleton;
  }

  LanguageProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future<List<Language>> getLanguages() => languageListAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.LANGUAGE_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'limit': 1000
      },
      body: null
    );

    if(customHttpResponse.status) {
      languages.clear();
      print('customHttpResponse.data reg ${customHttpResponse.data}');
      customHttpResponse.data.forEach((e) => languages.add(Language.fromJson(e)));
      isLoading = false;
      notifyListeners();
      return languages;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  void clearLanguageIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
