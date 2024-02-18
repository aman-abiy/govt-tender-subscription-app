import 'dart:convert';

class Name {
  String en;
  String am;

  Name({this.en, this.am});

  Name.fromJson(Map<String, dynamic> json) {
    _jsonHelper(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['am'] = am;
    return data;
  }

  Name.fromDB(String source) {
    _jsonHelper(jsonDecode(source));
  }

  String toDB() {
    return jsonEncode(toJson());
  }

  void _jsonHelper(Map<String, dynamic> json) {
    en = json['en'];
    am = json['am'];
  }
}
