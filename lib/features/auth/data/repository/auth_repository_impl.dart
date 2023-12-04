 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hybrid/features/auth/data/source/auth_remote_data_source.dart';
import 'package:hybrid/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User?> signInWithGoogle() => _remoteDataSource.signInWithGoogle();

  @override
  Future<void> signOut() => _remoteDataSource.signOut();

  @override
  Stream<User?> get authStateChanges => _remoteDataSource.getAuthStateChanges();
}
