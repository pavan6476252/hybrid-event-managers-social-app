import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../utils/components/store/store_product_recom_card.dart';
import '../../../utils/constants.dart';

class BuildStoreRecomendedationComponent extends StatelessWidget {
  const BuildStoreRecomendedationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = AppConstants.generateFakeRecommendedProducts();
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 200,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Recomended",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? 15 : 5, right: 5),
                      child: StoreProductRecomemdedCard(
                           product: products[index]));
                }),
          ),
        ],
      ),
    );
  }
}
