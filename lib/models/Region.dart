import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Name.dart';

class Region {

  String id;
  Name name;
  String slug;
  bool isActive;
  bool isDeleted;
  Country country;

  Region({
    this.id,
    this.name,
    this.slug,
    this.isActive,
    this.isDeleted,
    this.country
  });

  Region.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    slug = json['slug'];
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
    // country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.toJson();
    data['slug'] = slug;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  // Region.fromDB(dynamic source) {
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
