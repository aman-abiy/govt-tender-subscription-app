import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/alert_emails.dart';
import 'package:alpha_tenders_mobile_app/providers/error.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/utils/loader_handler.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  String errorMessage;

  handleDioError(DioError e) {
    LoaderHandler.clearLoaders();

    switch (e.type) {
      case DioErrorType.response:
        int httpCode = e.response.statusCode;

        print('error  => ${e.response.data['message']}');
        print('error  => ${e.response.statusCode}');
        
        // bad request
        if (httpCode == 400) {
          errorMessage = e.response.data['message'];
        }

        // unauthenticated
        if (httpCode == 401) {
          errorMessage = e.response.data['message'];
          if(AccountProvider().isLoggedIn()) {
            AccountProvider().logout();
            AccountProvider().logoutLocally();
          }
        }

        // access denied
        if (httpCode == 403) {
          errorMessage = e.response.data['message'];
        }

        // not found
        if (httpCode == 404) {
          errorMessage = e.response.data['message'];
        }

        // method not allowed
        if (httpCode == 405) {
          errorMessage = e.response.data['message'];
        }

        // conflict
        if (httpCode == 409) {
          errorMessage = e.response.data['message'];
        }

        // post to large
        if (httpCode == 413) {
          // errorMessage = e.response.data['message'];
          errorMessage = "Server Error";
        }

        // unsupported Media Type
        if (httpCode == 415) {
          // errorMessage = e.response.data['message'];
          errorMessage = "Server Error";
        }

        // api rate limited
        if (httpCode == 429) {
          errorMessage = e.response.data['message'];
        }

        // form validation errors
        if (httpCode == 422) {
          errorMessage = e.response.data['message'];
        }

        // 5xx Server errors
        if (httpCode >= 500) {
          errorMessage = e.response.data['message'];
        }
        ErrorProvider().setError(errorMessage);
        break;

      case DioErrorType.connectTimeout:
        errorMessage = "Connection Timeout";
        ErrorProvider().setError(errorMessage);
        break;

      case DioErrorType.receiveTimeout:
        errorMessage = "Request Timeout";
        ErrorProvider().setError(errorMessage);
        break;

      case DioErrorType.sendTimeout:
        errorMessage = "Request Timeout";
        ErrorProvider().setError(errorMessage);
        break;

      case DioErrorType.cancel:
        errorMessage = "Request Cancelled";
        ErrorProvider().setError(errorMessage);
        break;

      case DioErrorType.other:
        errorMessage = "Network Error";
        ErrorProvider().setError(errorMessage);
        break;
      default:
        errorMessage = "Network Error";
        ErrorProvider().setError(errorMessage);
        break;
      }
   }
}