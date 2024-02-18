import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/providers/advertisement.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/widgets/advertisement_card.dart';
import 'package:alpha_tenders_mobile_app/widgets/appbar.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_refresher.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:alpha_tenders_mobile_app/widgets/end_of_list.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:alpha_tenders_mobile_app/widgets/page_title.dart';
import 'package:alpha_tenders_mobile_app/widgets/tender_card.dart';
import 'package:alpha_tenders_mobile_app/widgets/no_result.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AllTendersPage extends StatefulWidget {
  const AllTendersPage({ Key key }) : super(key: key);

  @override
  State<AllTendersPage> createState() => _AllTendersPageState();
}

class _AllTendersPageState extends State<AllTendersPage> with AutomaticKeepAliveClientMixin<AllTendersPage> {
      
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      TenderProvider().getAllTenders();
      AdvertisementProvider().getAdvertisements();
    });
    super.initState();
  }

  _onRefresh() async {
    await AdvertisementProvider().getAdvertisements();
    return await TenderProvider().getAllTenders(refresh: true);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: customTenderAppBars(context, refreshFunction: _onRefresh),
      drawer: const CustomDrawer(),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Consumer2<TenderProvider, AdvertisementProvider>(
          builder: (context, tenderProvider, advertisementProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                const PageTitle(ALL_TENDERS_PAGE_TITLE),
                const ErrorMessage(),
                Divider(
                  color: HexColor('#e6e4e1'),
                  thickness: 2.0,
                  height: 20.0,
                ),
                (tenderProvider.allTendersIsLoading && tenderProvider.allTenders.isEmpty) ? const Loading() : const SizedBox.shrink(),
                tenderProvider.allTenders.isNotEmpty ? Expanded(child: buildTenders(tenderProvider, advertisementProvider)) : const NoResult()
              ],
            );
          }
        )
      ),
    );
  }

  Widget buildTenders(TenderProvider tenderProvider, AdvertisementProvider advertisementProvider) {
    return CustomScroller(
      onRefresh: _onRefresh,
      onLoading: tenderProvider.getAllTenders,
      pagination: tenderProvider.allTendersMeta?.pagination,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: tenderProvider.allTenders.length,
        itemBuilder: (BuildContext context, int index) {
          if(index % 5 == 0 && index > 0) {
            if(advertisementProvider.advertisements.length >= ((index / 5).round())){
              if(advertisementProvider.advertisements[(index / 5).round() - 1].type == ADVERTISEMENT_TYPE_CARD) {
                return Column(
                  children: [
                    AdvertisementCard(advertisementProvider.advertisements[(index / 5).round() - 1]),
                    TenderCard(tenderProvider.allTenders[index])
                  ],
                );
              }
            }
          }
          return TenderCard(tenderProvider.allTenders[index]);
        }
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}