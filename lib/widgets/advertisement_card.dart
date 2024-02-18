import 'package:alpha_tenders_mobile_app/models/Advertisement.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/intent_handler.dart';
import 'package:alpha_tenders_mobile_app/utils/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdvertisementCard extends StatefulWidget {
  final Advertisement advertisement;
  
  const AdvertisementCard(this.advertisement, {Key key}) : super(key: key);

  @override
  State<AdvertisementCard> createState() => _AdvertisementCardState();
}

class _AdvertisementCardState extends State<AdvertisementCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(color: HexColor('#e6e4e1'))
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Text(widget.advertisement.bannerTitle,
                              style: TextStyle(
                                color: HexColor('#${widget.advertisement.themeColorHex ?? '212529'}'),
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(widget.advertisement.bannerDescription,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.advertisement.company.phone1 != null ? InkWell(
                              onTap: () => IntentHandler.launchPhoneNumber(widget.advertisement.company?.phone1?.formatNational),
                              child: Text(widget.advertisement.company?.phone1?.formatNational,
                                style: TextStyle(
                                fontSize: 15,
                                  color: HexColor('#007bff')
                                ),
                              ),
                            ) : const SizedBox.shrink(),
                             widget.advertisement.company.phone2 != null ? InkWell(
                              onTap: () => IntentHandler.launchPhoneNumber(widget.advertisement.company?.phone2?.formatNational),
                              child: Text(widget.advertisement.company?.phone2?.formatNational,
                                style: TextStyle(
                                fontSize: 15,
                                  color: HexColor('#007bff')
                                ),
                              ),
                            ) : const SizedBox.shrink(),
                             widget.advertisement.company.phone3 != null ? InkWell(
                              onTap: () => IntentHandler.launchPhoneNumber(widget.advertisement.company?.phone3?.formatNational),
                              child: Text(widget.advertisement.company?.phone3?.formatNational,
                                style: TextStyle(
                                fontSize: 15,
                                  color: HexColor('#007bff')
                                ),
                              ),
                            ) : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      const Divider(),
                      CachedNetworkImage(
                        imageUrl: '${URLs.ADVERTISEMENT_BANNER_IMG_URL}/${widget.advertisement.bannerImage}',
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ],
                  ),
                ),
             ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: const Text('Ad', style: TextStyle(color: Colors.white),),
                decoration: BoxDecoration(
                  color: Colors.amber.shade600
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}