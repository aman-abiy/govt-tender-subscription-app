import 'package:alpha_tenders_mobile_app/dtos/Bookmark_Check_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Meta.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/pagination_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class TenderProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();

  Tender tender;
  List<Tender> allTenders = [];
  List<Tender> myTenders = [];
  List<Tender> freeTenders = [];
  List<Tender> savedTenders = [];
  bool isTenderSaved = false;

  Meta allTendersMeta;
  Meta myTendersMeta;
  Meta freeTendersMeta;
  Meta savedTendersMeta;

  bool isLoading = false;
  bool allTendersIsLoading = false;
  bool myTendersIsLoading = false;
  bool freeTendersIsLoading = false;
  bool savedTendersIsLoading = false;
  bool isTenderSavedCheckLoading = false;
  bool isRefreshing = false;
  bool status = false;

  //////////////// Singleton Constructor ///////////////////
  static final TenderProvider _singleton = TenderProvider._internal();

  factory TenderProvider() {
    return _singleton;
  }

  TenderProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  
  Future<List<Tender>> getAllTenders({bool refresh = false}) => tenderListAsyncHandler(() async {
    allTendersIsLoading = true;
    if(refresh) { allTendersMeta = null; isRefreshing = true; }
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.TENDER_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'sort': '-createdAt',
        'limit': PAGE_SIZE,
        'page': PaginationHandler.pageNumber(allTendersMeta)
      },
      body: null,
      forceRefresh: refresh
    );

    if(customHttpResponse.status) {
      if(refresh) allTenders.clear();
      allTendersMeta = customHttpResponse.meta;
      customHttpResponse.data.forEach((e) => allTenders.add(Tender.fromJson(e)));
      allTendersIsLoading = false;
      isRefreshing = false;
      notifyListeners();
      return allTenders;
    }
    allTendersIsLoading = false;
    isRefreshing = false;
    notifyListeners();
    return null;
  });

  Future<List<Tender>> getMyTenders({bool refresh = false}) => tenderListAsyncHandler(() async {
    myTendersIsLoading = true;
    if(refresh) { myTendersMeta = null; isRefreshing = true; }
    
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.TENDER_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'categories': AccountProvider().account.alertCategories.join(','),
        'region': AccountProvider().account.alertRegions.join(','),
        'sort': '-createdAt',
        'limit': PAGE_SIZE,
        'page': PaginationHandler.pageNumber(myTendersMeta)
      },
      body: null,
      forceRefresh: refresh
    );

    if(customHttpResponse.status) {
      if(refresh) myTenders.clear();
      myTendersMeta = customHttpResponse.meta;
      customHttpResponse.data.forEach((e) => myTenders.add(Tender.fromJson(e)));
      myTendersIsLoading = false;
      isRefreshing = false;
      notifyListeners();
      return myTenders;
    }
    myTendersIsLoading = false;
    isRefreshing = false;
    notifyListeners();
    return null;
  });

  Future<List<Tender>> getFreeTenders({bool refresh = false}) => tenderListAsyncHandler(() async {
    freeTendersIsLoading = true;
    if(refresh) { freeTendersMeta = null; isRefreshing = true; }
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.TENDER_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'isFeatured': true,
        'sort': '-createdAt',
        'limit': PAGE_SIZE,
        'page': PaginationHandler.pageNumber(freeTendersMeta)
      },
      body: null,
      forceRefresh: refresh
    );

    if(customHttpResponse.status) {
      if(refresh) freeTenders.clear();
      freeTendersMeta = customHttpResponse.meta;
      customHttpResponse.data.forEach((e) => freeTenders.add(Tender.fromJson(e)));
      freeTendersIsLoading = false;
      isRefreshing = false;
      notifyListeners();
      return freeTenders;
    }
    freeTendersIsLoading = false;
    isRefreshing = false;
    notifyListeners();
    return null;
  });

  Future<List<Tender>> getSavedTenders({bool refresh = false}) => tenderListAsyncHandler(() async {
    savedTendersIsLoading = true;
    if(refresh) { savedTendersMeta = null; isRefreshing = true; }
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.BOOKMARK_TENDER_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'sort': '-createdAt',
        'limit': PAGE_SIZE,
        'page': PaginationHandler.pageNumber(savedTendersMeta)
      },
      body: null,
      forceRefresh: refresh
    );

    if(customHttpResponse.status) {
      if(refresh) savedTenders.clear();
      savedTendersMeta = customHttpResponse.meta;
      customHttpResponse.data.forEach((e) => { savedTenders.add(Tender.fromJson(e['tender'])) });
      savedTendersIsLoading = false;
      isRefreshing = false;
      notifyListeners();
      return savedTenders;
    }
    savedTendersIsLoading = false;
    isRefreshing = false;
    notifyListeners();
    return null;
  });

  Future<bool> bookmarkTender(Tender tender) => boolAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.BOOKMARK_TENDER_URL,
      method: RequestMethod.POST,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: {
        'tender': tender.id,
        'account': AccountProvider().account.id
      },
      forceRefresh: true
    );

    if(customHttpResponse.status) {
      // allTenders.forEach((Tender e) => {if(e.id == tender.id) { e.isSaved = !tender.isSaved}});
      // myTenders.forEach((Tender e) => {if(e.id == tender.id) { e.isSaved = !tender.isSaved}});
      if(customHttpResponse.data['isRemoved']) {
        int removeIndex;
        for(int i = 0; i < savedTenders.length; i++) {
          if (savedTenders[i].id == tender.id) { 
            removeIndex = i;
          }
        }
        if(removeIndex != null) {
          savedTenders.removeAt(removeIndex);
        }
      }
      else {
        savedTenders.insert(0, Tender.fromJson(customHttpResponse.data['tender']));
      }

      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  });

  Future<BookmarkCheckResponse> checkIfSavedTender(Tender tender) => bookmarkCheckResponseAsyncHandler(() async {
    isLoading = true;
    isTenderSavedCheckLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.CHECK_BOOKMARKED_TENDER_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: {
        'tender': tender.id,
        'account': AccountProvider().account.id
      },
      body: null,
      forceRefresh: true
    );

    if(customHttpResponse.status) {
      // allTenders.forEach((Tender e) => {if(e.id == tender.id) { e.isSaved = !tender.isSaved}});
      // myTenders.forEach((Tender e) => {if(e.id == tender.id) { e.isSaved = !tender.isSaved}});
      isLoading = false;
      isTenderSavedCheckLoading = false;
      isTenderSaved = customHttpResponse.data;
      notifyListeners();
      return BookmarkCheckResponse.fromJson({
        'status': true,
        'isSaved': customHttpResponse.data
      });
    }
    isLoading = false;
    isTenderSavedCheckLoading = false;
    isTenderSaved = false;
    notifyListeners();
    return BookmarkCheckResponse.fromJson({
      'status': false,
      'isSaved': false
    });
  });

  // since this is a background action, dont handle failure in a user perceivable way
  Future viewTender(Tender tender) async {
    customHttpResponse = await NetworkHandler().request(
      url: URLs.VIEW_TENDER_URL,
      method: RequestMethod.PUT,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: {
        '_id': tender.id
      }
    );
   }
  
  void clearTenderIsLoading() {
    isLoading = false;
    allTendersIsLoading = false;
    myTendersIsLoading = false;
    freeTendersIsLoading = false;
    savedTendersIsLoading = false;
    notifyListeners();
  }
  
}
