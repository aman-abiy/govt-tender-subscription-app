import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_circular_loader.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class SettingsScreenPage extends StatefulWidget {
  const SettingsScreenPage({Key key}) : super(key: key);

  @override
  State<SettingsScreenPage> createState() => _SettingsScreenPageState();
}

class _SettingsScreenPageState extends State<SettingsScreenPage> {

  bool _alertStatusToggleState = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1c2e59'),
        title: const Text(SETTINGS_PAGE_TITLE), 
      ),
      drawer: const CustomDrawer(),
      body: Consumer<AccountProvider>(
        builder: (context, accountProvider, child) {
          _alertStatusToggleState = accountProvider.alertStatus;
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.swipe_vertical_sharp),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
                title: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text('Alert Status',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.grey.shade800)
                  ),
                ),  
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    accountProvider.isLoading ? const CustomCircularLoader() : CustomSwitch(  
                      value: _alertStatusToggleState,  
                      activeColor: HexColor('#249a63'),
                      onChanged: (value) async { 
                        print('value $value') ;
                        bool status = await accountProvider.updateAlertStatus(value);
                        if(status) {
                        Fluttertoast.showToast(
                          msg: ALERT_SETTINGS_UPDATED_STATUS_MSG,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: ALERT_SETTINGS_UPDATE_FAILED_STATUS_MSG,
                          gravity: ToastGravity.BOTTOM,
                          toastLength: Toast.LENGTH_LONG
                        );
                      } 
                      },  
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(vertical: 5.0),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                        color: HexColor('#cce5ff'),
                        border: Border.all(color: HexColor('#b8daff'))
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Set alert status',
                              style: TextStyle(fontSize: 14, color: HexColor('#004085')),
                            ),
                            TextSpan(
                              text: ' ON ',
                              style: TextStyle(fontSize: 14, color: HexColor('#004085'), fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'if you want to receive selected tenders through your email based on the preferences (category and region) you select below.',
                              style: TextStyle(fontSize: 14, color: HexColor('#004085')),
                            ),
                          ]
                        )
                      ), 
                    ),
                  ],
                ), 
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(Routes.ALERT_CATEGORY),
                child: ListTile(
                  leading: const Icon(Icons.category_outlined),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  title: Text('Alert Categories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800)
                  ),  
                  subtitle: Text('${accountProvider.alertCategories.length} categories selected'), 
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(Routes.ALERT_REGION),
                child: ListTile(
                  leading: const Icon(Ionicons.globe),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  title: Text('Alert Regions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade800)
                  ),  
                  subtitle: Text('${accountProvider.alertRegions.length} region(s) selected'), 
                ),
              )
            ],
          );
        }
      ),
    );
  }
}