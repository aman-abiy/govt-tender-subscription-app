import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Name.dart';

class Currency {

  String id;
  String name;
  String iso3;
  bool isActive;
  bool isDeleted;

  Currency({
    this.id,
    this.name,
    this.iso3,
    this.isActive,
    this.isDeleted,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    iso3 = json['iso3'];
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['iso3'] = iso3;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }
}
