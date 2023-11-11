import 'package:flutter/material.dart';
import 'package:hybrid/utils/components/store/store_category_card.dart';
import 'package:hybrid/utils/constants.dart';

class BuildStoreCategoriesComponent extends StatefulWidget {
  const BuildStoreCategoriesComponent({super.key});

  @override
  State<BuildStoreCategoriesComponent> createState() =>
      _BuildStoreCategoriesComponentState();
}

class _BuildStoreCategoriesComponentState
    extends State<BuildStoreCategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 180,
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
                itemCount: AppConstants.storeCategoriesData.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          EdgeInsets.only(left: index == 0 ? 15 : 5, right: 5),
                      child: StoreCategoryCard(
                          category: AppConstants.storeCategoriesData[index]));
                }),
          ),
        ],
      ),
    );
  }
}
