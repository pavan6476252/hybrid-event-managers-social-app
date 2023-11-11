import 'package:flutter/material.dart';

import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/background_illustration.dart';
import 'package:hybrid/utils/size_constants.dart';

import '../components/build_popular_products.dart';
import '../components/build_store_categories_component.dart';
import '../components/build_store_recomended_products.dart';

class StoreTab extends StatelessWidget {
  const StoreTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackGroundIllustrations.backGroundIllustration(
            context: context,
            top: MediaQuery.of(context).size.height / 3,
            left: -MediaQuery.of(context).size.width / 1.5,
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: AppColorConstants.transparent,
                  elevation: 0,
                  forceMaterialTransparency: true,
                  snap: true,
                  floating: true,
                  pinned: true,
                  title: const Text(
                    "Store",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(double.maxFinite, 78),
                    child: _searchBar(),
                  ),
                ),
                //banner add
                SliverToBoxAdapter(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    _bannerAddBuilder(context),
                    const BuildStoreCategoriesComponent(),
                    const BuildStoreRecomendedationComponent(),
                    const BuildStorePopularProductsComponent(),
                    const SizedBox(height: 80),
                  ]),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _searchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: AppColorConstants.gray.withOpacity(0.2),
            blurRadius: 5,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Icon(
              Icons.search,
              size: AppSizeConstants.bottomNavBarIconSize,
            ),
          ),
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search products',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _bannerAddBuilder(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [
                AppColorConstants.lightRed,
                AppColorConstants.pink
              ])),
          child: Banner(
            message: "New Offer",
            location: BannerLocation.bottomStart,
            color: AppColorConstants.teal,
          ),
        ),
        Text(
          '*Valid from 27/03 to 01/04 2022. Min stock: 1 unit',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
        )
      ],
    );
  }
}
