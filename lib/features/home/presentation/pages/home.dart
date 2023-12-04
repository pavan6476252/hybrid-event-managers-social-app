import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/features/home/presentation/widgets/app_drawer.dart';
import 'package:hybrid/features/posts/presentation/pages/create_post_view.dart';
import 'package:hybrid/features/posts/presentation/pages/homePostsFeed.dart';
import 'package:hybrid/features/store/presentation/pages/storeHomeView.dart';
import 'package:hybrid/features/tutorials/presentation/pages/TutorialsHomeView.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: [
        AppBar(
          title: const Text("Feed"),
        ),
        AppBar(
          title: const Text("Store"),
        ),
        AppBar(
          title: const Text("Tutorial"),
        ),
      ][currentPageIndex],
      drawer: CustomDrawer(),
      floatingActionButton: currentPageIndex == 0
          ? FloatingActionButton.extended(
              extendedPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              onPressed: () {
                Navigator.pushNamed(context, CreatePostView.pathName);
              },
              label: const Row(
                children: [Icon(Icons.add), SizedBox(width: 10), Text("Post")],
              ),
            )
          : null,
      body: [
        const HomePostsFeed(),
        const StoreHomeView(),
        const TutorialsHomeView()
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.storefront_rounded),
            icon: Icon(Icons.storefront_outlined),
            label: 'Store',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.blur_linear_rounded),
            icon: Icon(Icons.blur_linear_rounded),
            label: 'Tutorial',
          ),
        ],
      ),
    );
  }
}
