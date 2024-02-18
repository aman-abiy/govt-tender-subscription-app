import 'dart:convert';

import 'package:alpha_tenders_mobile_app/models/Country.dart';
import 'package:alpha_tenders_mobile_app/models/Mobile.dart';
import 'package:alpha_tenders_mobile_app/models/Region.dart';

class CompanyInfo {

  String id;
  String name;
  String address;
  Region region;
  Country country;
  Mobile phone1;
  Mobile phone2;
  Mobile phone3;
  int tin;
  String email;
  String website;
  String telegram;
  bool isActive;
  bool isDeleted;

  CompanyInfo({
    this.id,
    this.name,
    this.address,
    this.region,
    this.country,
    this.phone1,
    this.phone2,
    this.phone3,
    this.tin,
    this.email,
    this.website,
    this.telegram,
    this.isActive,
    this.isDeleted,
  });

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    address = json['address'] ?? '';    
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
    phone1 = json['phone1'] != null ? Mobile.fromJson(json['phone1']) : null;
    phone2 = json['phone2'] != null ? Mobile.fromJson(json['phone2']) : null;
    phone3 = json['phone3'] != null ? Mobile.fromJson(json['phone3']) : null;
    tin = json['tin'] != null ? (json['tin'].runtimeType == int ? json['tin'] : int.parse(json['tin'].toString())) : 0;
    email = json['email'] ?? '';
    website = json['website'] ?? '';
    telegram = json['telegram'] ?? '';
    isActive = json['isActive'] ?? false;
    isDeleted = json['isDeleted'] ?? false;
  }

  @override
  String toString() {
    return 'CompanyInfo(id: $id, name: $name, address: $address, region: $region, country: $country, phone1: $phone1, phone2: $phone2, phone3: $phone3, tin: $tin, email: $email, website: $website, telegram: $telegram isActive: $isActive, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CompanyInfo &&
      other.id == id &&
      other.name == name &&
      other.address == address &&
      other.region == region &&
      other.country == country &&
      other.phone1 == phone1 &&
      other.phone2 == phone2 &&
      other.phone3 == phone3 &&
      other.tin == tin &&
      other.email == email &&
      other.website == website &&
      other.telegram == telegram &&
      other.isActive == isActive &&
      other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      address.hashCode ^
      region.hashCode ^
      country.hashCode ^
      phone1.hashCode ^
      phone2.hashCode ^
      phone3.hashCode ^
      tin.hashCode ^
      email.hashCode ^
      website.hashCode ^
      telegram.hashCode ^
      isActive.hashCode ^
      isDeleted.hashCode;
  }
}
