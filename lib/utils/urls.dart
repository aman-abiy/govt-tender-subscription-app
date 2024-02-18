class URLs {
  static const String BASE_URL = 'https://api.alphatenders.com';

  static const String API_BASE_URL = 'https://api.alphatenders.com/api';
  // static const String API_BASE_URL = 'http://192.168.0.140:8080/api';

  static const String API_VERSION = '/v1';
  static const String API_API_BASE_URL = API_BASE_URL + API_VERSION;

  static const String LOGIN_URL = API_API_BASE_URL + '/auth/login';
  static const String REGISTRATION_URL = API_API_BASE_URL + '/auth/signup';
  static const String LOGOUT_URL = API_API_BASE_URL + '/auth/logout';
  static const String REQUEST_PASSWORD_RESET_URL = API_API_BASE_URL + '/auth/requestPasswordReset';
  static const String AUTH_ACCOUNT_URL = API_API_BASE_URL + '/account/authAccount';
  static const String EDIT_ACCOUNT_URL = API_API_BASE_URL + '/account/edit-own';

  static const String TENDER_URL = API_API_BASE_URL + '/tender';
  static const String BOOKMARK_TENDER_URL = API_API_BASE_URL + '/tender/bookmark';
  static const String CHECK_BOOKMARKED_TENDER_URL = API_API_BASE_URL + '/tender/checkBookmark';
  static const String VIEW_TENDER_URL = API_API_BASE_URL + '/tender/view';

 static const String ALERT_EMIALS_URL = API_API_BASE_URL + '/emailResults';
 static const String SET_ALERT_EMAIL_READ_URL = API_API_BASE_URL + '/emailResults/openEmail';

  static const String CATEGORY_URL = API_API_BASE_URL + '/category';
  static const String REGION_URL = API_API_BASE_URL + '/region';
  static const String TENDER_SOURCE_URL = API_API_BASE_URL + '/tenderSource';
  static const String LANGUAGE_URL = API_API_BASE_URL + '/language';

  static const String ADVERTISEMENT_URL = API_API_BASE_URL + '/advertisements';
  static const String AD_IMPRESSION_URL = API_API_BASE_URL + '/adImpressions';
  static const String ADVERTISEMENT_BANNER_IMG_URL = BASE_URL + '/advertisements';
  
  static const String COMPANY_INFO_URL = API_API_BASE_URL + '/companyInfo';
}