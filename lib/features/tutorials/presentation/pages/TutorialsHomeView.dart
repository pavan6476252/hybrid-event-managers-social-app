import 'package:flutter/material.dart';
import 'package:hybrid/features/tutorials/presentation/widgets/list_all_tutorials_widget.dart';
import 'package:hybrid/features/tutorials/presentation/widgets/tutorial_yt_banner.dart';
import 'package:hybrid/features/tutorials/presentation/widgets/tutorials_categories_widget.dart';

class TutorialsHomeView extends StatefulWidget {
  const TutorialsHomeView({super.key});

  @override
  State<TutorialsHomeView> createState() => _TutorialsHomeViewState();
}

class _TutorialsHomeViewState extends State<TutorialsHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorial"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TutorialYTBanner(),
            TutorialsCategoriesWidget(),
            ListAllTutorialsWidget()
          ],
        ),
      ),
    );
  }
}
