import 'package:flutter/material.dart';
import 'package:hybrid/utils/components/post_card.dart';

class HomeFeedView extends StatefulWidget {
  const HomeFeedView({super.key});

  @override
  State<HomeFeedView> createState() => _HomeFeedViewState();
}

class _HomeFeedViewState extends State<HomeFeedView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        PostCard(
            post: Post(
                imageUrl: 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                title: 'Random Title',
                author: 'Random Author',
                time: 'Random Time',
                likes: 4040,
                comments: 2455,
                bookmarks: 363)),
        PostCard(
            post: Post(
                imageUrl: 'https://images.pexels.com/photos/1674752/pexels-photo-1674752.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                title: 'Random Title',
                author: 'Random Author',
                time: 'Random Time',
                likes: 4040,
                comments: 2455,
                bookmarks: 363)),
        PostCard(
            post: Post(
                imageUrl: 'https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                title: 'Random Title',
                author: 'Random Author',
                time: 'Random Time',
                likes: 4040,
                comments: 2455,
                bookmarks: 363)),
      ],
    );
  }
}
