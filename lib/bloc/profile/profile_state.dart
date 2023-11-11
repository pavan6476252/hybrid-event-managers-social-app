part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}
final class ProfileInfoNotFound extends ProfileState {}

final class ProfileDoesNotExists extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final UserModel userModel;
  ProfileLoaded({required this.userModel});
}

final class ProfileFailed extends ProfileState {
  final String errorMsg;
  const ProfileFailed({required this.errorMsg});
}
