import 'dart:convert';

import 'package:alpha_tenders_mobile_app/models/Pagination.dart';

class Meta {
  int startIndex;
  int limit;
  Pagination pagination;
  int currentPage;
  int total;

  Meta({
    this.startIndex,
    this.limit,
    this.pagination,
    this.currentPage,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'startIndex': startIndex,
      'limit': limit,
      'pagination': pagination.toMap(),
      'currentPage': currentPage,
      'total': total,
    };
  }

  Meta.fromJson(Map<String, dynamic> json) {
    startIndex = json['startIndex'] != null ? (json['startIndex'].runtimeType == int ? json['startIndex'] : int.parse(json['startIndex'].toString())) : 0;
    limit = json['limit'] != null ? (json['limit'].runtimeType == int ? json['limit'] : int.parse(json['limit'].toString())) : 0;
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    currentPage = json['currentPage'] != null ? (json['currentPage'].runtimeType == int ? json['currentPage'] : int.parse(json['currentPage'].toString())) : 0;
    total = json['total'] != null ? (json['total'].runtimeType == int ? json['total'] : int.parse(json['total'].toString())) : 0;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Meta(startIndex: $startIndex, limit: $limit, pagination: $pagination, currentPage: $currentPage, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Meta &&
      other.startIndex == startIndex &&
      other.limit == limit &&
      other.pagination == pagination &&
      other.currentPage == currentPage &&
      other.total == total;
  }

  @override
  int get hashCode {
    return startIndex.hashCode ^
      limit.hashCode ^
      pagination.hashCode ^
      currentPage.hashCode ^
      total.hashCode;
  }
}
