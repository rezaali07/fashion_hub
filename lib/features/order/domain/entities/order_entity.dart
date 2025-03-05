class OrderEntity {
  final ShippingInfo shippingInfo;
  final List<OrderItem> orderItems;
  final PaymentInfo paymentInfo;
  final double itemsPrice;
  final double taxPrice;
  final double shippingPrice;
  final double totalPrice;

  OrderEntity({
    required this.shippingInfo,
    required this.orderItems,
    required this.paymentInfo,
    required this.itemsPrice,
    required this.taxPrice,
    required this.shippingPrice,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => {
        "shippingInfo": {
          "address": shippingInfo.address,
          "city": shippingInfo.city,
          "postalCode": shippingInfo.postalCode,
          "country": shippingInfo.country,
          "phoneNo": shippingInfo.phoneNo,
        },
        "orderItems": orderItems.map((item) => item.toJson()).toList(),
        "paymentInfo": {
          "id": paymentInfo.id,
          "status": paymentInfo.status,
        },
        "itemsPrice": itemsPrice,
        "taxPrice": taxPrice,
        "shippingPrice": shippingPrice,
        "totalPrice": totalPrice,
      };
}

class ShippingInfo {
  final String address;
  final String city;
  final String postalCode;
  final String country;
  final String phoneNo;

  ShippingInfo({
    required this.address,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.phoneNo,
  });

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "country": country,
        "phoneNo": phoneNo,
      };
}

class OrderItem {
  final String product;
  final String name;
  final double price;
  final int quantity;
  final String image;

  OrderItem({
    required this.product,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "product": product,
        "name": name,
        "price": price,
        "quantity": quantity,
        "image": image,
      };
}

class PaymentInfo {
  final String id;
  final String status;

  PaymentInfo({
    required this.id,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}
