import 'package:flutter/material.dart';

class ListAllTutorialsWidget extends StatefulWidget {
  const ListAllTutorialsWidget({super.key});

  @override
  State<ListAllTutorialsWidget> createState() => _ListAllTutorialsWidgetState();
}

class _ListAllTutorialsWidgetState extends State<ListAllTutorialsWidget> {
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
              Text('Popular / Latest', style: style.titleMedium),
              Text(
                'Seel all',
                style: style.bodyMedium!.copyWith(color: color.secondary),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.asset(
                'assets/svg/loki.jpeg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text("Tutorial $index"),
              subtitle: Text("sub title unkonwn of in $index"),
            );
          },
        )
      ],
    );
  }
}
