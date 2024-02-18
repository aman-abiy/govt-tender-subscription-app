import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Advertisement.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class AdvertisementProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  List<Advertisement> advertisements = [];

  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final AdvertisementProvider _singleton = AdvertisementProvider._internal();

  factory AdvertisementProvider() {
    return _singleton;
  }

  AdvertisementProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future<List<Advertisement>> getAdvertisements() => advertisementListAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.ADVERTISEMENT_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'limit': 2
      },
      body: null,
      forceRefresh: true
    );

    if(customHttpResponse.status) {
      advertisements.clear();
      customHttpResponse.data.forEach((e) => advertisements.add(Advertisement.fromJson(e)));
      isLoading = false;
      notifyListeners();
      return advertisements;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  void clearAdvertisementIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
