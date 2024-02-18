import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/main.dart';
import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/device.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class RegionProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  List<Region> regions = [];

  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final RegionProvider _singleton = RegionProvider._internal();

  factory RegionProvider() {
    return _singleton;
  }

  RegionProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future<List<Region>> getRegions() => regionListAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.REGION_URL,
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
      regions.clear();
      print('customHttpResponse.data reg ${customHttpResponse.data}');
      customHttpResponse.data.forEach((e) => regions.add(Region.fromJson(e)));
      isLoading = false;
      notifyListeners();
      return regions;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  Future<bool> updateAlertRegions() => boolAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    deviceInfo ??= await DeviceService().getDeviceInfo();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.EDIT_ACCOUNT_URL,
      method: RequestMethod.PUT,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: {
        'alertRegions': AccountProvider().alertRegions,
        'deviceInfo': deviceInfo.toMap()
      }
    );

    if(customHttpResponse.status) {
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  });

  void clearRegionIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
