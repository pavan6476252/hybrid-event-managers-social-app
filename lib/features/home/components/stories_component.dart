import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hybrid/theme/t_constants.dart';

class StoriesComponent extends StatefulWidget {
  const StoriesComponent({super.key});

  @override
  State<StoriesComponent> createState() => _StoriesComponentState();
}

class _StoriesComponentState extends State<StoriesComponent> {
  final List<Map<String, dynamic>> statusData = [
    {
      'name': 'John Doe',
      'image':
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'time': '2m ago',
    },
    {
      'name': 'Jane Smith',
      'image':
          'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'time': '5m ago',
    },
    {
      'name': 'Bob Johnson',
      'image':
          'https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'time': '10m ago',
    },
    {
      'name': 'Jane Smith',
      'image':
          'https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'time': '5m ago',
    },
    {
      'name': 'Bob Johnson',
      'image':
          'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'time': '10m ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        
        scrollDirection: Axis.horizontal,
        itemCount: statusData.length,
        itemBuilder: (BuildContext context, int index) {
          Widget widget = Container(
            padding: const EdgeInsets.all(1),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(color: AppColorConstants.pink, width: 2),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                statusData[index]['image'],
              ),
            ),
          );

          if (index == 0) {
            return Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(1),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            AppColorConstants.pink,
                            AppColorConstants.mainThemeColor
                          ]),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 30,
                        grade: 800,
                      ),
                    )),
                widget
              ],
            );
          } else {
            return widget;
          }
        },
      ),
    );
  }
}
