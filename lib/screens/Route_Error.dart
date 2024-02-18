import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RouteErrorPage extends StatefulWidget {
  const RouteErrorPage({ Key key }) : super(key: key);

  @override
  State<RouteErrorPage> createState() => _RouteErrorPageState();
}

class _RouteErrorPageState extends State<RouteErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Something Went wrong.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color:Colors.grey.shade800),
            ),
            const SizedBox(height: 30.0),
            Icon(Icons.error, size: 50, color: Colors.grey.shade600),
            const SizedBox(height: 20.0),
            const Text('Click the \'Go Back\' button below to return!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),              
            ),
            const SizedBox(height: 20.0),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chevron_left),
                  const SizedBox(width: 10.0),
                  Text('Go back',
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade200),
                  ),
                ],
              ),
              style: buttonStyle('#004085', borderRadius: 5.0),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.ALL_TENDERS);
              }
            )
          ],
        ),
      )
    );
  }
}