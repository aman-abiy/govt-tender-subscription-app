
class Bank {

  String id;
  String iso3;
  String name;
  String accountName;
  String swiftCode;
  int accountNumber;
  bool isActive;
  bool isDeleted;

  Bank({
    this.id,
    this.iso3,
    this.name,
    this.accountName,
    this.swiftCode,
    this.accountNumber,
    this.isActive,
    this.isDeleted
  });

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    iso3 = json['iso3'];
    name = json['name'];
    accountName = json['accountName'];
    swiftCode = json['swiftCode'];
    accountNumber = json['accountNumber'] != null ? (json['accountNumber'].runtimeType == int ? json['accountNumber'] : int.parse(json['accountNumber'].toString())) : 0;
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iso3'] = iso3;
    data['name'] = name;
    data['accountName'] = accountName;
    data['swiftCode'] = swiftCode;
    data['accountNumber'] = accountNumber;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  
}
