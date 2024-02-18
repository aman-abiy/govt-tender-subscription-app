import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/error.dart';
import 'package:alpha_tenders_mobile_app/screens/Account.dart';
import 'package:alpha_tenders_mobile_app/screens/Alert_Categories.dart';
import 'package:alpha_tenders_mobile_app/screens/Alert_Email.dart';
import 'package:alpha_tenders_mobile_app/screens/Alert_Emails.dart';
import 'package:alpha_tenders_mobile_app/screens/Alert_Regions.dart';
import 'package:alpha_tenders_mobile_app/screens/All_Tenders.dart';
import 'package:alpha_tenders_mobile_app/screens/Change_Email.dart';
import 'package:alpha_tenders_mobile_app/screens/Change_Password.dart';
import 'package:alpha_tenders_mobile_app/screens/Contact_Us.dart';
import 'package:alpha_tenders_mobile_app/screens/Forgot_Password.dart';
import 'package:alpha_tenders_mobile_app/screens/Free_Tenders.dart';
import 'package:alpha_tenders_mobile_app/screens/Email_Login.dart';
import 'package:alpha_tenders_mobile_app/screens/Mobile_Login.dart';
import 'package:alpha_tenders_mobile_app/screens/My_Tenders.dart';
import 'package:alpha_tenders_mobile_app/screens/No_Connection.dart';
import 'package:alpha_tenders_mobile_app/screens/Packages.dart';
import 'package:alpha_tenders_mobile_app/screens/Register.dart';
import 'package:alpha_tenders_mobile_app/screens/Route_Error.dart';
import 'package:alpha_tenders_mobile_app/screens/Saved_Tenders.dart';
import 'package:alpha_tenders_mobile_app/screens/Search.dart';
import 'package:alpha_tenders_mobile_app/screens/Searched_Tenders.dart';
import 'package:alpha_tenders_mobile_app/screens/Settings.dart';
import 'package:alpha_tenders_mobile_app/screens/Subscription_And_Billing.dart';
import 'package:alpha_tenders_mobile_app/screens/Tender_Detail.dart';
import 'package:alpha_tenders_mobile_app/screens/User_Profile.dart';
import 'package:alpha_tenders_mobile_app/services/connectivity.dart';
import 'package:alpha_tenders_mobile_app/services/firebase.dart';
import 'package:alpha_tenders_mobile_app/utils/loader_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    LoaderHandler.clearLoaders();

    // ConnectivityService().checkConnectivity();
    // if(!ConnectivityService().hasConnection) {
    //   return MaterialPageRoute(builder: (_) => const NoConnectionScreen());
    // }
    
    // ErrorProvider().setError(null)
    if(AccountProvider().isLoggedIn()) {
      AccountProvider().getAccount();
    }

    final args = settings.arguments;

    FirebaseService().logPageViewEvent(pageName: settings.name);
    
    switch (settings.name) {

      case Routes.ALL_TENDERS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const AllTendersPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.MY_TENDERS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const MyTendersPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.FREE_TENDERS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const FreeTendersPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.SAVED_TENDERS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const SavedTendersPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.SEARCHED_TENDERS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const SearchedTendersPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.TENDER_DETAIL:
        if(AccountProvider().isLoggedIn()){
          if(AccountProvider().hasActiveSubscription) {
            return MaterialPageRoute(builder: (_) => TenderDetail(tender: args));
          } else {
            return MaterialPageRoute(builder: (_) => const SubscriptionAndBillingPage());
          }
        }
        return MaterialPageRoute(builder: (_) => const EmailLoginPage());

      case Routes.SEARCH:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const SearchPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());

      case Routes.EMAIL_LOGIN:
        return !AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const EmailLoginPage())
            : MaterialPageRoute(builder: (_) => const AllTendersPage());
      case Routes.MOBLIE_LOGIN:
        return !AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const MobileLoginPage())
            : MaterialPageRoute(builder: (_) => const AllTendersPage());
      case Routes.REGISTER:
        return !AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const RegistrationScreen())
            : MaterialPageRoute(builder: (_) => const AllTendersPage());
      case Routes.FORGOT_PASSWORD:
        return !AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())
            : MaterialPageRoute(builder: (_) => const AllTendersPage());

      case Routes.ALERT_EMAILS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const AlertEmailsPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.ALERT_EMAIL:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => AlertEmailPage(alertEmail: args))
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
            
        case Routes.ACCOUNT:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const AccountPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.USER_PROFILE:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const UserProfilePage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.SUBSCRIPTION_AND_BILLING:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const SubscriptionAndBillingPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.SUBSCRIPTION_PACKAGES:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => SubscriptionPackagesPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.CHANGE_EMAIL:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const ChangeEmailPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.CHANGE_PASSWORD:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const ChangePasswordPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());

      case Routes.SETTINGS:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const SettingsScreenPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.ALERT_CATEGORY:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const AlertCategoriesPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());
      case Routes.ALERT_REGION:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const AlertRegionsPage())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());

      case Routes.CONTACT_US:
        return AccountProvider().isLoggedIn()
            ? MaterialPageRoute(builder: (_) => const ContactUsScreen())
            : MaterialPageRoute(builder: (_) => const EmailLoginPage());


      case Routes.ERROR:
        return MaterialPageRoute(builder: (_) => const RouteErrorPage());

      default:
        return MaterialPageRoute(builder: (_) => const RouteErrorPage());
     }
   }
}