import 'package:alpha_tenders_mobile_app/models/Advertisement.dart';

import 'dart:math';

import 'package:alpha_tenders_mobile_app/utils/consts.dart';

class AdvertisementPicker {

  Advertisement randomAdvertisementBannerSelector(List<Advertisement> advertisements) {
    List<Advertisement> bannerAdvertisements = advertisements.where((Advertisement advertisement) => advertisement.type == ADVERTISEMENT_TYPE_BANNER).toList();

    Random random = Random();
    int randomNumber = random.nextInt(bannerAdvertisements.length);

    return bannerAdvertisements[randomNumber];
  }

  bool hasBannerAdvertisement(List<Advertisement> advertisements) {
    return advertisements.where((Advertisement advertisement) => advertisement.type == ADVERTISEMENT_TYPE_BANNER).isNotEmpty;
  }
}