// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostModel {
  final String id;
  final AuthorModel author;
  final DateTime createdAt;
  final String description;
  final List<String> images;
  final bool isBuySell;
  final DateTime updatedAt;
  final List<ItemModel> items;
  final int likeCount;
  final bool isLikedByCurrentUser;

  PostModel({
    required this.id,
    required this.author,
    required this.createdAt,
    required this.description,
    required this.images,
    required this.isBuySell,
    required this.updatedAt,
    required this.items,
    required this.likeCount,
    required this.isLikedByCurrentUser,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'],
      author: AuthorModel.fromJson(json['author']  as Map<String,dynamic>),
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      images: List<String>.from(json['images']),
      isBuySell: json['isBuySell'] as bool,
      updatedAt: DateTime.parse(json['updatedAt']),
      items: (json['items'] as List<dynamic>)
          .map((itemJson) => ItemModel.fromJson(itemJson as Map<String,dynamic>) )
          .toList(),
      likeCount: json['likeCount'],
      isLikedByCurrentUser: json['isLikedByCurrentUser'],
    );
  }
}

class AuthorModel {
  final String id;
  final List<String> followers;
  final List<String> following;
  final String uid;
  final String email;
  final String name;
  final String picture;
  final DateTime createdAt;

  AuthorModel({
    required this.id,
    required this.followers,
    required this.following,
    required this.uid,
    required this.email,
    required this.name,
    required this.picture,
    required this.createdAt,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['_id'],
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      picture: json['picture'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ItemModel {
  final String name;
  final String description;
  final double price;

  ItemModel({
    required this.name,
    required this.description,
    required this.price,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['name'],
      description: json['description'],
      price: json['price'] as double,
    );
  }
 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

}
