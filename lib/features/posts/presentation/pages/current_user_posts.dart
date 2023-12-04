import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hybrid/features/posts/presentation/bloc/current_user_posts/current_user_posts_bloc.dart';
import 'package:hybrid/features/posts/presentation/widget/post_card.dart';

import 'package:shimmer/shimmer.dart';

class CurrentPostsView extends StatefulWidget {
  static String pathName = '/current-user-post';

  const CurrentPostsView({super.key});

  @override
  State<CurrentPostsView> createState() => _CurrentPostsViewState();
}

class _CurrentPostsViewState extends State<CurrentPostsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if ((context.read<CurrentUserPostsBloc>().state as CurrentUserPostsLoaded)
                .posts
                .length %
            10 ==
        0) {
      context.read<CurrentUserPostsBloc>().add(CurrentUserPostsGetNextEvent(
          posts: (context.read<CurrentUserPostsBloc>().state
                  as CurrentUserPostsLoaded)
              .posts,
          page: ((context.read<CurrentUserPostsBloc>().state
                          as CurrentUserPostsLoaded)
                      .posts
                      .length ~/
                  10) +
              1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CurrentUserPostsBloc, CurrentUserPostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CurrentUserPostsLoaded) {
            return GridView.custom(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
              gridDelegate: SliverQuiltedGridDelegate(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                repeatPattern: QuiltedGridRepeatPattern.inverted,
                pattern: [
                  const QuiltedGridTile(2, 2),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 1),
                  const QuiltedGridTile(1, 2),
                ],
              ),
              childrenDelegate: SliverChildBuilderDelegate(
                childCount: state.posts.length,
                (context, index) => InkWell(
                  onTap: () => _showImagePopup(state.posts[index].images),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: state.posts[index].images.lastOrNull ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Text(""),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            );
          }

          if (state is CurrentUserPostsFailed) {
            return Center(
              child: Text(state.failure.message),
            );
          }
          // if (state is CurrentUserPostsLoading) {
          return const Center(
            child: const CircularProgressIndicator(),
          );
          // }
        },
      ),
    );
  }
void _showImagePopup(List<String> imageUrls) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: PageView(
          children: imageUrls
              .map(
                (imageUrl) => ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,  
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Text(""),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
}