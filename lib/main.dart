import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/core/api.dart';
import 'package:hybrid/core/api_repo_impl.dart';
import 'package:hybrid/features/auth/data/repository/auth_repository_impl.dart';
import 'package:hybrid/features/auth/data/source/auth_remote_data_source.dart';
import 'package:hybrid/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hybrid/features/auth/presentation/pages/login.dart';
import 'package:hybrid/features/home/presentation/pages/home.dart';
import 'package:hybrid/features/posts/presentation/bloc/current_user_posts/current_user_posts_bloc.dart';
import 'package:hybrid/features/posts/presentation/bloc/feed_post/feed_posts_bloc.dart';
import 'package:hybrid/features/posts/presentation/pages/create_post_view.dart';
import 'package:hybrid/features/posts/presentation/pages/current_user_posts.dart';

import 'package:hybrid/features/store/presentation/bloc/store_home_bloc.dart';
import 'package:hybrid/firebase_options.dart';
import 'package:hybrid/utils/bloc_observer.dart';

import 'features/posts/presentation/bloc/post_creating/post_creating_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AuthenticationBloc(
                  AuthRepositoryImpl(AuthRemoteDataSource()))),
          BlocProvider(
              create: (context) =>
                  FeedPostsBloc(ApiRepositoryImpl(api: API(authToken: null)))
                    ..add(FeedPostsGetEvent())),
          BlocProvider(
              create: (context) =>
                  StoreHomeBloc(ApiRepositoryImpl(api: API(authToken: null)))
                    ..add(StoreHomeGetEvent())),
          BlocProvider(
              create: (context) => PostCreatingBloc(
                  ApiRepositoryImpl(api: API(authToken: null)))),
          BlocProvider(
              create: (context) => CurrentUserPostsBloc(
                  ApiRepositoryImpl(api: API(authToken: null)))..add(CurrentUserPostsGetEvent())),
        ],
        child: MaterialApp(
          routes: {
            CreatePostView.pathName: (context) => const CreatePostView(),
            CurrentPostsView.pathName: (context) => const CurrentPostsView(),
          },
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent)),
          home: AuthStateManager(),
        ));
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
          return const HomePage();
        } else if (state is UnauthenticatedState) {
          return const LoginPage();
        } else {
          return Scaffold(
            body: Center(child: Text(state.toString())),
          );
        }
      },
    );
  }
}
