import 'dart:convert';
import 'package:alpha_tenders_mobile_app/models/Name.dart';

class Category {
  String id;
  Name name;
  bool isParent;
  bool hasParent;
  List<Category> children = [];
  bool isActive = false;
  bool isDeleted = false;

  Category({
    this.id,
    this.name,
    this.isParent,
    this.hasParent,
    this.children,
    this.isActive,
    this.isDeleted,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    isParent = json['isParent'].toString().toLowerCase() == 'true';
    hasParent = json['hasParent'].toString().toLowerCase() == 'true';
    if (json['children'] != null) {
      json['children'].forEach((v) => v.runtimeType != String ? children.add(Category.fromJson(v)) : null);
    }
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name?.toJson();
    data['isParent'] = isParent;
    data['hasParent'] = hasParent;
    data['children'] = children?.map((v) => v.toJson())?.toList();
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  // Category.fromDB(dynamic source) {
  //   Map<String, dynamic> json;
  //   if (source is String) {
  //     json = jsonDecode(source);
  //   } else if (source is Map<String, dynamic>) {
  //     json = source;
  //   } else {
  //     throw "Unrecognized source type argument passed to fromDB() factory method";
  //   }

  //   id = json['id'];
  //   name = json['name'] != null ? Name.fromDB(json['name']) : null;
  //   parent = json['parent'] != null ? Category.fromDB(json['parent']) : null;
  //   if (json['children'] != null) {
  //     jsonDecode(json['children']).forEach((v) => children.add(Category.fromDB(v)));
  //   }
  //   isSubscribed = json['isSubscribed'] == 1;
  // }

  // dynamic toDB({returnMap: false}) {
  //   final Map<String, dynamic> data = Map<String, dynamic>();

  //   data['id'] = this.id;
  //   data['name'] = this.name != null ? this.name.toDB() : null;
  //   data['parent'] = this.parent != null ? this.parent.toDB(returnMap: false) : null;
  //   data['children'] = this.children != null ? this.children.map((v) => v.toDB(returnMap: false)).toList().toString() : null;
  //   data['isSubscribed'] = this.isSubscribed == true ? 1 : 0;

  //   return returnMap ? data : jsonEncode(data);
  // }
}
