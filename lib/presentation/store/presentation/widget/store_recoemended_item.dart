import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hybrid/presentation/store/domain/model/store_model.dart';
import 'package:hybrid/utils/glass_morphic.dart'; 

class StoreProductRecomemdedCard extends StatelessWidget {
  const StoreProductRecomemdedCard({super.key, required this.product});
  final PopularItem product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: 160,
      height: 200,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: product.imageUrls.lastOrNull??'',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 200.0,
              width: 160.0,
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: 160,
                child: Expanded(
                  child: GlassMorphism(
                    end: 0.1,
                    start: 0.5,
                    borderRadius: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "\$ ${product.price.toStringAsFixed(2)}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}