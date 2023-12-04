import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hybrid/features/posts/domain/model/post_model.dart'; 
import 'package:hybrid/utils/glass_morphic.dart';
 

 
class PostCard extends StatefulWidget {
  final PostModel post;
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
                // color: AppColorConstants.white,
              ),
              Text(
                // HelperFunctions.countToKsConvertion(
                widget.post.likeCount.toString(),
                // style: TextStyle(color: AppColorConstants.white),
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
                // color: AppColorConstants.white,
              ),
              Text(
                // HelperFunctions.countToKsConvertion
                (0).toString(),
                // style: TextStyle(color: AppColorConstants.white),
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
                // color: AppColorConstants.white,
              ),
              Text(
                // HelperFunctions.countToKsConvertion
                (0).toString(),
                // style: TextStyle(color: AppColorConstants.white),
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
                widget.post.images.lastOrNull??"",
              )),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              leading:  CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                 widget.post.author.picture,
                ),
              ),
              title: Text(
                widget.post.author.name,
                // style: TextStyle(color: AppColorConstants.white),
              ),
              subtitle: Text(
                widget.post.createdAt.toLocal().toString(),
                // style: TextStyle(color: AppColorConstants.white),
              ),
              trailing: Icon(
                Icons.more_vert_sharp,
                // color: AppColorConstants.white,
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
