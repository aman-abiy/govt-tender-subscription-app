

import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/advertisement.dart';
import 'package:alpha_tenders_mobile_app/providers/category.dart';
import 'package:alpha_tenders_mobile_app/providers/company_info.dart';
import 'package:alpha_tenders_mobile_app/providers/language.dart';
import 'package:alpha_tenders_mobile_app/providers/region.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/providers/tender_source.dart';

class LoaderHandler {
  static clearLoaders() {
    AccountProvider().clearAccountIsLoading();
    TenderProvider().clearTenderIsLoading();
    CategoryProvider().clearCategoryIsLoading();
    RegionProvider().clearRegionIsLoading();
    CompanyInfoProvider().clearCompanyIsLoading();
    TenderSourceProvider().clearTenderSourceIsLoading();
    LanguageProvider().clearLanguageIsLoading();
    AdvertisementProvider().clearAdvertisementIsLoading();
  }
}