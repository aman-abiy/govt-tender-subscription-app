import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Tender_Source.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class TenderSourceProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  List<TenderSource> tenderSources = [];

  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final TenderSourceProvider _singleton = TenderSourceProvider._internal();

  factory TenderSourceProvider() {
    return _singleton;
  }

  TenderSourceProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future<List<TenderSource>> getTenderSources() => tenderSourceListAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.TENDER_SOURCE_URL,
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
      tenderSources.clear();
      print('customHttpResponse.data reg ${customHttpResponse.data}');
      customHttpResponse.data.forEach((e) => tenderSources.add(TenderSource.fromJson(e)));
      isLoading = false;
      notifyListeners();
      return tenderSources;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  void clearTenderSourceIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
