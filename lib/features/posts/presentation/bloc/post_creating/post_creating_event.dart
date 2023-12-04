part of 'post_creating_bloc.dart';

sealed class PostCreatingEvent extends Equatable {
  const PostCreatingEvent();

  @override
  List<Object> get props => [];
}

final class PostThePostEvent extends PostCreatingEvent {
  final bool isBuySell;
  final String description;
  final List<File> images;
  final List<ItemModel> items;

  const PostThePostEvent(
      {required this.isBuySell,
      required this.description,
      required this.images,
      required this.items});

  @override
  List<Object> get props => [isBuySell, description, images, items];
}
