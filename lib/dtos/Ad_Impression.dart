import 'dart:convert';

class AdImpression {
  String type;
  String advertisement;

  AdImpression({
    this.type,
    this.advertisement
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'advertisement': advertisement
    };
  }

  AdImpression.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    advertisement = json['advertisement'];
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() {
    return 'AdImpression(type: $type, advertisement: $advertisement)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AdImpression &&
      other.type == type &&
      other.advertisement == advertisement;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      advertisement.hashCode;
  }
}
