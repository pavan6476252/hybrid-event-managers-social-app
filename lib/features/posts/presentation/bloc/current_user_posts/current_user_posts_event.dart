part of 'current_user_posts_bloc.dart';

sealed class CurrentUserPostsEvent extends Equatable {
  const CurrentUserPostsEvent();

  @override
  List<Object> get props => [];
}

class CurrentUserPostsGetEvent extends CurrentUserPostsEvent {}

class CurrentUserPostsGetNextEvent extends CurrentUserPostsEvent {
  final int page;
  final List<PostModel> posts;
  const CurrentUserPostsGetNextEvent({
    required this.page,
    required this.posts,
  });
}
