import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hybrid/presentation/auth/data/repository/auth_repository_impl.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepositoryImpl _authRepository;

  AuthenticationBloc(this._authRepository)
      : super(AuthenticationInitialState()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      try {
        final User? user = await _authRepository.signInWithGoogle();
        if (user != null) {
          emit(AuthenticatedState(user));
        } else {
          emit(UnauthenticatedState());
        }
      } catch (e) {
        print("Error signing in with Google: $e");
        emit(UnauthenticatedState());
      }
    });

    on<SignOutEvent>((event, emit) async {
      await _authRepository.signOut();
      emit(UnauthenticatedState());
    });

    on<AuthenticationUserChangedEvent>((event, emit) {
      if (event.user != null) {
        emit(AuthenticatedState(event.user!));
      } else {
        emit(UnauthenticatedState());
      }
    });

    _authRepository.authStateChanges.listen((event) {
      if (event != null) {
        add(AuthenticationUserChangedEvent(event));
      } else {
        add(AuthenticationUserChangedEvent(null));
      }
    });
  }
}
