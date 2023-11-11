import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/store_category_model.dart';

class StoreCategoryCard extends StatelessWidget {
  const StoreCategoryCard({super.key, required this.category});
  final StoreCategory category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl:
                  "https://www.ubertheme.com/wp-content/uploads/sites/3/edd/2014/06/jm-category.png",
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              height: 100.0,
              width: 100.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            category.name,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
