part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
class ProfileInitialEvent extends ProfileEvent{

}

class ProfileUpdateEvent extends ProfileEvent {
  final UserModel userModel;
  final File? profileImage;
  final File? bannerImage;
  const ProfileUpdateEvent(
      {required this.userModel, this.profileImage, this.bannerImage});
}

class ProfileGetEvent extends ProfileEvent {
  // final String uid;
  // const ProfileGetEvent({required this.uid});
}
