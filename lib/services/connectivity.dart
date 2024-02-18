import 'package:alpha_tenders_mobile_app/providers/error.dart';
import 'package:alpha_tenders_mobile_app/utils/loader_handler.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService extends ChangeNotifier {
  bool hasConnection = true;

  //////////////// Singleton Constructor ///////////////////
  static final ConnectivityService _singleton = ConnectivityService._internal();

  factory ConnectivityService() {
    return _singleton;
  }

  ConnectivityService._internal();

  //////////////// Singleton Constructor ///////////////////
  
  Future<bool> checkConnectivity() async {
    ErrorProvider().setError(null);
    dynamic connectivityResult = await (Connectivity().checkConnectivity());
    print('connectivityResult ${connectivityResult}');
    if (connectivityResult == ConnectivityResult.mobile) {
      hasConnection = true;
      notifyListeners();
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      hasConnection = true;
      notifyListeners();
      return true;
    }
    hasConnection = false;
    LoaderHandler.clearLoaders();
    notifyListeners();
    return false;
  }
  
}
