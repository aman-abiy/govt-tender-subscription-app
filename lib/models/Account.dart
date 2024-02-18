import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Language.dart';
import 'package:alpha_tenders_mobile_app/models/Mobile.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';
import 'package:alpha_tenders_mobile_app/models/Subscription.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';

class Account {
  String id;
  String firstName;
  String lastName;
  String email;
  Mobile mobile;
  String fcmToken;
  List<Tender> bookmarks = [];
  Subscription lastActiveSubscription;
  List<Subscription> subscriptions = [];
  Subscription pendingSubscription;
  bool hasActiveSubscription;
  List<String> roles = [];
  bool isActive;
  bool isVerified;
  bool isDeleted;
  bool alertStatus;
  List<String> alertCategories = [];
  List<String> alertRegions = [];
  List<String> alertLanguages = [];
  int lastUpdatedAt;
  int createdAt;

  Account({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.fcmToken,
    this.bookmarks,
    this.lastActiveSubscription,
    this.subscriptions,
    this.pendingSubscription,
    this.roles,
    this.hasActiveSubscription,
    this.isActive,
    this.isVerified,
    this.isDeleted,
    this.alertStatus,
    this.alertCategories,
    this.alertRegions,
    this.alertLanguages,
    this.lastUpdatedAt,
    this.createdAt
  });

  Account.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstName = json['fname'];
    lastName = json['lname'];
    email = json['email'];
    mobile = json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null;
    fcmToken = json['fcmToken'];
    if((json['bookmarks'] != null)){
      json['bookmarks'].forEach((v) => v.runtimeType != String ? bookmarks.add(Tender.fromJson(v)) : null);
    }
    lastActiveSubscription = json['lastActiveSubscription'] != null ? Subscription.fromJson(json['lastActiveSubscription']) : null;
    if(json['subscriptions'] != null){
      json['subscriptions'].forEach((v) => subscriptions.add(Subscription.fromJson(v)));
    }
    pendingSubscription = json['pendingSubscription'] != null ? Subscription.fromJson(json['pendingSubscription']) : null;
    if(json['roles'] != null){
      json['roles'].forEach((v) => roles.add(v.toString()));
    }
    hasActiveSubscription = json['hasActiveSubscription'].toString().toLowerCase() == 'true';
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isVerified = json['isVerified'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
    alertStatus = json['alertStatus'].toString().toLowerCase() == 'true';
    if(json['alertCategories'] != null){
      json['alertCategories'].forEach((v) => alertCategories.add(v));
    }
    if(json['alertRegions'] != null){
      json['alertRegions'].forEach((v) => alertRegions.add(v));
    }
    if(json['alertLanguages'] != null){
      json['alertLanguages'].forEach((v) => alertLanguages.add(v));
    }
    lastUpdatedAt = json['lastUpdatedAt'] != null ? (json['lastUpdatedAt'].runtimeType != int ? DateTime.parse(json['lastUpdatedAt']).millisecondsSinceEpoch : json['lastUpdatedAt']) : null;
    createdAt = json['createdAt'] != null ? (json['createdAt'].runtimeType != int ? DateTime.parse(json['createdAt']).millisecondsSinceEpoch : json['createdAt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile?.toJson();
    data['fcmToken'] = fcmToken;
    data['bookmarks'] = bookmarks?.map((v) => v.toJson())?.toList();
    data['lastActiveSubscription'] = lastActiveSubscription?.toJson();
    data['subscriptions'] = subscriptions?.map((v) => v.toJson())?.toList();
    data['pendingSubscription'] = pendingSubscription?.toJson();
    data['roles'] = roles;
    data['hasActiveSubscription'] = hasActiveSubscription;
    data['isActive'] = isActive;
    data['isVerified'] = isVerified;
    data['isDeleted'] = isDeleted;
    data['alertStatus'] = alertStatus;
    data['alertCategories'] = alertCategories;
    data['alertRegions'] = alertRegions;
    data['alertLanguages'] = alertLanguages;
    data['lastUpdatedAt'] = lastUpdatedAt;
    data['createdAt'] = createdAt;
    return data;
  }

  
}
