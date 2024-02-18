import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/models/Meta.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/models/Tender_Source.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/pagination_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  List<Tender> tenders = [];

  String title;
  String status;

  // values ade id strings
  String language;
  String region;
  String tenderSource;
  List<String> searchCategories = [];

  Meta searchedTendersMeta;

  bool isLoading = false;
  bool isRefreshing = false;

  //////////////// Singleton Constructor ///////////////////
  static final SearchProvider _singleton = SearchProvider._internal();

  factory SearchProvider() {
    return _singleton;
  }

  SearchProvider._internal();
  //////////////// Singleton Constructor ///////////////////

  Future<List<Tender>> searchTenders({bool refresh = false}) => tenderListAsyncHandler(() async {
    isLoading = true;
    if(refresh) { searchedTendersMeta = null; isRefreshing = true; }
    notifyListeners();
    print('tenderSource $tenderSource');
    customHttpResponse = await NetworkHandler().request(
      url: URLs.TENDER_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'title': title,
        'status': status,
        'language': language,
        'region': region,
        'tenderSource': tenderSource,
        'categories': searchCategories.join(','),
        'sort': '-createdAt',
        'page': PaginationHandler.pageNumber(searchedTendersMeta)
      },
      body: null
    );

    if(customHttpResponse.status) {
      if(refresh) tenders.clear();
      searchedTendersMeta = customHttpResponse.meta;
      print('customHttpResponse.data.len ${customHttpResponse.data.length}');
      customHttpResponse.data.forEach((e) => tenders.add(Tender.fromJson(e)));
      isLoading = false;
      isRefreshing = false;
      notifyListeners();
      return tenders;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  void setSearchTitle(String searchValue) {
    title = searchValue;
    notifyListeners();
  }

  void addSearchCategory({String id, List<String> ids}) {
    if(id != null) {
      searchCategories.add(id);
    }
    if(ids != null) {
      searchCategories.addAll(ids);
    }
        print('searchCategories + $searchCategories');
    
    notifyListeners();
  }

  void removeSearchCategory({String id, List<String> ids}) {
    if(id != null) {
      searchCategories.removeWhere((element) => element == id);
    }
    if(ids != null) {
      searchCategories.removeWhere((element) => ids.contains(element));
    }
        print('searchCategories - $searchCategories');
    notifyListeners();
  }

  void clearLanguageIsLoading() {
    isLoading = false;
    notifyListeners();
  }
  
}
