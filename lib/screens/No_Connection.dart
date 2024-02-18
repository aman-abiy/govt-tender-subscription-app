import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../services/connectivity.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({ Key key }) : super(key: key);

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Connection Error',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600, color:Colors.grey.shade800),
            ),
            const SizedBox(height: 30.0),
            Icon(Icons.network_check_sharp, size: 50, color: Colors.grey.shade600),
            const SizedBox(height: 20.0),
            const Text('Please check your connection and try again!',
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
              onPressed: () async {
                bool status = await ConnectivityService().checkConnectivity();
                if(status) {
                  Navigator.of(context).pushNamed(Routes.ALL_TENDERS);
                } else {
                  Fluttertoast.showToast(
                    msg: CONNECTION_ERROR_MSG,
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_LONG
                  );
                }
              }
            )
          ],
        ),
      )
    );
  }
}