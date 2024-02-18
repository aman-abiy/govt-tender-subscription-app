import 'package:alpha_tenders_mobile_app/dtos/Login_Credentials.dart';
import 'package:alpha_tenders_mobile_app/dtos/Registration_Credentials.dart';
import 'package:alpha_tenders_mobile_app/main.dart';
import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';
import 'package:alpha_tenders_mobile_app/models/Session_Activity.dart';
import 'package:alpha_tenders_mobile_app/providers/error.dart';
import 'package:alpha_tenders_mobile_app/services/device.dart';
import 'package:alpha_tenders_mobile_app/services/firebase.dart';
import 'package:alpha_tenders_mobile_app/services/network.dart';
import 'package:alpha_tenders_mobile_app/storage/account.dart';
import 'package:alpha_tenders_mobile_app/storage/session_token.dart';
import 'package:alpha_tenders_mobile_app/enums/request_methods.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/services/session_activity.dart';
import 'package:alpha_tenders_mobile_app/utils/session_activity_types.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();

  Account account;
  String sessionToken;
  bool hasActiveSubscription;
  bool alertStatus = false;
  // list of alertcategory id strings
  List<String> alertCategories = [];
  // list of alertregion id strings
  List<String> alertRegions = [];
  bool isLoading = false;

  //////////////// Singleton Constructor ///////////////////
  static final AccountProvider _singleton = AccountProvider._internal();

  factory AccountProvider() {
    return _singleton;
  }

  AccountProvider._internal();

  //////////////// Singleton Constructor ///////////////////

  
  Future<Account> register(RegistrationCredentials registrationCredentials) => accountAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    registrationCredentials.mobileDeviceInfo = await DeviceService().getUserDevice();
    deviceInfo ??= await DeviceService().getDeviceInfo();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.REGISTRATION_URL,
      method: RequestMethod.POST,
      headers: null,
      queryParams: null,
      body: {...registrationCredentials.toMap(), ...{'deviceInfo': deviceInfo.toMap()}}
    );

    if(customHttpResponse.status) {
      sessionToken = customHttpResponse.sessionToken;
      account = Account.fromJson(customHttpResponse.data);
      isLoading = false;
      notifyListeners();
      
      SessionStorage.storeSessionToken(sessionToken);
      AccountStorage.storeAccount(account);

      String token = await FirebaseService().getFCMToken();
      updateFCMToken(token);
      FirebaseService().logRegistration();
      FirebaseService().setUserProperties(account);
      return account;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  Future<Account> login(LoginCredentials loginCredentials) => accountAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    loginCredentials.mobileDeviceInfo = await DeviceService().getUserDevice();
    deviceInfo ??= await DeviceService().getDeviceInfo();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.LOGIN_URL,
      method: RequestMethod.POST,
      headers: null,
      queryParams: null,
      body: {...loginCredentials.toMap(), ...{'deviceInfo': deviceInfo.toMap()}}
    );

    if(customHttpResponse.status) {
      sessionToken = customHttpResponse.sessionToken;
      account = Account.fromJson(customHttpResponse.data);
      isLoading = false;
      notifyListeners();

      SessionStorage.storeSessionToken(sessionToken);
      AccountStorage.storeAccount(account);

      String token = await FirebaseService().getFCMToken();
      updateFCMToken(token);
      FirebaseService().logLogin(loginCredentials.email != null ? EMAIL_LOGIN_METHOD : MOBILE_LOGIN_METHOD);
      FirebaseService().setUserProperties(account);
      return account;
    }
    isLoading = false;
    notifyListeners();
    return null;
  });

  Future<Account> getAccount() => accountAsyncHandler(() async {
    customHttpResponse = await NetworkHandler().request(
      url: URLs.AUTH_ACCOUNT_URL,
      method: RequestMethod.GET,
      headers: {
        'Authorization': 'Bearer $sessionToken'
      },
      queryParams: null,
      body: null,
      forceRefresh: true
    );

    if(customHttpResponse.status) {
      account = Account.fromJson(customHttpResponse.data);
      hasActiveSubscription = account.hasActiveSubscription; 
      alertStatus = account.alertStatus;
      alertCategories = account.alertCategories;
      alertRegions = account.alertRegions;
      AccountStorage.storeAccount(account);
      FirebaseService().setUserProperties(account);
      notifyListeners();
      return account;
    }
    return null;
  });

  Future<bool> updateAlertStatus(bool alertStatus) => boolAsyncHandler(() async {
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
        'alertStatus': alertStatus,
        'deviceInfo': deviceInfo.toMap()
      },
      forceRefresh: true
    );

    if(customHttpResponse.status) {
      AccountProvider().alertStatus = alertStatus;
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  });

  Future<bool> updateFCMToken(String fcmToken) => boolAsyncHandler(() async {    
    customHttpResponse = await NetworkHandler().request(
      url: URLs.EDIT_ACCOUNT_URL,
      method: RequestMethod.PUT,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: {
        'fcmToken': fcmToken,
        'deviceInfo': deviceInfo?.toMap()
      }
    );

    if(customHttpResponse.status) {
      return true;
    }
    return false;
  });

  Future<bool> changeEmail(LoginCredentials loginCredentials) => boolAsyncHandler(() async {
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
        'email': loginCredentials.email,
        'deviceInfo': deviceInfo.toMap()
      },
      forceRefresh: true
    );

    if(customHttpResponse.status) {
      account = Account.fromJson(customHttpResponse.data);
      AccountStorage.storeAccount(account);
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  });

  Future<bool> changePassword(LoginCredentials loginCredentials) => boolAsyncHandler(() async {
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
        'password': loginCredentials.password,
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

  Future<bool> sendPasswordResetLink(LoginCredentials loginCredentials) => boolAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.REQUEST_PASSWORD_RESET_URL,
      method: RequestMethod.POST,
      headers: null,
      queryParams: null,
      body: {
        'email': loginCredentials.email
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

  void setSessionToken() {
    sessionToken = SessionStorage.getSessionToken();
    notifyListeners();
  }

  void setAccount() {
    account = AccountStorage.getAccount();
    notifyListeners();
  }

  bool isLoggedIn() {
    if(sessionToken != null) {
      return true;
    }
    return false;
  }

  void addAlertCategory({String id, List<String> ids}) {
    if(id != null) {
      alertCategories.add(id);
    }
    if(ids != null) {
      alertCategories.addAll(ids);
    }
    notifyListeners();
  }

  void removeAlertCategory({String id, List<String> ids}) {
    if(id != null) {
      alertCategories.removeWhere((element) => element == id);
    }
    if(ids != null) {
      alertCategories.removeWhere((element) => ids.contains(element));
    }
    notifyListeners();
  }

  void addAlertRegion(String id) {
    alertRegions.add(id);
    notifyListeners();
  }

  void removeAlertRegion(String id) {
    alertRegions.removeWhere((element) => element == id);
    notifyListeners();
  }

  void clearAccountIsLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<bool> logout() => boolAsyncHandler(() async {
    isLoading = true;
    notifyListeners();
    deviceInfo ??= await DeviceService().getDeviceInfo();
    customHttpResponse = await NetworkHandler().request(
      url: URLs.LOGOUT_URL,
      method: RequestMethod.POST,
      headers: {
        'Authorization': 'Bearer ${AccountProvider().sessionToken}'
      },
      queryParams: null,
      body: {
        'deviceInfo': deviceInfo.toMap()
      }
    );

    if(customHttpResponse.status) {
      sessionToken = null;
      account = null;
      AccountStorage.clear();
      SessionStorage.clear();
      isLoading = false;
      notifyListeners();
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  });

  // for when logging out the user on the background from device
  logoutLocally() {
    sessionToken = null;
    account = null;
    AccountStorage.clear();
    SessionStorage.clear();
    isLoading = false;
    notifyListeners();
  }
  
}
