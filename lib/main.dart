import 'dart:io';
import 'package:alpha_tenders_mobile_app/models/Device_Info.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/advertisement.dart';
import 'package:alpha_tenders_mobile_app/providers/alert_emails.dart';
import 'package:alpha_tenders_mobile_app/providers/category.dart';
import 'package:alpha_tenders_mobile_app/providers/company_info.dart';
import 'package:alpha_tenders_mobile_app/providers/error.dart';
import 'package:alpha_tenders_mobile_app/providers/language.dart';
import 'package:alpha_tenders_mobile_app/providers/region.dart';
import 'package:alpha_tenders_mobile_app/providers/search.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/providers/tender_source.dart';
import 'package:alpha_tenders_mobile_app/router/router.dart';
import 'package:alpha_tenders_mobile_app/services/cache_manager.dart';
import 'package:alpha_tenders_mobile_app/services/connectivity.dart';
import 'package:alpha_tenders_mobile_app/services/device.dart';
import 'package:alpha_tenders_mobile_app/services/firebase.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/async_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/http_override.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sharedPreferences;
DeviceInfo deviceInfo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// check on devices with android version below 7 without 
  /// this line and if it works permanently remove this line
  HttpOverrides.global = MyHttpOverrides();
  await FirebaseService().init();

  await _initApp();

  runApp(MainApp(Routes.ALL_TENDERS));

}

Future _initApp() => asyncHandler(() async {
  // prevent screen rotation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  sharedPreferences = await SharedPreferences.getInstance();
  AccountProvider().setSessionToken();


  if(AccountProvider().isLoggedIn()) {
    AccountProvider().setAccount();
    AccountProvider().updateFCMToken(FirebaseService().token);
    print('fcmTOken ${FirebaseService().token}');
  }
  
  await DeviceService().getBuildInfo();
  deviceInfo = await DeviceService().getDeviceInfo();
  // CompanyInfoProvider().getCompanyInfo();
});

class MainApp extends StatelessWidget {
  final String initialRoute;

  MainApp(this.initialRoute);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => TenderProvider()),
        ChangeNotifierProvider(create: (_) => AlertEmailsProvider()),
        ChangeNotifierProvider(create: (_) => ErrorProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => RegionProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => TenderSourceProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => CompanyInfoProvider()),
        ChangeNotifierProvider(create: (_) => AdvertisementProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityService()),
        ChangeNotifierProvider(create: (_) => FirebaseService()),
        ChangeNotifierProvider(create: (_) => DeviceService()),
        ChangeNotifierProvider(create: (_) => CacheManagerService())
      ],
      child: BridgeWidget(initialRoute)
    );
  }
}

class BridgeWidget extends StatefulWidget {
  final String initialRoute;

  BridgeWidget(this.initialRoute);

  @override
  State<BridgeWidget> createState() => _BridgeWidgetState();
}

class _BridgeWidgetState extends State<BridgeWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alpha Tenders',
      initialRoute: widget.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorObservers: [
        FirebaseService.observer
      ],
      builder: EasyLoading.init(),
      theme: ThemeData(primaryColor: HexColor('#1c2e59'), backgroundColor: HexColor('#eff2f4')),
    );
  }
}