import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({ Key key }) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(ACCOUNT_PAGE_TITLE),        
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          tiles(USER_PROFILE_PAGE_TITLE, (Icons.account_box), () => { Navigator.of(context).pushNamed(Routes.USER_PROFILE) }),
          tiles(SUBSCRIPTION_AND_BILLING_PAGE_TITLE, (Icons.monetization_on), () => { Navigator.of(context).pushNamed(Routes.SUBSCRIPTION_AND_BILLING) }),
          tiles('Logout', (Icons.logout_outlined), executeLogout),
        ],
      ),
    );
  }

   Widget tiles( String tileTitle, IconData leadingIcon, Function onTapAction) {
    return ListTile(
      leading: Icon(leadingIcon),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      title: Text(tileTitle,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800
        ),
      ),
      onTap: onTapAction
    );
  }

  void executeLogout() async {
    bool status = await AccountProvider().logout();
    if(status) {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.EMAIL_LOGIN, (Route<dynamic> route) => false);
    } else {
      Fluttertoast.showToast(
        msg: LOGOUT_UNSUCCESSFUL_STATUS_MSG,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG
      );
    }
  }
}