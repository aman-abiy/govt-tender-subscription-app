import 'package:alpha_tenders_mobile_app/dtos/Bookmark_Check_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/models/Advertisement.dart';
import 'package:alpha_tenders_mobile_app/models/Alert_Email.dart';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Company_Info.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/models/Tender_Source.dart';

Future asyncHandler(Function fn) async {
  // try {
    return await fn();
  // } catch (e) {
  //   print('asyncHandler error => ${e.toString()}');
  //   LoaderHandler.clearLoaders();
  //   ErrorProvider().setError(GLOBAL_ASYNC_HANDLER_ERROR_MSG);
  // }
}  

// ignore: missing_return
Future<Account> accountAsyncHandler(Function fn) async {
  return await asyncHandler(fn);
}

// ignore: missing_return
Future<bool> boolAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<BookmarkCheckResponse> bookmarkCheckResponseAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<AlertEmail>> alertEmailListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<AlertEmail> alertEmailAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<Category>> categoryListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<Category> categoryAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<CompanyInfo> companyInfoAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<Language>> languageListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<Region>> regionListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<Tender>> tenderListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<TenderSource>> tenderSourceListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}

// ignore: missing_return
Future<List<Advertisement>> advertisementListAsyncHandler(Function fn) async {
   return await asyncHandler(fn);
}