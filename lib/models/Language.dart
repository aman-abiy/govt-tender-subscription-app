import 'dart:convert';

class Language {

  String id;
  String iso;
  String iso3;
  String name;
  bool isActive;
  bool isDeleted;

  Language({
    this.id, 
    this.iso, 
    this.iso3, 
    this.name,
    this.isActive,
    this.isDeleted
  });

  Language.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    iso = json['iso'];
    iso3 = json['iso3'];
    name = json['name'];
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['iso'] = iso;
    data['iso3'] = iso3;
    data['name'] = name;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  // Language.fromDB(dynamic source) {
  //   Map<String, dynamic> json;
  //   if (source is String) {
  //     json = jsonDecode(source);
  //   } else if (source is Map<String, dynamic>) {
  //     json = source;
  //   } else {
  //     throw "Unrecognized source type argument passed to fromDB() factory method";
  //   }


  //   id = json['id'];
  //   iso = json['iso'];
  //   iso3 = json['iso3'];
  //   name = json['name'];
  // }

  // dynamic toDB({returnMap: false}) {
  //   return returnMap ? toJson() : jsonEncode(toJson());
  // }
}
