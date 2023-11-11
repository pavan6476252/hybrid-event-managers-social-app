part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGooglePressed extends AuthEvent {}

class AuthStateChanged extends AuthEvent {
  final User? user;

  AuthStateChanged({this.user});
}
