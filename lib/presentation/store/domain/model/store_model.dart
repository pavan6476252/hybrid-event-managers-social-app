class StoreHomeModel {
  final List<Offer> offers;
  final List<PopularItem> popular;
  final List<Category> categories;
  // final List<dynamic> recommended; // Assuming recommended is a list of dynamic

  StoreHomeModel({
    required this.offers,
    required this.popular,
    required this.categories,
    // required this.recommended,
  });

  factory StoreHomeModel.fromJson(Map<String, dynamic> json) {
    return StoreHomeModel(
      offers: (json['offers'] as List<dynamic>)
          .map((offer) => Offer.fromJson(offer as Map<String,dynamic>))
          .toList(),
      popular: (json['popular'] as List<dynamic>)
          .map((popularItem) => PopularItem.fromJson(popularItem as Map<String,dynamic>))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((category) => Category.fromJson(category as Map<String,dynamic>))
          .toList(),
      // recommended: json['recommended'] ?? [],
    );
  }
}

class Offer {
  final String id;
  final String name;
  final String description;
  final String image;
  final int discountPercentage;
  final String startDate;
  final String endDate;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      discountPercentage: json['discountPercentage'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }
}

class PopularItem {
  final String id;
  final String author;
  final String name;
  final String description;
  final int price;
  final int quantityAvailable;
  final List<String> imageUrls;
  final List<String> category;
  final List<String> offers;

  PopularItem({
    required this.id,
    required this.author,
    required this.name,
    required this.description,
    required this.price,
    required this.quantityAvailable,
    required this.imageUrls,
    required this.category,
    required this.offers,
  });

  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      id: json['_id'],
      author: json['author'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantityAvailable: json['quantityAvailable'],
      imageUrls: List<String>.from(json['imageUrls']),
      category: List<String>.from(json['category']),
      offers: List<String>.from(json['offers']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
    );
  }
}
