class AmountModel {
  final String? total;
  final String? currency;
  final Details? details;

  AmountModel(
      {required this.total, required this.currency, required this.details});

  factory AmountModel.fromJson(Map<String, dynamic> json) => AmountModel(
      total: json['total'] as String?,
      currency: json['currency'] as String?,
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>));

  Map<String, dynamic> toJson() =>{
    'total':total,
    'currency':currency,
    'details':details?.toJson()
  };
}

class Details {
  String? subtotal;
  String? shipping;
  int? shippingDiscount;

  Details({this.subtotal, this.shipping, this.shippingDiscount});

  Details.fromJson(Map<String, dynamic> json) {
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    shippingDiscount = json['shipping_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtotal'] = this.subtotal;
    data['shipping'] = this.shipping;
    data['shipping_discount'] = this.shippingDiscount;
    return data;
  }
}
