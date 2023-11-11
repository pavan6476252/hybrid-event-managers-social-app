class Product {
  final String id; // Unique product identifier
  final String ownerId; // ID of the user who listed the product
  String title; // Product title
  String description; // Product description
  double price; // Product price
  List<String> images; // URLs of product images
  DateTime createdAt; // Date when the product listing was created
  bool isSold; // Indicates if the product has been sold

  Product({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.createdAt,
    required this.isSold,
  });
}
