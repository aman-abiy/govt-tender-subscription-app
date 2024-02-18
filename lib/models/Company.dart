
import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Mobile.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';

import 'Subscription.dart';

class Company {

  String id;
  String name;
  String address;
  String description;
  Region region;
  Country country;
  Mobile phone1;
  Mobile phone2;
  Mobile phone3;
  String tin;
  String email;
  String website;
  Subscription lastActiveSubscription;
  List<Subscription> subscriptions = [];
  Subscription pendingSubscription;
  bool hasActiveSubscription;
  Subscription lastActiveAdSubscription;
  List<Subscription> adSubscriptions = [];
  Subscription pendingAdSubscription;
  bool hasActiveAdSubscription;
  bool isActive;
  bool isDeleted;

  Company({
    this.id,
    this.name,
    this.address,
    this.description,
    this.region,
    this.country,
    this.phone1,
    this.phone2,
    this.phone3,
    this.tin,
    this.email,
    this.website,
    this.lastActiveSubscription,
    this.subscriptions,
    this.pendingSubscription,
    this.hasActiveSubscription,
    this.lastActiveAdSubscription,
    this.adSubscriptions,
    this.pendingAdSubscription,
    this.hasActiveAdSubscription,
    this.isActive,
    this.isDeleted
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    // region = json['region'] != null ? Region.fromJson(json['region']) : null;
    // country = json['country'] != null ? Country.fromJson(json['country']) : null;
    phone1 = json['phone1'] != null ? Mobile.fromJson(json['phone1']) : null;
    phone2 = json['phone2'] != null ? Mobile.fromJson(json['phone2']) : null;
    phone3 = json['phone3'] != null ? Mobile.fromJson(json['phone3']) : null;
    tin = json['tin'];
    email = json['email'];
    website = json['website'];
    lastActiveSubscription = json['lastActiveSubscription'] != null ? Subscription.fromJson(json['lastActiveSubscription']) : null;
    if(json['subscriptions'] != null){
      json['subscriptions'].forEach((v) => subscriptions.add(Subscription.fromJson(v)));
    }
    pendingSubscription = json['pendingSubscription'] != null ? Subscription.fromJson(json['pendingSubscription']) : null;
    hasActiveSubscription = json['hasActiveSubscription'].toString().toLowerCase() == 'true';
    lastActiveAdSubscription = json['lastActiveAdSubscription'] != null ? Subscription.fromJson(json['lastActiveAdSubscription']) : null;
    if(json['adSubscriptions'] != null){
      json['adSubscriptions'].forEach((v) => adSubscriptions.add(Subscription.fromJson(v)));
    }
    pendingAdSubscription = json['pendingAdSubscription'] != null ? Subscription.fromJson(json['pendingAdSubscription']) : null;
    hasActiveAdSubscription = json['hasActiveAdSubscription'].toString().toLowerCase() == 'true';
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['description'] = description;
    data['region'] = region?.toJson();
    data['country'] = country?.toJson();
    data['phone1'] = phone1?.toJson();
    data['phone2'] = phone2?.toJson();
    data['phone3'] = phone3?.toJson();
    data['tin'] = tin;
    data['email'] = email;
    data['website'] = website;
    data['lastActiveSubscription'] = lastActiveSubscription?.toJson();
    data['subscriptions'] = subscriptions?.map((v) => v.toJson())?.toList();
    data['pendingSubscription'] = pendingSubscription?.toJson();
    data['hasActiveSubscription'] = hasActiveSubscription;
    data['lastActiveAdSubscription'] = lastActiveAdSubscription?.toJson();
    data['adSubscriptions'] = adSubscriptions?.map((v) => v.toJson())?.toList();
    data['pendingAdSubscription'] = pendingAdSubscription?.toJson();
    data['hasActiveAdSubscription'] = hasActiveAdSubscription;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  
}
