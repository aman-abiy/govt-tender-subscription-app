import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Bank.dart';
import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Currency.dart';
import 'package:alpha_tenders_mobile_app/models/Name.dart';
import 'package:alpha_tenders_mobile_app/models/Payment_Method.dart';
import 'package:alpha_tenders_mobile_app/models/Subscription.dart';

class Payment {

  String id;
  double price;
  bool isPaid;
  Subscription subscription;
  PaymentMethod paymentMethod;
  Currency currency;
  int paymentDate;
  Bank bank;
  String transactionRef;
  bool isActive;
  bool isDeleted;
  int lastUpdatedAt;
  int createdAt;

  Payment({
    this.id,
    this.price,
    this.isPaid,
    this.subscription,
    this.paymentMethod,
    this.currency,
    this.paymentDate,
    this.bank,
    this.transactionRef,
    this.isActive,
    this.isDeleted,
    this.lastUpdatedAt,
    this.createdAt
  });

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    price = json['price'] != null ? (json['price'].runtimeType == double ? json['price'] : double.parse(json['price'].toString())) : 0.00;
    isPaid = json['isPaid'].toString().toLowerCase() == 'true';
    subscription = (json['subscription'] != null && json['subscription'].runtimeType != String) ? Subscription.fromJson(json['subscription']) : null;
    paymentMethod = json['paymentMethod'] != null ? PaymentMethod.fromJson(json['paymentMethod']) : null;
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    paymentDate = json['paymentDate'] != null ? (json['paymentDate'].runtimeType != int ? DateTime.parse(json['paymentDate']).millisecondsSinceEpoch : json['paymentDate']) : null;
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    transactionRef = json['transactionRef'];
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
    lastUpdatedAt = json['lastUpdatedAt'] != null ? (json['lastUpdatedAt'].runtimeType != int ? DateTime.parse(json['lastUpdatedAt']).millisecondsSinceEpoch : json['lastUpdatedAt']) : null;
    createdAt = json['createdAt'] != null ? (json['createdAt'].runtimeType != int ? DateTime.parse(json['createdAt']).millisecondsSinceEpoch : json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['isPaid'] = isPaid;
    data['subscription'] = subscription?.toJson();
    data['paymentMethod'] = paymentMethod?.toJson();
    data['currency'] = currency?.toJson();
    data['paymentDate'] = paymentDate;
    data['bank'] = bank?.toJson();
    data['transactionRef'] = transactionRef;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
  
}
