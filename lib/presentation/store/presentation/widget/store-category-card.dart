import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hybrid/presentation/store/domain/model/store_model.dart';

class StoreCategoryCard extends StatelessWidget {
  const StoreCategoryCard({super.key, required this.category});

  final Category category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 40, 225, 179),
                borderRadius: BorderRadius.circular(8)),
            height: 100,
            width: 100,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: category.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  height: 60.0,
                  width: 60.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Center(
            child: Text(
              category.name,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
