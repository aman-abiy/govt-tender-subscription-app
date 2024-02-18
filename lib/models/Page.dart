import 'dart:convert';

class Page {
  int page;
  int limit;

  Page({
    this.page,
    this.limit,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
    };
  }

  Page.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? (json['page'].runtimeType == int ? json['page'] : int.parse(json['page'].toString())) : 0;
    limit = json['limit'] != null ? (json['limit'].runtimeType == int ? json['limit'] : int.parse(json['limit'].toString())) : 0;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Page(page: $page, limit: $limit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Page &&
      other.page == page &&
      other.limit == limit;
  }

  @override
  int get hashCode => page.hashCode ^ limit.hashCode;
}
