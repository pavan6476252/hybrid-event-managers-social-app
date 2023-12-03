import 'package:flutter/material.dart';
import 'package:hybrid/presentation/store/domain/model/store_model.dart';
import 'package:hybrid/presentation/store/presentation/widget/store_recoemended_item.dart';

class BuildStorePopularProductsComponent extends StatelessWidget {
  final List<PopularItem> products;
  const BuildStorePopularProductsComponent({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 15),
      height: 200,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Popular Products",
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
                      child:
                          StoreProductRecomemdedCard(product: products[index]));
                }),
          ),
        ],
      ),
    );
  }
}
