import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TenderHtmlView extends StatefulWidget {
  final Tender tender;

  TenderHtmlView(this.tender);

  @override
  State<TenderHtmlView> createState() => _TenderHtmlViewState();
}

class _TenderHtmlViewState extends State<TenderHtmlView> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  String url;
  
  @override
  void initState() {
    // TODO: implement initState
     String html = '''
        <head>
          <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
          <meta name="viewport" content="width=device-width, initial-scale=1" />
          <title>2merkato Tenders</title>
        </head>
        <html>
          <body>${widget.tender.description}</body>
        </html>
    ''';

    url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return url == null
      ? const Center(child: Text("Something went wrong. Please try again.")) :
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 10000),
        child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController wc) => _controller.complete(wc),
          gestureNavigationEnabled: true,
        ),
    );
  }
}