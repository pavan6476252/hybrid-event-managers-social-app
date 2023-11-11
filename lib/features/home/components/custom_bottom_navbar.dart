import 'package:flutter/material.dart';
import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/size_constants.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.changeTab,
  });

  final int currentIndex;
  final void Function(int) changeTab;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home,
                size: AppSizeConstants.bottomNavBarIconSize,
                color: currentIndex == 0
                    ? AppColorConstants.teal
                    : AppColorConstants.black),
            onPressed: () {
              changeTab(0);
            },
          ),
          IconButton(
            icon: Icon(Icons.messenger_outline_outlined,
                size: AppSizeConstants.bottomNavBarIconSize,
                color: currentIndex == 1
                    ? AppColorConstants.teal
                    : AppColorConstants.black),
            onPressed: () {
              changeTab(1);
            },
          ),
          const SizedBox(), // This SizedBox is used to create an empty space in the middle
          IconButton(
            icon: Icon(Icons.store_mall_directory_rounded,
                size: AppSizeConstants.bottomNavBarIconSize,
                color: currentIndex == 2
                    ? AppColorConstants.teal
                    : AppColorConstants.black),
            onPressed: () {
              changeTab(2);
              // Navigate to the favorites screen or perform an action
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle,
                size: AppSizeConstants.bottomNavBarIconSize,
                color: currentIndex == 3
                    ? AppColorConstants.teal
                    : AppColorConstants.black),
            onPressed: () {
              changeTab(3);
              // Navigate to the profile screen or perform an action
            },
          ),
        ],
      ),
    );
  }
}
