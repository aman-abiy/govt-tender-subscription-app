
import 'package:alpha_tenders_mobile_app/models/Company.dart';

class Advertisement {

  String id;
  String bannerTitle;
  String bannerDescription;
  String hyperlink;
  String bannerImage;
  String themeColorHex;
  Company company;
  String type;
  bool isActive;
  bool isDeleted;

  Advertisement({
    this.id,
    this.bannerTitle,
    this.bannerDescription,
    this.hyperlink,
    this.bannerImage,
    this.themeColorHex,
    this.company,
    this.type,
    this.isActive,
    this.isDeleted
  });

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    bannerTitle = json['bannerTitle'];
    bannerDescription = json['bannerDescription'];
    hyperlink = json['hyperlink'];
    bannerImage = json['bannerImage'];
    themeColorHex = json['themeColorHex'];
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    type = json['type'];
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bannerTitle'] = bannerTitle;
    data['bannerDescription'] = bannerDescription;
    data['hyperlink'] = hyperlink;
    data['bannerImage'] = bannerImage;
    data['themeColorHex'] = themeColorHex;
    data['company'] = company?.toJson();
    data['type'] = type;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  
}
