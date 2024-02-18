import 'dart:convert';

import 'package:alpha_tenders_mobile_app/models/Page.dart';

class Pagination {
    Page next;
    Page prev;

  Pagination({
    this.next,
    this.prev,
  });

  Map<String, dynamic> toMap() {
    return {
      'next': next.toMap(),
      'prev': prev.toMap(),
    };
  }

  Pagination.fromJson(Map<String, dynamic> json) {
    next = json['next'] != null ? Page.fromJson(json['next']) : null;
    prev = json['prev'] != null ? Page.fromJson(json['prev']) : null;
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Pagination(next: $next, prev: $prev)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Pagination &&
      other.next == next &&
      other.prev == prev;
  }

  @override
  int get hashCode => next.hashCode ^ prev.hashCode;
}
