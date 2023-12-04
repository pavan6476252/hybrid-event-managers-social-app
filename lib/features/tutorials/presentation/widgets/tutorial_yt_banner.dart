import 'package:flutter/material.dart';

class TutorialYTBanner extends StatefulWidget {
  const TutorialYTBanner({super.key});

  @override
  State<TutorialYTBanner> createState() => _TutorialYTBannerState();
}

class _TutorialYTBannerState extends State<TutorialYTBanner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Card(child: Container(height: 200))
          // Card(
          //   child: ListTile(
          //     title: Text("Follow us on Youtube for more tutorials"),
          //     leading: Icon(Icons.video_camera_front_rounded),
          //   ),
          // )
        ],
      ),
    );
  }
}
