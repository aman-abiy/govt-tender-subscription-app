import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Account.dart';
import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Name.dart';
import 'package:alpha_tenders_mobile_app/models/Payment.dart';
import 'package:alpha_tenders_mobile_app/models/Subscription_Plan.dart';

class Subscription {

  String id;
  String account;
  SubscriptionPlan subscriptionPlan;
  Payment payment;
  int invoiceId;
  String invoicePDF;
  int startDate;
  int endDate;
  bool isPending;
  bool isActive;
  bool isDeleted;
  int lastUpdatedAt;
  int createdAt;

  Subscription({
    this.id,
    this.account,
    this.subscriptionPlan,
    this.payment,
    this.invoiceId,
    this.invoicePDF,
    this.startDate,
    this.endDate,
    this.isPending,
    this.isActive,
    this.isDeleted,
    this.lastUpdatedAt,
    this.createdAt
  });

  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    account = json['account'];
    subscriptionPlan = json['subscriptionPlan'] != null ? SubscriptionPlan.fromJson(json['subscriptionPlan']) : null;
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    invoiceId = json['invoiceId'] != null ? (json['invoiceId'].runtimeType == int ? json['invoiceId'] : int.parse(json['invoiceId'].toString())) : 0;
    invoicePDF = json['invoicePDF'];
    startDate = json['startDate'] != null ? (json['startDate'].runtimeType != int ? DateTime.parse(json['startDate']).millisecondsSinceEpoch : json['startDate']) : null;
    endDate = json['endDate'] != null ? (json['endDate'].runtimeType != int ? DateTime.parse(json['endDate']).millisecondsSinceEpoch : json['endDate']) : null;
    isPending = json['isPending'].toString().toLowerCase() == 'true';
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
    lastUpdatedAt = json['lastUpdatedAt'] != null ? (json['lastUpdatedAt'].runtimeType != int ? DateTime.parse(json['lastUpdatedAt']).millisecondsSinceEpoch : json['lastUpdatedAt']) : null;
    createdAt = json['createdAt'] != null ? (json['createdAt'].runtimeType != int ? DateTime.parse(json['createdAt']).millisecondsSinceEpoch : json['createdAt']) : null;
    createdAt = json['createdAt'] != null ? (json['createdAt'].runtimeType != int ? DateTime.parse(json['createdAt']).millisecondsSinceEpoch : json['createdAt']) : null;
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['account'] = account;
    data['subscriptionPlan'] = subscriptionPlan?.toJson();
    data['payment'] = payment?.toJson();
    data['invoiceId'] = invoiceId;
    data['invoicePDF'] = invoicePDF;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['isPending'] = isPending;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
  
}
