part of 'current_user_posts_bloc.dart';

sealed class CurrentUserPostsState extends Equatable {
  const CurrentUserPostsState();

  @override
  List<Object> get props => [];
}

final class CurrentUserPostsInitial extends CurrentUserPostsState {}

final class CurrentUserPostsLoading extends CurrentUserPostsState {}

class CurrentUserPostsLoaded extends CurrentUserPostsState {
  final List<PostModel> posts;

  const CurrentUserPostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

final class CurrentUserPostsFailed extends CurrentUserPostsState {
  final Failure failure;
  const CurrentUserPostsFailed({
    required this.failure,
  });
}
