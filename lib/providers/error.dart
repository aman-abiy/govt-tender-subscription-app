import 'package:alpha_tenders_mobile_app/dtos/Custom_Http_Response.dart';
import 'package:flutter/material.dart';

class ErrorProvider extends ChangeNotifier {
  CustomHttpResponse customHttpResponse = CustomHttpResponse();
  String errorMsg;

  //////////////// Singleton Constructor ///////////////////
  static final ErrorProvider _singleton = ErrorProvider._internal();

  factory ErrorProvider() {
    return _singleton;
  }

  ErrorProvider._internal();

  //////////////// Singleton Constructor ///////////////////
  
  String setError(String error) {
    errorMsg = error;
    notifyListeners();
    return errorMsg;
  }
  
}
