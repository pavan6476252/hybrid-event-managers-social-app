part of 'auth_bloc.dart';



abstract class AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final User user;

  AuthenticatedState(this.user);
}

class UnauthenticatedState extends AuthenticationState {}