// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_posts_bloc.dart';

sealed class FeedPostsEvent extends Equatable {
  const FeedPostsEvent();

  @override
  List<Object> get props => [];
}

class FeedPostsGetEvent extends FeedPostsEvent {}

class FeedPostsGetNextEvent extends FeedPostsEvent {
  final int page;
  final List<PostModel> posts;
  const FeedPostsGetNextEvent({
    required this.page,
    required this.posts,
  });
}

// class FeedPostsGetEvent extends FeedPostsEvent {
// }