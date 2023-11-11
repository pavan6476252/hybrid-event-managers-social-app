part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileUpdateEvent extends ProfileEvent {
  final UserModel userModel;
  const ProfileUpdateEvent({required this.userModel});
}

class ProfileGetEvent extends ProfileEvent {
  // final String uid;
  // const ProfileGetEvent({required this.uid});
}
