import 'package:flutter/material.dart';

import 'package:hybrid/theme/t_constants.dart';

import '../components/home_feed_view.dart';
import '../components/stories_component.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backGroundLines(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Feed",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const StoriesComponent(),
                  const SizedBox(height: 10),
                  const HomeFeedView()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned backGroundLines() {
    return Positioned(
      left: -350,
      top: -50,
      child: Transform.rotate(
        angle: 40,
        child: Container(
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
              border: Border.all(color: AppColorConstants.mainThemeColor),
              borderRadius: BorderRadius.circular(182)),
          child: Container(
            width: 480,
            height: 460,
            decoration: BoxDecoration(
                border: Border.all(color: AppColorConstants.mainThemeColor),
                borderRadius: BorderRadius.circular(152)),
          ),
        ),
      ),
    );
  }
}
