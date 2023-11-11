part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;
}

final class AuthLoading extends AuthState {}

final class AuthLoadingCancelled extends AuthState {}

final class UnAuthenticated extends AuthState {}

final class AuthenticationError extends AuthState {
  final String error;
  AuthenticationError({required this.error});
}
