part of 'store_home_bloc.dart';

sealed class StoreHomeEvent extends Equatable {
  const StoreHomeEvent();

  @override
  List<Object> get props => [];
}

class StoreHomeGetEvent extends StoreHomeEvent{}