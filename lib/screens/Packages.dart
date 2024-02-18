import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionPackagesPage extends StatelessWidget {
  const SubscriptionPackagesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(SUBSCRIPTION_PACKAGES_PAGE_TITLE),        
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: const WebView(
          initialUrl: SUBSCRIPTION_PACKAGES_PAGE_LINK,
          javascriptMode: JavascriptMode.unrestricted
        ),
      ),
    );
  }
}