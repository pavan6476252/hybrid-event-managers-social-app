// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  final String userId;
  final String? username;
  final String? fullName;
  final String? email;
  final String? bio;
  final String? profileImageUrl;
  final String? coverImageUrl;
  final String? phoneNumber;
  final GeoPoint? geoPoint;
  final DateTime? birthdate;
  final List<String>? followers;
  final List<String>? following;

  UserModel({
    required this.userId,
    required this.username,
    this.fullName,
    this.email,
    this.bio,
    this.profileImageUrl,
    this.coverImageUrl,
    this.geoPoint,
    this.phoneNumber,
    this.birthdate,
      this.followers,
      this.following,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'fullName': fullName,
      'email': email,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'coverImageUrl': coverImageUrl,
      'phoneNumber': phoneNumber,
      'geoPoint': geoPoint,
      'birthdate': birthdate?.millisecondsSinceEpoch,
      'followers': followers,
      'following': following,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      profileImageUrl: map['profileImageUrl'] != null
          ? map['profileImageUrl'] as String
          : null,
      coverImageUrl:
          map['coverImageUrl'] != null ? map['coverImageUrl'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      geoPoint: map['geoPoint'] != null ? map['geoPoint'] as GeoPoint : null,
      birthdate: map['birthdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['birthdate'] as int)
          : null,
      followers: map['followers'] != null
          ? List<String>.from((map['followers'] as List<String>))
          : null,
      following: map['following'] != null
          ? List<String>.from((map['following'] as List<String>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? userId,
    String? username,
    String? fullName,
    String? email,
    String? bio,
    String? profileImageUrl,
    String? coverImageUrl,
    String? phoneNumber,
    GeoPoint? geoPoint,
    DateTime? birthdate,
    List<String>? followers,
    List<String>? following,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      geoPoint: geoPoint ?? this.geoPoint,
      birthdate: birthdate ?? this.birthdate,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
