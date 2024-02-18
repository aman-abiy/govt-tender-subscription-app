import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/models/Mobile.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/models/Subscription.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';

class AlertEmail {
  String id;
  String account;
  List<dynamic> tenders = [];
  String sentToEmail;
  String type;
  int readCheckKey;
  bool isSent;
  bool isOpened;
  bool isDeleted;
  int openedAt;
  int createdAt;

  AlertEmail({
    this.id,
    this.account,
    this.tenders,
    this.sentToEmail,
    this.type,
    this.readCheckKey,
    this.isSent,
    this.isOpened,
    this.isDeleted,
    this.openedAt,
    this.createdAt
  });

  AlertEmail.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    account = json['account'];
    if((json['tenders'] != null)){
      if(json['tenders'][0].runtimeType != String) {
        json['tenders'].forEach((v) =>  tenders.add(Tender.fromJson(v)));
      } else {
        json['tenders'].forEach((v) =>  tenders.add(v));
      }
    }
    sentToEmail = json['sentToEmail'];
    type = json['type'];
    readCheckKey = json['readCheckKey'];
    isSent = json['isSent'].toString().toLowerCase() == 'true';
    isOpened = json['isOpened'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
    openedAt = json['openedAt'] != null ? (json['openedAt'].runtimeType != int ? DateTime.parse(json['openedAt']).millisecondsSinceEpoch : json['openedAt']) : null;
    createdAt = json['createdAt'] != null ? (json['createdAt'].runtimeType != int ? DateTime.parse(json['createdAt']).millisecondsSinceEpoch : json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account'] = account;
    data['tenders'] = tenders?.map((v) => v.toJson())?.toList();
    data['sentToEmail'] = sentToEmail;
    data['type'] = type;
    data['readCheckKey'] = readCheckKey;
    data['isSent'] = isSent;
    data['isOpened'] = isOpened;
    data['isDeleted'] = isDeleted;
    data['openedAt'] = openedAt;
    data['createdAt'] = createdAt;
    return data;
  }

  
}
