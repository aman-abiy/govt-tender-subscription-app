import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Name.dart';

class TenderSource {

  String id;
  Name name;
  bool isActive;
  bool isDeleted;

  TenderSource({
    this.id,
    this.name,
    this.isActive,
    this.isDeleted
  });

  TenderSource.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.toJson();
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  // TenderSource.fromDB(dynamic source) {
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
