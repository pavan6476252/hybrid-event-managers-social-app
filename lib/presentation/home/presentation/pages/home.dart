import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/presentation/posts/presentation/pages/homePostsFeed.dart';
import 'package:hybrid/presentation/store/presentation/pages/storeHomeView.dart';
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
      // appBar: AppBar(
      //   title: const Text('Hybrid'),
      // ),
      body: [
        StoreHomeView(),
        HomePostsFeed(),
        StoreHomeView()
      ][currentPageIndex],
      //  BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, state) {
      //     if (state is AuthenticatedState) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           Text('Welcome, ${state.user.displayName}'),
      //           ElevatedButton(
      //             onPressed: () {
      //               context.read<AuthenticationBloc>().add(SignOutEvent());
      //             },
      //             child: const Text('Sign Out'),
      //           ),
      //         ],
      //       );
      //     } else {
      //       return Center(
      //         child: ElevatedButton(
      //           onPressed: () {
      //             context
      //                 .read<AuthenticationBloc>()
      //                 .add(SignInWithGoogleEvent());
      //           },
      //           child: const Text('Sign In with Google'),
      //         ),
      //       );
      //     }
      //   },
      // ),
      // floatingActionButton: ElevatedButton(
      //   onPressed: () {},
      //   child: const Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [Icon(Icons.add), SizedBox(width: 8), Text("Post")],
      //   ),
      // ),

      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
            selectedIcon: Icon(Icons.person_2_rounded),
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
