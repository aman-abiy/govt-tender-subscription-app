import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/providers/account.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/appbar.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_refresher.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:alpha_tenders_mobile_app/widgets/end_of_list.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:alpha_tenders_mobile_app/widgets/no_result.dart';
import 'package:alpha_tenders_mobile_app/widgets/page_title.dart';
import 'package:alpha_tenders_mobile_app/widgets/tender_card.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MyTendersPage extends StatefulWidget {
  const MyTendersPage({ Key key }) : super(key: key);

  @override
  State<MyTendersPage> createState() => _MyTendersPageState();
}

class _MyTendersPageState extends State<MyTendersPage> with AutomaticKeepAliveClientMixin<MyTendersPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      TenderProvider().getMyTenders();
    });
    super.initState();
  }

  _onRefresh() async {
    return await TenderProvider().getMyTenders(refresh: true);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer2<TenderProvider, AccountProvider>(
      builder: (context, tenderProvider, accountProvider, child) {
        return Scaffold(
          appBar: customTenderAppBars(context, refreshFunction: (accountProvider.account.alertCategories.isEmpty && accountProvider.account.alertRegions.isEmpty) ? null : _onRefresh),
          drawer: const CustomDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                const PageTitle(MY_TENDERS_PAGE_TITLE),
                const ErrorMessage(),
                Divider(
                  color: HexColor('#e6e4e1'),
                  thickness: 2.0,
                  height: 20.0,
                ),
                (tenderProvider.myTendersIsLoading && tenderProvider.myTenders.isEmpty) ? const Loading() : const SizedBox.shrink(),
                (accountProvider.account.alertCategories.isEmpty && accountProvider.account.alertRegions.isEmpty) ? noAlertCategoryAndRegionSelection() : tenderProvider.myTenders.isNotEmpty ? Expanded(child: buildTenders(tenderProvider)) : const NoResult()
              ],
            ),
          )
        );
      }
    );
  }

  Widget buildTenders(TenderProvider tenderProvider) {
    return CustomScroller(
      onRefresh: _onRefresh,
      onLoading: tenderProvider.getMyTenders,
      pagination: tenderProvider.myTendersMeta?.pagination,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: tenderProvider.myTenders.length,
        itemBuilder: (BuildContext context, int index) {
          return TenderCard(tenderProvider.myTenders[index]);
        }
      )
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget noAlertCategoryAndRegionSelection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              color: HexColor('#cce5ff'),
              border: Border.all(color: HexColor('#b8daff'))
            ),
            child: Text('To receive filtered tenders daily, select category and region preference in settings page.',
              style: TextStyle(fontSize: 15, color: HexColor('#004085')),
            ), 
          ),
          const SizedBox(height: 20.0),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(Routes.SETTINGS),
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  const TextSpan(
                    text: 'Click here to go to ',
                    style: TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                  TextSpan(
                    text: ' Settings ',
                    style: TextStyle(fontSize: 15, color: HexColor('#004085'), fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: 'page',
                    style: TextStyle(fontSize: 15, color: Colors.black45),
                  ),
                ]
              )
            ),
          )
        ],
      ),
    );
  }
}