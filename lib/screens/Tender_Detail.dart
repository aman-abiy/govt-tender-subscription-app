import 'package:alpha_tenders_mobile_app/dtos/Bookmark_Check_Response.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/providers/advertisement.dart';
import 'package:alpha_tenders_mobile_app/providers/tender.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/advertisement_picker.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:alpha_tenders_mobile_app/widgets/advertisement_banner.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_circular_loader.dart';
import 'package:alpha_tenders_mobile_app/widgets/details_modal.dart';
import 'package:alpha_tenders_mobile_app/widgets/tender_html_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class TenderDetail extends StatefulWidget {
  final Tender tender;
  
  const TenderDetail({this.tender});

  @override
  State<TenderDetail> createState() => _TenderDetailState();
}

class _TenderDetailState extends State<TenderDetail> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      TenderProvider().checkIfSavedTender(widget.tender);
    });
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    TenderProvider().viewTender(widget.tender);
    return Consumer2<TenderProvider, AdvertisementProvider>(
      builder: (context, tenderProvider, advertisementProvider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#1c2e59'),
            actions: [
              Builder(builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: tenderProvider.isTenderSavedCheckLoading ? const TextButton(
                  onPressed: null,
                  child: Text('Save',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    )),
                ) : TextButton(
                  child: tenderProvider.isTenderSaved ? Text('Saved',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.green.shade600
                    )) : const Text('Save',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white
                  )),
                  onPressed: () async {
                    await TenderProvider().bookmarkTender(widget.tender);
                    BookmarkCheckResponse bookmarkCheckResponse = await TenderProvider().checkIfSavedTender(widget.tender);
                    String msg = '';
                    if(bookmarkCheckResponse.status) {
                      if(bookmarkCheckResponse.isSaved) {
                        msg = "Tender has been saved.";
                      } else {
                        msg = "Tender has been removed from saved tenders.";
                      }
                    } else {
                      msg = "Error! Please try again.";
                    }
                    Fluttertoast.showToast(
                      msg: msg,
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_LONG,
                      backgroundColor: HexColor('#333333')
                    );
                    // changeSavedState();
                  }
                ),
              ),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextButton(
                  child: const Text('Details',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                    )
                  ),
                  onPressed: () {
                    DetailsModal detailsModal = DetailsModal(widget.tender);
                    detailsModal.showDetailsModal(context);
                  }
                ),
              ),
            ],
          ),
          body: AdvertisementPicker().hasBannerAdvertisement(advertisementProvider.advertisements) ? Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - (MediaQuery.of(context).size.height * 0.1),
                child: TenderHtmlView(widget.tender)
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AdvertisementBanner(AdvertisementPicker().randomAdvertisementBannerSelector(advertisementProvider.advertisements))
              )
            ],
          ) : TenderHtmlView(widget.tender)
        );
      }
    );
  }

  void changeSavedState() {
    // since object isSaved has been changed in provider, just use setState() to update UI
    setState(() {
      widget.tender.isSaved = widget.tender.isSaved;
    });
  }
}