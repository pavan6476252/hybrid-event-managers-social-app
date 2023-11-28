import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/firebase_options.dart';
import 'package:hybrid/presentation/auth/data/repository/auth_repository_impl.dart';
import 'package:hybrid/presentation/auth/data/source/auth_remote_data_source.dart';
import 'package:hybrid/presentation/auth/presentation/bloc/auth_bloc.dart';
import 'package:hybrid/presentation/auth/presentation/pages/login.dart';
import 'package:hybrid/presentation/home/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) =>
              AuthenticationBloc(AuthRepositoryImpl(AuthRemoteDataSource())),
          child: const AuthStateManager()),
    );
  }
}

class AuthStateManager extends StatelessWidget {
  const AuthStateManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print(state);
      },
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return HomePage();
        } else if (state is UnauthenticatedState) {
          return LoginPage();
        } else {
          return Scaffold(
            body: Center(child: Text(state.toString())),
          );
        }
      },
    );
  }
}
