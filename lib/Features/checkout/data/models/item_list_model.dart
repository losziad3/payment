class ItemListModel {
  List<OrderItemModel>? orders;

  ItemListModel({this.orders});

  ItemListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      orders = <OrderItemModel>[];
      json['items'].forEach((v) {
        orders!.add(new OrderItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['items'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemModel {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  OrderItemModel({this.name, this.quantity, this.price, this.currency});

  OrderItemModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['currency'] = this.currency;
    return data;
  }
}