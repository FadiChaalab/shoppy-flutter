class Order {
  String id;
  String userId;
  String userName;
  String userPhone;
  String userAddress;
  String userEmail;
  int quantity;
  double total;
  String dateTime;

  Order({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
    required this.userEmail,
    required this.quantity,
    required this.total,
    required this.dateTime,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      userPhone: json['userPhone'],
      userAddress: json['userAddress'],
      userEmail: json['userEmail'],
      quantity: json['quantity'],
      total: json['total'],
      dateTime: json['dateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'userAddress': userAddress,
      'userEmail': userEmail,
      'quantity': quantity,
      'total': total,
      'dateTime': dateTime.toString(),
    };
  }

  @override
  String toString() {
    return 'Order{id: $id, userId: $userId, userName: $userName, userPhone: $userPhone, userAddress: $userAddress, userEmail: $userEmail, quantity: $quantity, total: $total, dateTime: $dateTime}';
  }
}
