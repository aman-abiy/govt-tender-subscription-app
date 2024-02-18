import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/widgets/appbar.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_refresher.dart';
import 'package:alpha_tenders_mobile_app/widgets/drawer.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:alpha_tenders_mobile_app/widgets/no_result.dart';
import 'package:alpha_tenders_mobile_app/widgets/page_title.dart';
import 'package:alpha_tenders_mobile_app/widgets/tender_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedTendersPage extends StatefulWidget {
  const SavedTendersPage({ Key key }) : super(key: key);

  @override
  State<SavedTendersPage> createState() => _SavedTendersPageState();
}

class _SavedTendersPageState extends State<SavedTendersPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TenderProvider().getSavedTenders();
    });
    super.initState();
  }

  _onRefresh() async {
    return await TenderProvider().getSavedTenders(refresh: true);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customTenderAppBars(context, refreshFunction: _onRefresh),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Consumer<TenderProvider>(builder: (context, tenderProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              const PageTitle(SAVED_TENDERS_PAGE_TITLE),
              const ErrorMessage(),
              Divider(
                color: HexColor('#e6e4e1'),
                thickness: 2.0,
                height: 20.0,
              ),
              (tenderProvider.savedTendersIsLoading && tenderProvider.savedTenders.isEmpty) ? const Loading() : const SizedBox.shrink(),
              tenderProvider.savedTenders.isNotEmpty ? Expanded(child: buildTenders(tenderProvider)) : const NoResult()
            ],
          );
        } ,)
      ),
    );
  }

  Widget buildTenders(TenderProvider tenderProvider) {
    return CustomScroller(
      onRefresh: _onRefresh,
      onLoading: tenderProvider.getSavedTenders,
      pagination: tenderProvider.savedTendersMeta?.pagination,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: tenderProvider.savedTenders.length,
        itemBuilder: (BuildContext context, int index) {
          return TenderCard(tenderProvider.savedTenders[index]);
        }
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}