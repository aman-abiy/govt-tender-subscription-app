import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Name.dart';

class Mobile {

  String countryCode;
  String phoneNumber;
  bool isValid;
  String countryCallingCode;
  String nationalNumber;
  String formatInternational;
  String formatNational;
  String uri;
  String e164;

  Mobile({
    this.countryCode,
    this.phoneNumber,
    this.isValid,
    this.countryCallingCode,
    this.nationalNumber,
    this.formatInternational,
    this.formatNational,
    this.uri,
    this.e164
  });

  Mobile.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    isValid = json['isValid'].toString().toLowerCase() == 'true';
    countryCallingCode = json['countryCallingCode'];
    nationalNumber = json['nationalNumber'];
    formatInternational = json['formatInternational'];
    formatNational = json['formatNational'];
    uri = json['uri'];
    e164 = json['e164'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['isValid'] = isValid;
    data['countryCallingCode'] = countryCallingCode;
    data['nationalNumber'] = nationalNumber;
    data['formatInternational'] = formatInternational;
    data['formatNational'] = formatNational;
    data['uri'] = uri;
    data['e164'] = e164;
  }

}
