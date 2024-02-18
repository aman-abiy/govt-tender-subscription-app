import 'dart:convert';

class BookmarkCheckResponse {
  bool status;
  bool isSaved;

  BookmarkCheckResponse({
    this.status,
    this.isSaved
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'isSaved': isSaved
    };
  }

  BookmarkCheckResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] != null ? json['status'].toString() == 'true' : false ;
    isSaved = json['isSaved'] != null ? json['isSaved'].toString() == 'true' : false ;
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() {
    return 'BookmarkCheckResponse(status: $status, isSaved: $isSaved)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookmarkCheckResponse &&
      other.status == status &&
      other.isSaved == isSaved;
  }

  @override
  int get hashCode {
    return status.hashCode ^
      isSaved.hashCode;
  }
}
