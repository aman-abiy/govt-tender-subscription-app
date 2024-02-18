import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/main.dart';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/device.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  List<Category> categories = [];

  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final CategoryProvider _singleton = CategoryProvider._internal();

  factory CategoryProvider() {
    return _singleton;
  }

  CategoryProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  Future<List<Category>> getCategories() => categoryListAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.CATEGORY_URL,
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
      categories.clear();
      customHttpResponse.data.forEach((e) => categories.add(Category.fromJson(e)));
      isLoading = false;
      notifyListeners();
      return categories;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  Future<bool> updateAlertCategories() => boolAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    // deviceInfo ??= await DeviceService().getDeviceInfo();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.EDIT_ACCOUNT_URL,
      method: RequestMethod.PUT,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: {
        'alertCategories': AccountProvider().alertCategories,
        'deviceInfo': deviceInfo.toMap()
      }
    );
    print('customHttpResponse.status ${customHttpResponse.data['alertCategories']}');
    if(customHttpResponse.status) {
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  });

  void clearCategoryIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
