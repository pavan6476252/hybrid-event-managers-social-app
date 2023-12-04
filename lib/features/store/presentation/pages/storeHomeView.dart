import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/features/store/presentation/bloc/store_home_bloc.dart';
import 'package:hybrid/features/store/presentation/widget/build_offers_section.dart';
import 'package:hybrid/features/store/presentation/widget/build_popular_products.dart';
import 'package:hybrid/features/store/presentation/widget/store_category_builder.dart'; 
class StoreHomeView extends StatefulWidget {
  const StoreHomeView({Key? key}) : super(key: key);

  @override
  State<StoreHomeView> createState() => _StoreHomeViewState();
}

class _StoreHomeViewState extends State<StoreHomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BackGroundIllustrations.backGroundIllustration(
          //   context: context,
          //   top: MediaQuery.of(context).size.height / 3,
          //   left: -MediaQuery.of(context).size.width / 1.5,
          // ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  forceMaterialTransparency: true,
                  snap: true,
                  floating: true,
                  pinned: true,
                  title: const Text(
                    "Store",
                    style: TextStyle(
                      // fontSize: ,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size(double.maxFinite, 48),
                    child: _searchBar(),
                  ),
                ),
                //banner add
                SliverToBoxAdapter(
                    child: BlocConsumer<StoreHomeBloc, StoreHomeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is StoreHomeLoaded) {
                      return Column(
                        children: [
                          BuildStoreOffersSection(
                              offers: state.storeHome.offers),
                          BuildStoreCategoriesComponent(
                              categories: state.storeHome.categories),
                          BuildStorePopularProductsComponent(
                              products: state.storeHome.popular)
                        ],
                      );
                    }

                    if (state is StoreHomeFailed) {
                      return Center(
                        child: Text(state.failure.message),
                      );
                    }

                    // Show a loading indicator while data is being fetched
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Icon(Icons.search, size: 20),
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
}
