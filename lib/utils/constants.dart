import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hybrid/utils/app_asset_const.dart';
import 'package:hybrid/utils/size_constants.dart';

import '../models/product_model.dart';
import '../models/store_category_model.dart';

class OnBoardingData {
  String title;
  String subTitle;
  String image;

  OnBoardingData(
      {required this.title, required this.subTitle, required this.image});
}

class AppConstants {
  static List<OnBoardingData> onBoardingData = [
    OnBoardingData(
      title: 'Welcome to our app!',
      subTitle: 'We are excited to have you on board.',
      image: AppAssetConstants.frameHeroImage,
    ),
    OnBoardingData(
      title: 'Explore our features',
      subTitle: 'Discover all the amazing things our app can do for you.',
      image: AppAssetConstants.frameSvg,
    ),
    OnBoardingData(
      title: 'Explore our features',
      subTitle: 'Discover all the amazing things our app can do for you.',
      image: AppAssetConstants.frameSvg,
    ),
  ];

  static List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined,
            size: AppSizeConstants.bottomNavBarIconSize),
        label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.store_mall_directory_rounded,
            size: AppSizeConstants.bottomNavBarIconSize),
        label: "Store"),
    BottomNavigationBarItem(
        label: "add post",
        icon: Icon(Icons.add, size: AppSizeConstants.bottomNavBarIconSize)),
    BottomNavigationBarItem(
        icon: Icon(Icons.messenger_outline_sharp,
            size: AppSizeConstants.bottomNavBarIconSize),
        label: "Chat"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_rounded,
            size: AppSizeConstants.bottomNavBarIconSize),
        label: "Profile"),
  ];

  static List<StoreCategory> storeCategoriesData = [
    StoreCategory(
      name: "Public Addressing Systems",
      imagePath: "assets/Storecategory_icons/public_addressing.png",
    ),
    StoreCategory(
      name: "Function Decoration",
      imagePath: "assets/Storecategory_icons/decoration.png",
    ),
    StoreCategory(
      name: "Event Furniture",
      imagePath: "assets/Storecategory_icons/furniture.png",
    ),
    StoreCategory(
      name: "Audio Visual Equipment",
      imagePath: "assets/Storecategory_icons/audio_visual.png",
    ),
    StoreCategory(
      name: "Event Accessories",
      imagePath: "assets/Storecategory_icons/accessories.png",
    ),
    StoreCategory(
      name: "Party Supplies",
      imagePath: "assets/Storecategory_icons/party_supplies.png",
    ),
    StoreCategory(
      name: "Event Tech",
      imagePath: "assets/Storecategory_icons/event_tech.png",
    ),
    StoreCategory(
      name: "Event Planning Services",
      imagePath: "assets/Storecategory_icons/planning_services.png",
    ),
    StoreCategory(
      name: "Event Merchandise",
      imagePath: "assets/Storecategory_icons/merchandise.png",
    ),
    StoreCategory(
      name: "Clearance and Sale Items",
      imagePath: "assets/Storecategory_icons/sale_items.png",
    ),
  ];

// Generate a list of fake recommended products
  static List<Product> generateFakeRecommendedProducts() {
    final List<Product> products = [];

    final List<String> productTitles = [
      "Wireless Headphones",
      "Smart Speaker",
      "Digital Camera",
      "Laptop",
      "Coffee Maker",
      "Fitness Tracker",
      "Bluetooth Keyboard",
      "Desk Organizer",
      "External Hard Drive",
      "Smartphone",
    ];

    final List<String> productDescriptions = [
      "High-quality wireless headphones with noise-canceling technology.",
      "Smart speaker with voice assistant support for your home.",
      "Advanced digital camera for capturing stunning photos and videos.",
      "Powerful laptop for work and entertainment.",
      "Coffee maker with a variety of brewing options.",
      "Fitness tracker to monitor your health and activity.",
      "Wireless Bluetooth keyboard for increased productivity.",
      "Desk organizer to keep your workspace tidy.",
      "External hard drive for extra data storage.",
      "Latest smartphone with cutting-edge features.",
    ];

    final List<String> imageUrls = [
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
      "https://static.businessworld.in/article/article_extra_large_image/1525166674_rxeGBz_fake_product_online_final.jpg",
    ];

    final Random random = Random();

    for (int i = 0; i < productTitles.length; i++) {
      final String id = 'product_${i + 1}';
      final String ownerId = 'user_${random.nextInt(10) + 1}';
      final String title = productTitles[i];
      final String description = productDescriptions[i];
      final double price = 50.0 +
          random.nextDouble() * 450.0; // Random price between $50 and $500
      final List<String> images = [
        imageUrls[i % imageUrls.length]
      ]; // Reuse images cyclically
      final DateTime createdAt =
          DateTime.now().subtract(Duration(days: random.nextInt(365)));
      final bool isSold = random.nextBool();

      final Product product = Product(
        id: id,
        ownerId: ownerId,
        title: title,
        description: description,
        price: price,
        images: images,
        createdAt: createdAt,
        isSold: isSold,
      );

      products.add(product);
    }

    return products;
  }
}
