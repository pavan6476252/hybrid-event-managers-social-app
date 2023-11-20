import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hybrid/models/user_model.dart';
import 'package:hybrid/services/firebase/firebase_services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends HydratedBloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileInitialEvent) {
        emit(ProfileInitial());
      }
      if (event is ProfileUpdateEvent) {
        await _editProfileInfo(event, emit);
      }

      if (event is ProfileGetEvent) {
        await _getProfileInfo(event, emit);
      }
    });
  }

  Future<void> _getProfileInfo(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      DocumentSnapshot documentSnapshot = await FireStoreServices()
          .getProfileInfo(uid: FirebaseAuth.instance.currentUser?.uid ?? "");

      if (documentSnapshot.exists) {
        emit(ProfileLoaded(
            userModel: UserModel.fromMap(
                documentSnapshot.data() as Map<String, dynamic>)));
      } else {
        emit(ProfileDoesNotExists());
      }
    } on FirebaseException catch (e) {
      emit(ProfileFailed(errorMsg: e.toString()));
    }
  }

  Future<void> _editProfileInfo(
      ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    try {
      await FireStoreServices().editProfileInfo(
          prfileImage: event.profileImage,
          bannerImage: event.bannerImage,
          uid: FirebaseAuth.instance.currentUser?.uid ?? "",
          userModel: event.userModel);

      emit(ProfileLoaded(userModel: event.userModel));
    } on FirebaseException catch (e) {
      print("error" + e.toString());
      emit(ProfileFailed(errorMsg: e.toString()));
    }
  }

  @override
  ProfileState? fromJson(Map<String, dynamic> json) {
    print("[Profile bloc from json]");
    print(json);
    if (json["profile"] != null) {
      return ProfileLoaded(
          userModel:
              UserModel.fromMap(json["profile"] as Map<String, dynamic>));
    } else {
      add(ProfileGetEvent());
    }
  }

  @override
  Map<String, dynamic>? toJson(ProfileState state) {
    print(state);
    if (state is ProfileLoaded) {
      print("[Profile bloc to json]");
      return {"profile ": state.userModel.toMap()};
    }
    //   if (state is ProfileInitial) {
    //   add(ProfileGetEvent());
    // }
    return null;
  }
}
