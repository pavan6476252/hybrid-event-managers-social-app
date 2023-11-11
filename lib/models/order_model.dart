
class Order {
  final String id; // Unique order identifier
  final String productId; // ID of the product being ordered
  final String buyerId; // ID of the user placing the order
  double totalPrice; // Total price of the order
  DateTime createdAt; // Date when the order was placed
  bool isCompleted; // Indicates if the order has been completed

  Order({
    required this.id,
    required this.productId,
    required this.buyerId,
    required this.totalPrice,
    required this.createdAt,
    required this.isCompleted,
  });
}
