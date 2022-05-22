class Cart {
  String id;
  String userId;
  String productId;
  String productName;
  String productImage;
  int quantity;
  double price;
  double total;
  String dateTime;

  Cart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.price,
    required this.total,
    required this.dateTime,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'quantity': quantity,
      'price': price,
      'total': total,
      'dateTime': dateTime.toString(),
    };
  }
}
