import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/services/device.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/route_checker.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/simple_simmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(AccountProvider().account == null) {
      AccountProvider().getAccount();
    }
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  drawerHeader(),
                  drawerList(context),
                ],
              ),
            ),
            deviceInfo()

          ],
        )
      ),
    );
  }

  Widget drawerHeader() {
    return Consumer<AccountProvider>(builder: (context, accountProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            color: HexColor('#1c2e59'),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // const SizedBox(width: 20.0),
                SizedBox(
                  height: 25.0,
                  child: Image.asset('assets/images/logo-light-small.png')
                ),
                const SizedBox(width: 15.0),
                Flexible(
                  child: Text('Alpha Tenders',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: HexColor('#cedbf6'), fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          accountProvider.isLoading ? const SimpleShimmerLoading() : ListTile(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            // tileColor: RouteChecker.checkIfCurrentRoute(routeName) ? HexColor('#f0f4fc') : null,
            title: Text(accountProvider.account?.email ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade800
              ),
            ),
            subtitle: Text(accountProvider.account?.mobile?.formatInternational ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade800
              ),
            ),
          )
        ],
      );
    });
  }

  Widget drawerList(BuildContext context) {
    return Column(
      children: [
        tiles(context, ALL_TENDERS_PAGE_TITLE, (Icons.my_library_books), Routes.ALL_TENDERS),
        tiles(context, MY_TENDERS_PAGE_TITLE, (Icons.account_tree_rounded), Routes.MY_TENDERS),
        tiles(context, FREE_TENDERS_PAGE_TITLE, (Icons.check_circle), Routes.FREE_TENDERS),
        tiles(context, SAVED_TENDERS_PAGE_TITLE, (Icons.bookmark_added), Routes.SAVED_TENDERS),
        tiles(context, ALERT_EMAILS_PAGE_TITLE, (Icons.email_outlined), Routes.ALERT_EMAILS),
        tiles(context, ACCOUNT_PAGE_TITLE, (Icons.account_box), Routes.ACCOUNT),
        tiles(context, SETTINGS_PAGE_TITLE, (Icons.settings), Routes.SETTINGS),
        tiles(context, CONTACT_US_PAGE_TITLE, (Icons.call), Routes.CONTACT_US),
      ],
    );
  }

  Widget tiles(BuildContext context, String tileTitle, IconData leadingIcon, String routeName) {
    print('RouteChecker.checkIfCurrentRoute(routeName) ${RouteChecker.checkIfCurrentRoute(routeName)} ${routeName}');
    return ListTile(
      leading: Icon(leadingIcon),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      // tileColor: RouteChecker.checkIfCurrentRoute(routeName) ? HexColor('#f0f4fc') : null,
      title: Text(tileTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(routeName);
      },
    );
  }

  Widget deviceInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Text('Version: ${DeviceService().version}+${DeviceService().buildNumber}',
        style: TextStyle(color: DEBUG_MODE ? Colors.red.shade600 : Colors.grey, fontWeight: FontWeight.w600),
      ),
    );
  }
}