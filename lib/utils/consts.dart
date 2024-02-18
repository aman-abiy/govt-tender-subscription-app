import 'package:flutter/foundation.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

const bool DEBUG_MODE = kDebugMode;

// const String LOGIN_PAGE = 'login_page';
// const String REGISTRATION_PAGE = 'registration_page';

const String ALPHA_TENDERS = 'Alpha Tenders';

const String ACCOUNT_SHARED_PREFERENCES_KEY = 'account_shared_pref';
const String SESSION_TOKEN_SHARED_PREFERENCES_KEY = 'session_token_shared_pref';

PhoneNumber INITIAL_PHONE_NUMBER_COUNTRY = PhoneNumber(isoCode: 'ET');
const String COMPANY_PHONE_NUMBER_1 = '+251948016062';
const String COMPANY_PHONE_NUMBER_2 = '+251961138866';
const String COMPANY_EMAIL = 'info@alphatenders.com';
const String TELEGRAM_CHANNEL_URL = 'https://t.me/tenderFreeService';

const String SUBSCRIPTION_PACKAGES_PAGE_LINK = 'https://alphatenders.com/#/packages';

const String ALL_TENDERS_PAGE_TITLE = 'All Tenders';
const String MY_TENDERS_PAGE_TITLE = 'My Tenders';
const String FREE_TENDERS_PAGE_TITLE = 'Free Tenders';
const String SAVED_TENDERS_PAGE_TITLE = 'Saved Tenders';
const String ACCOUNT_PAGE_TITLE = 'Account';
const String USER_PROFILE_PAGE_TITLE = 'User Profile';
const String SUBSCRIPTION_AND_BILLING_PAGE_TITLE = 'Subscription and Billing';
const String ALERT_EMAILS_PAGE_TITLE = 'Alert Emails';
const String SETTINGS_PAGE_TITLE = 'Settings';
const String CONTACT_US_PAGE_TITLE = 'Contact Us';
const String ALERT_CATEGORIES_PAGE_TITLE = 'Alert Categories';
const String ALERT_REGIONS_PAGE_TITLE = 'Alert Regions';
const String SUBSCRIPTION_PACKAGES_PAGE_TITLE = 'Subscription Packages';
const String CHANGE_EMAIL_PAGE_TITLE = 'Change Email';
const String CHANGE_PASSWORD_PAGE_TITLE = 'Change Password';
const String FORGOT_PASSWORD_PAGE_TITLE = 'Forgot Password';

const String ALERT_SETTINGS_UPDATED_STATUS_MSG = 'Alert Settings Updated';
const String ALERT_SETTINGS_UPDATE_FAILED_STATUS_MSG = 'Could not update Alert Settings';
const String GLOBAL_ASYNC_HANDLER_ERROR_MSG = 'Error! Please try again.';
const String NO_SEARCH_CRITERIA_SELECTED_ERROR_MSG = 'Please select a search criteria.';

const String EMAIL_UPDATED_STATUS_MSG = 'Email successfully updated';
const String EMAIL_UPDATE_FAILED_STATUS_MSG = 'Could not update Email';
const String NO_CHANGE_IN_EMAIL_STATUS_MSG = 'No change in Email detected';

const String PASSWORD_RESET_LINK_SENT_STATUS_MSG = 'Password rest link has been sent to your email.';

const String PASSWORD_CHANGED_STATUS_MSG = 'Password successfully updated';
const String PASSWORD_CHANGE_FAILED_STATUS_MSG = 'Could not update password';

const String LOGOUT_UNSUCCESSFUL_STATUS_MSG = 'Unable to logout. Please make sure you have an active connection.';

const String TENDER_REFRESH_UP_TO_DATE_STATUS_MSG = 'You are up-to-date.';
const String TENDER_REFRESH_FAILED_STATUS_MSG = 'Failed to refresh.';

const String NO_SEARCH_RESULT_MSG = 'No result found.';

const int PAGE_SIZE = 10;

const int DIO_CACHE_DURATION_IN_DAYS = 7;

const String CONNECTION_ERROR_MSG = 'Error! Check your connection.';

const List<String> TENDER_SEARCH_STATUS = ['open', 'closed'];

const String EMAIL_LOGIN_METHOD = 'email';
const String MOBILE_LOGIN_METHOD = 'mobile';

const String ADVERTISEMENT_TYPE_CARD = 'card';
const String ADVERTISEMENT_TYPE_BANNER = 'banner';

const String AD_IMPRESSION_TYPE_VIEW = 'view';
const String AD_IMPRESSION_TYPE_CLICK = 'click';
