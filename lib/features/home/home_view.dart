import 'package:flutter/material.dart';

import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/constants.dart';

import 'components/custom_bottom_navbar.dart';
import 'tabs/chat_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/store_tabs.dart';

class HomeScreen extends StatefulWidget {
    static String pathRoute = '/home-view';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  void changeTab(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          [
            const HomeTab(),
              ChatTab(),
            const StoreTab(),
             ProfileTab(),
          ][currentIndex],
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              currentIndex: currentIndex,
              changeTab: changeTab,
            ),
          ),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.rotate(
                angle: 40,
                child: FloatingActionButton(
                  backgroundColor: AppColorConstants.black,
                  onPressed: () {},
                  child: Transform.rotate(
                    angle: -40,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: AppColorConstants.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Transform.rotate(
      //   angle: 40,
      //   child: FloatingActionButton(
      //     backgroundColor: AppColorConstants.black,
      //     onPressed: () {},
      //     child: Transform.rotate(
      //       angle: -40,
      //       child: Icon(
      //         Icons.add_circle_outline,
      //         color: AppColorConstants.white,
      //       ),
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
    );
  }
}
