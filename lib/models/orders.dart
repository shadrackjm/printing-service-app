class Orders {
  final int orderId;
  final int orderAmount;
  final int orderPayment;
  final int orderStatus;

  const Orders({
    required this.orderId,
    required this.orderAmount,
    required this.orderPayment,
    required this.orderStatus,
  });

  // map json to post model
  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      orderAmount: json['orderAmount'],
      orderPayment: json['orderPayment'],
      orderStatus: json['orderStatus'],
      orderId: json['orderId'],
    );
  }
}
