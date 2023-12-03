part of 'store_home_bloc.dart';

sealed class StoreHomeState extends Equatable {
  const StoreHomeState();

  @override
  List<Object> get props => [];
}

final class StoreHomeInitial extends StoreHomeState {}

final class StoreHomeLoaded extends StoreHomeState {
  final StoreHomeModel storeHome;

  const StoreHomeLoaded(this.storeHome);

  @override
  List<Object> get props => [storeHome];
}

final class StoreHomeFailed extends StoreHomeState {
  final Failure failure;
  const StoreHomeFailed({
    required this.failure,
  });
}
