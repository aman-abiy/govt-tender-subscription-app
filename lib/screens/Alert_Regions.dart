import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/region.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/widgets/button_loading_indicator.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AlertRegionsPage extends StatefulWidget {
  const AlertRegionsPage({Key key}) : super(key: key);

  @override
  State<AlertRegionsPage> createState() => _AlertRegionsPageState();
}

class _AlertRegionsPageState extends State<AlertRegionsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(RegionProvider().regions.isEmpty) RegionProvider().getRegions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegionProvider>(
      builder: (context, regionProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#1c2e59'),
            title: const Text(ALERT_REGIONS_PAGE_TITLE), 
          ),
          body: (regionProvider.isLoading && regionProvider.regions.isEmpty) ? 
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: const Loading()
            ) : SingleChildScrollView(
              child: Column(
                children: [
                  buildRegionSelection(regionProvider.regions),
                  Container(height: 50.0)
                ],
              ),
            ),
          bottomSheet: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                    child: regionProvider.isLoading ? const ButtonLoadingIndicator() : Text('Save',
                      style: TextStyle(color: HexColor('#eef0f1')),
                    ),
                    style: buttonStyle('#1a79de', borderRadius: 5.0),
                    onPressed: () async {
                      bool status = await regionProvider.updateAlertRegions();
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
                    }
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget buildRegionSelection(List<Region> regions) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child) {
        return ListView.builder(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          itemCount: regions.length,
          itemBuilder: (context, index) {
            return checkboxTile(regions[index], accountProvider);
          }
        );
      }
    );
  }

  Widget checkboxTile(Region region, AccountProvider accountProvider) {
    bool _isSelected = accountProvider.alertRegions.contains(region.id);
    return CheckboxListTile(
      contentPadding: const EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 12),
      title: Text(
        region.name.en,
        style: TextStyle(
          color: _isSelected ? Colors.blue : Colors.grey.shade700,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: _isSelected,
      onChanged: (bool isSelected) {
        if(isSelected) {
          accountProvider.addAlertRegion(region.id);
        } else {
          accountProvider.removeAlertRegion(region.id);
        }
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}