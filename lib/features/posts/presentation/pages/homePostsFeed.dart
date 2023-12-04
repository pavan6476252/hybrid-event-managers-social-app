import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/features/posts/presentation/bloc/feed_posts_bloc.dart';
import 'package:hybrid/features/posts/presentation/pages/create_post_view.dart';
import 'package:hybrid/features/posts/presentation/widget/post_card.dart';

class HomePostsFeed extends StatefulWidget {
  const HomePostsFeed({super.key});

  @override
  State<HomePostsFeed> createState() => _HomePostsFeedState();
}

class _HomePostsFeedState extends State<HomePostsFeed> {
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
    if ((context.read<FeedPostsBloc>().state as FeedPostsLoaded).posts.length %
            10 ==
        0) {
      context.read<FeedPostsBloc>().add(FeedPostsGetNextEvent(
          posts: (context.read<FeedPostsBloc>().state as FeedPostsLoaded).posts,
          page: ((context.read<FeedPostsBloc>().state as FeedPostsLoaded)
                      .posts
                      .length ~/
                  10) +
              1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreataPostView(),
              ));
        },
        label: const Row(
          children: [Icon(Icons.add), SizedBox(width: 10), Text("Post")],
        ),
      ),
      body: BlocConsumer<FeedPostsBloc, FeedPostsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FeedPostsLoaded) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                    controller: _scrollController,
                    addAutomaticKeepAlives: true,
                    itemCount: state.posts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.posts.length) {
                        if (state.posts.length % 10 == 0) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                                "Reached end Now more posts present in DB"),
                          ),
                        );
                      }
                      return PostCard(post: state.posts[index]);
                    }));
          }

          if (state is FeedPostsFailed) {
            return Center(
              child: Text(state.failure.message),
            );
          }
          // if (state is FeedPostsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
          // }
        },
      ),
    );
  }
}
