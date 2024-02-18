import 'package:alpha_tenders_mobile_app/providers/search.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/widgets/appbar.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_refresher.dart';
import 'package:alpha_tenders_mobile_app/widgets/error.dart';
import 'package:alpha_tenders_mobile_app/widgets/loading.dart';
import 'package:alpha_tenders_mobile_app/widgets/tender_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedTendersPage extends StatefulWidget {
  const SearchedTendersPage({Key key}) : super(key: key);

  @override
  State<SearchedTendersPage> createState() => _SearchedTendersPageState();
}

class _SearchedTendersPageState extends State<SearchedTendersPage> {

  _onRefresh() async {
    await SearchProvider().searchTenders(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SearchProvider().tenders.clear();
        SearchProvider().searchedTendersMeta = null;
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) {
          return Scaffold(
            appBar: searchedTendersAppBar(context, resultCount: searchProvider.searchedTendersMeta?.total, onPagePopFunction: () => {
              SearchProvider().tenders.clear(),
              SearchProvider().searchedTendersMeta = null
            }),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10.0),
                  const ErrorMessage(),
                  (searchProvider.isLoading && searchProvider.tenders.isEmpty) ? const Loading() : const SizedBox.shrink(),
                  (!searchProvider.isLoading && searchProvider.tenders.isEmpty) ? noSearchResult() : Expanded(child: buildTenders(searchProvider))
                ],
              )
            ),
          );
        }
      ),
    );
  }

  Widget buildTenders(SearchProvider searchProvider) {
    return CustomScroller(
      onRefresh: _onRefresh,
      onLoading: searchProvider.searchTenders,
      pagination: searchProvider.searchedTendersMeta?.pagination,
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: searchProvider.tenders.length,
        itemBuilder: (BuildContext context, int index) {
          return TenderCard(searchProvider.tenders[index]);
        }
      )
    );
  }

  Widget noSearchResult() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            NO_SEARCH_RESULT_MSG,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.grey
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chevron_left),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text('Go back',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(fontSize: 15, color: HexColor('#004085')),
                    ),
                  ),
                ],
              ),
              style: buttonStyle('#eff2f4', borderRadius: 5.0),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
          )
        ],
      ),
    );
  }

}