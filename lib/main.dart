import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/core/api.dart';
import 'package:hybrid/core/api_repo_impl.dart';
import 'package:hybrid/firebase_options.dart';
import 'package:hybrid/presentation/auth/data/repository/auth_repository_impl.dart';
import 'package:hybrid/presentation/auth/data/source/auth_remote_data_source.dart';
import 'package:hybrid/presentation/auth/presentation/bloc/auth_bloc.dart';
import 'package:hybrid/presentation/auth/presentation/pages/login.dart';
import 'package:hybrid/presentation/home/presentation/pages/home.dart';
import 'package:hybrid/presentation/posts/presentation/bloc/feed_posts_bloc.dart';
import 'package:hybrid/presentation/store/presentation/bloc/store_home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) =>
                AuthenticationBloc(AuthRepositoryImpl(AuthRemoteDataSource()))),
        BlocProvider(
            create: (context) =>
                FeedPostsBloc(ApiRepositoryImpl(api: API(authToken: null)))
                  ..add(FeedPostsGetEvent())),
        BlocProvider(
            create: (context) =>
                StoreHomeBloc(ApiRepositoryImpl(api: API(authToken: null)))
                  ..add(StoreHomeGetEvent())),
      ], child: const AuthStateManager()),
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



class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }
}
