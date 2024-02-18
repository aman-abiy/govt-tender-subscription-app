import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Name.dart';

class PaymentMethod {

  String id;
  String name;
  bool isActive;
  bool isDeleted;

  PaymentMethod({
    this.id,
    this.name,
    this.isActive,
    this.isDeleted
  });

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  
}
