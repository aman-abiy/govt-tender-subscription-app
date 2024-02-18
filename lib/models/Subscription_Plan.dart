
class SubscriptionPlan {

  String id;
  String name;
  double price;
  double vat;
  double totalPrice;
  bool isUserSelectable;
  bool isActive;
  bool isDeleted;
  int lastUpdatedAt;
  int createdAt;
  
  SubscriptionPlan({
    this.id,
    this.name,
    this.price,
    this.vat,
    this.totalPrice,
    this.isUserSelectable,
    this.isActive,
    this.isDeleted
  });

  SubscriptionPlan.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'] != null ? (json['price'].runtimeType == double ? json['price'] : double.parse(json['price'].toString())) : 0.00;
    vat = json['vat'] != null ? (json['vat'].runtimeType == double ? json['vat'] : double.parse(json['vat'].toString())) : 0.00;
    totalPrice = json['totalPrice'] != null ? (json['totalPrice'].runtimeType == double ? json['totalPrice'] : double.parse(json['totalPrice'].toString())) : 0.00;
    isUserSelectable = json['isUserSelectable'].toString().toLowerCase() == 'true';
    isActive = json['isActive'].toString().toLowerCase() == 'true';
    isDeleted = json['isDeleted'].toString().toLowerCase() == 'true';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['vat'] = vat;
    data['totalPrice'] = totalPrice;
    data['isUserSelectable'] = isUserSelectable;
    data['isActive'] = isActive;
    data['isDeleted'] = isDeleted;
    return data;
  }

  
}
