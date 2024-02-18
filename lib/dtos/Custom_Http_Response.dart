import 'package:alpha_tenders_mobile_app/models/Meta.dart';
import 'package:dio/dio.dart';

class CustomHttpResponse {
  int statusCode;
  bool status;
  String message;
  dynamic data;
  String sessionToken;
  Headers header;
  String errors;
  Meta meta;
  
  CustomHttpResponse({
    this.statusCode,
    this.status,
    this.message,
    this.data,
    this.sessionToken,
    this.header,
    this.errors,
    this.meta,
  });

  factory CustomHttpResponse.fromJson(Map<String, dynamic> json) {
    return CustomHttpResponse(
      statusCode : json['statusCode'],
      status : json['status'],
      message : json['message'],
      data : json['data'],
      sessionToken : json['sessionToken'],
      header : json['header'],
      errors : json['errors'],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null
    );
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['sessionToken'] = this.sessionToken;
    data['header'] = this.header;
    data['errors'] = this.errors;
    data['meta'] = this.meta;
    return data;
  }
}