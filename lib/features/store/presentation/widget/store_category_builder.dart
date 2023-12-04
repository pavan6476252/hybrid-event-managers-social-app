import 'package:flutter/material.dart';
import 'package:hybrid/features/store/domain/model/store_model.dart';
import 'package:hybrid/features/store/presentation/widget/store-category-card.dart'; 
class BuildStoreCategoriesComponent extends StatefulWidget {
  const BuildStoreCategoriesComponent({super.key, required this.categories});
  final List<Category> categories;
  @override
  State<BuildStoreCategoriesComponent> createState() =>
      _BuildStoreCategoriesComponentState();
}

class _BuildStoreCategoriesComponentState
    extends State<BuildStoreCategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 15),
      height: 160,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Categories",
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
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? 15 : 5, right: 5),
                      child: StoreCategoryCard(
                          category: widget.categories[index]));
                }),
          ),
        ],
      ),
    );
  }
}
