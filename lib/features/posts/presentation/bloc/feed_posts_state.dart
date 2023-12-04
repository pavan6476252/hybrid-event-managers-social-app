// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'feed_posts_bloc.dart';

sealed class FeedPostsState extends Equatable {
  const FeedPostsState();

  @override
  List<Object> get props => [];
}

final class FeedPostsInitial extends FeedPostsState {}

final class FeedPostsLoading extends FeedPostsState {}

class FeedPostsLoaded extends FeedPostsState {
  final List<PostModel> posts;

  const FeedPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class FeedPostsFailed extends FeedPostsState {
  final Failure failure;
  const FeedPostsFailed({
    required this.failure,
  });
}
