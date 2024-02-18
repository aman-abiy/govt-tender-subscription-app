import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget customTenderAppBars(BuildContext context, {Function refreshFunction}) {
  return AppBar(
    backgroundColor: HexColor('#1c2e59'),
    // leading: IconButton(
    //   icon: const Icon(Ionicons.search),
    //   onPressed: () {}
    // ),
    // title: Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     // const SizedBox(width: 20.0),
    //     SizedBox(
    //       height: 25.0,
    //       child: Image.asset('assets/images/logo-light-small.png')
    //     ),
    //     const SizedBox(width: 15.0),
    //     Text('Alpha Tenders',
    //       style: TextStyle(color: HexColor('#cedbf6')),
    //     )
    //   ],
    // ),
    centerTitle: true,
    actions: [
      refreshFunction != null ? Consumer<TenderProvider>(
        builder: (context, tenderProvider, child) {
          return tenderProvider.isRefreshing ? const Center(child: CustomCircularLoader(color: Colors.white, dimensions: 18.0, strokeWidth: 3.0)) : IconButton(
            icon: const Icon(Ionicons.reload),
            onPressed: (tenderProvider.isLoading || 
                        tenderProvider.allTendersIsLoading ||
                        tenderProvider.myTendersIsLoading ||
                        tenderProvider.freeTendersIsLoading ||
                        tenderProvider.savedTendersIsLoading) || tenderProvider.isRefreshing ? () {} : () async {
              var response = await refreshFunction();
              print('responseresponse $response');
              if(response != null) {
                Fluttertoast.showToast(
                  msg: TENDER_REFRESH_UP_TO_DATE_STATUS_MSG,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG
                );
              } else {
                Fluttertoast.showToast(
                  msg: TENDER_REFRESH_FAILED_STATUS_MSG,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG
                );
              }
              
            }
          );
        }
      ) : const SizedBox.shrink(),
      IconButton(
        icon: const Icon(Ionicons.search),
        onPressed: () async {
          Navigator.of(context).pushNamed(Routes.SEARCH);
        }
      ),
    ],
  );
}

PreferredSizeWidget searchedTendersAppBar(BuildContext context, {Function onPagePopFunction, int resultCount}) {
  return AppBar(
    backgroundColor: HexColor('#eff2f4'),
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: HexColor('#1c2e59')),
      onPressed: () {
        onPagePopFunction();
        Navigator.of(context).pop();
      },
    ),
    title: Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: 'Search results ',
            style: TextStyle(color: HexColor('#1c2e59')),
          ),
          TextSpan(
            text: resultCount != null ? '($resultCount)' : '',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ]
      )
    ),
    elevation: 0.0,
  );
}

