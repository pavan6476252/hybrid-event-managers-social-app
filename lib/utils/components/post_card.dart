import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/components/glass_morphic.dart';
import 'package:hybrid/utils/helper_functions.dart';

class Post {
  final String imageUrl;
  final String title;
  final String author;
  final String time;
  final int likes;
  final int comments;
  final int bookmarks;

  Post({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.time,
    required this.likes,
    required this.comments,
    required this.bookmarks,
  });
}

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({required this.post, Key? key}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> UtilButtons = [
      GlassMorphism(
        start: 0.1,
        end: 0.5,
        borderRadius: 35,
        child: SizedBox(
          height: 28,
          width: 71,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: AppColorConstants.white,
              ),
              Text(
                HelperFunctions.countToKsConvertion(widget.post.likes),
                style: TextStyle(color: AppColorConstants.white),
              ),
            ],
          ),
        ),
      ),
      GlassMorphism(
        start: 0.1,
        end: 0.5,
        borderRadius: 35,
        child: SizedBox(
          height: 28,
          width: 71,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.messenger_outline_sharp,
                color: AppColorConstants.white,
              ),
              Text(
                HelperFunctions.countToKsConvertion(widget.post.comments),
                style: TextStyle(color: AppColorConstants.white),
              ),
            ],
          ),
        ),
      ),
      GlassMorphism(
        start: 0.1,
        end: 0.5,
        borderRadius: 35,
        child: SizedBox(
          height: 28,
          width: 71,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.bookmark_border_outlined,
                color: AppColorConstants.white,
              ),
              Text(
                HelperFunctions.countToKsConvertion(widget.post.bookmarks),
                style: TextStyle(color: AppColorConstants.white),
              ),
            ],
          ),
        ),
      ),
    ];

    return GestureDetector(
      // onTap: () => Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ChatComponent(),
      //     )),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 290,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                widget.post.imageUrl,
              )),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                ),
              ),
              title: Text(
                widget.post.author,
                style: TextStyle(color: AppColorConstants.white),
              ),
              subtitle: Text(
                widget.post.time,
                style: TextStyle(color: AppColorConstants.white),
              ),
              trailing: Icon(
                Icons.more_vert_sharp,
                color: AppColorConstants.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: UtilButtons),
            )
          ],
        ),
      ),
    );
  }
}
