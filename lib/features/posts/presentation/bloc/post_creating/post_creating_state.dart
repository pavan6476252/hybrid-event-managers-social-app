part of 'post_creating_bloc.dart';

sealed class PostCreatingState extends Equatable {
  const PostCreatingState();

  @override
  List<Object> get props => [];
}

final class PostCreatingInitial extends PostCreatingState {}

final class PostCreatingLoading extends PostCreatingState {}

final class PostCreatingSuccess extends PostCreatingState {
  final String response;
  const PostCreatingSuccess(this.response);
}

final class PostCreatingFailed extends PostCreatingState {
  final Failure failure;
  const PostCreatingFailed(this.failure);
}
