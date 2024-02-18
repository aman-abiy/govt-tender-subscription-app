import 'package:alpha_tenders_mobile_app/dtos/Ad_Impression.dart';
import 'package:alpha_tenders_mobile_app/models/Advertisement.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/utils/consts.dart';
import 'package:alpha_tenders_mobile_app/utils/intent_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../providers/ad_impression.dart';

class AdvertisementBanner extends StatefulWidget {
  final Advertisement advertisement;
  
  const AdvertisementBanner(this.advertisement, {Key key}) : super(key: key);

  @override
  State<AdvertisementBanner> createState() => _AdvertisementBannerState();
}

class _AdvertisementBannerState extends State<AdvertisementBanner> {
  AdImpression adImpression;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      logImpression(AD_IMPRESSION_TYPE_VIEW);
    });
  }

    Future logImpression(String type) {
    adImpression = AdImpression.fromJson({
      'type': type,
      'advertisement': widget.advertisement.id
    });
    AdImpressionProvider().logAdImpression(adImpression);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        logImpression(AD_IMPRESSION_TYPE_CLICK);
        IntentHandler.launchPhoneNumber(widget.advertisement.company?.phone1?.formatNational); 
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: HexColor('#eff2f4'),
          // border: Border.all(color: Colors.grey.shade200)
        ),
        child: CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          fit: BoxFit.fill,
          imageUrl: widget.advertisement.bannerImage,
          placeholder: (context, url) => const Center(
              child: Text('Advertisement',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      )
    );
        
  }
}