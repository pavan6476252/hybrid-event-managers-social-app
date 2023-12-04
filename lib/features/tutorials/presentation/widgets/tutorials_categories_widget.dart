import 'package:flutter/material.dart';

class TutorialsCategoriesWidget extends StatefulWidget {
  const TutorialsCategoriesWidget({super.key});

  @override
  State<TutorialsCategoriesWidget> createState() =>
      _TutorialsCategoriesWidgetState();
}

class _TutorialsCategoriesWidgetState extends State<TutorialsCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Categories', style: style.titleMedium),
              Text(
                'Seel all',
                style: style.bodyMedium!.copyWith(color: color.secondary),
              ),
            ],
          ),
        ),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          itemCount: 8,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/svg/loki.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text("Item  $index")
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
