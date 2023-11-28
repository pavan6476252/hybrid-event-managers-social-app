part of 'auth_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends AuthenticationEvent {}

class AuthenticationUserChangedEvent extends AuthenticationEvent {
  User? user;
  AuthenticationUserChangedEvent(this.user);
}

class SignOutEvent extends AuthenticationEvent {}
