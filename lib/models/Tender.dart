import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/models/Name.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/models/Tender_Source.dart';

class Tender {

  String id;
  String siteId;
  String title;
  String description;
  Language language;
  Region region;
  List<TenderSource> tenderSources = [];
  List<Category> categories = [];
  String bidBond;
  int bidOpeningDate;
  String bidOpeningDateText;
  int bidClosingDate;
  String bidClosingDateText;
  int publicationDate;
  bool isSaved;
  bool isPublished;
  bool isFeatured;  
  bool isActive;
  bool isDeleted;
  int lastUpdatedAt;
  int createdAt;

  Tender({
    this.id,
    this.siteId,
    this.title,
    this.description,
    this.language,
    this.region,
    this.tenderSources,
    this.categories,
    this.bidBond,
    this.bidOpeningDate,
    this.bidOpeningDateText,
    this.bidClosingDate,
    this.bidClosingDateText,
    this.publicationDate,
    this.isSaved,
    this.isPublished,
    this.isFeatured,
    this.isActive,
    this.isDeleted,
    this.lastUpdatedAt,
    this.createdAt
  });

  Tender.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    siteId = json['site_id'];
    title = json['title'];
    description = json['description'];
    language = json['language'] != null ? Language.fromJson(json['language']) : null;
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    if(json['tenderSources'] != null){
      json['tenderSources'].forEach((v) => tenderSources.add(TenderSource.fromJson(v)));
    }
    if(json['categories'] != null){
      json['categories'].forEach((v) => categories.add(Category.fromJson(v)));
    }
    bidBond = json['bidBond'];
    bidOpeningDate = DateTime.parse(json['bidOpeningDate']).millisecondsSinceEpoch;
    bidOpeningDateText = json['bidOpeningDateText'];
    bidClosingDate = DateTime.parse(json['bidClosingDate']).millisecondsSinceEpoch;
    bidClosingDateText = json['bidClosingDateText'];
    publicationDate = DateTime.parse(json['publicationDate']).millisecondsSinceEpoch;
    isSaved = json['isSaved'].toString().toLowerCase() == 'true';
    isPublished = json['isPublished'].toString().toLowerCase() == 'true';
    isFeatured = json['isFeatured'].toString().toLowerCase() == 'true';
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
    lastUpdatedAt = json['lastUpdatedAt'] != null ? (json['lastUpdatedAt'].runtimeType != int ? DateTime.parse(json['lastUpdatedAt']).millisecondsSinceEpoch : json['lastUpdatedAt']) : null;
    createdAt = json['createdAt'] != null ? (json['createdAt'].runtimeType != int ? DateTime.parse(json['createdAt']).millisecondsSinceEpoch : json['createdAt']) : null;

    print('json[ map ${tenderSources[0].name.en}');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['siteId'] = siteId;
    data['title'] = title;
    data['description'] = description;
    data['language'] = language?.toJson();
    data['region'] = region?.toJson();
    data['tenderSources'] = tenderSources?.map((v) => v.toJson())?.toList();
    data['categories'] = categories?.map((v) => v.toJson())?.toList();
    data['bidBond'] = bidBond;
    data['bidOpeningDate'] = bidOpeningDate;
    data['bidOpeningDateText'] = bidOpeningDateText;
    data['bidClosingDate'] = bidClosingDate;
    data['bidClosingDateText'] = bidClosingDateText;
    data['publicationDate'] = publicationDate;
    data['isPublished'] = isPublished;
    data['isFeatured'] = isFeatured;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['createdAt'] = createdAt;
    return data;
  }

  // Tender.fromDB(dynamic source) {
  //   Map<String, dynamic> json;
  //   if (source is String) {
  //     json = jsonDecode(source);
  //   } else if (source is Map<String, dynamic>) {
  //     json = source;
  //   } else {
  //     throw "Unrecognized source type argument passed to fromDB() factory method";
  //   }


  //   id = json['id'];
  //   name = json['name'] != null ? Name.fromDB(json['name']) : null;
  //   isSubscribed = json['isSubscribed'] == 1;
  // }

  // dynamic toDB({returnMap: false}) {
  //   final Map<String, dynamic> data = Map<String, dynamic>();

  //   data['id'] = this.id;
  //   data['name'] = this.name != null ? this.name.toDB() : null;
  //   data['isSubscribed'] = this.isSubscribed == true ? 1 : 0;
  //   return returnMap ? data : jsonEncode(data);
  // }
}
