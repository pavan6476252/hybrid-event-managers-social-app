import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid/bloc/auth/auth_bloc.dart';
import 'package:hybrid/features/auth/login_screen.dart';
import 'package:hybrid/features/auth/user_details_gather.dart';
import 'package:hybrid/features/home/home_view.dart';

class AppRouter {
  static GoRouter goRouter(AuthBloc authBloc) => GoRouter(
          // initialLocation: LoginScreen.pathRoute,
          initialLocation: '/',
          refreshListenable: BlocListenable(authBloc),
          redirect: (context, state) {
            print("[auth-state] ${authBloc.state} == [fullpath] ${state.fullPath}");

            // if (authBloc.state is Authenticated &&
            //     state.path == LoginScreen.pathRoute) {
            //   return HomeScreen.pathRoute;
            // }
            // // if(
            // //   authBloc.state == Authenticated && state.path !
            // // ){

            // // }

            // else if (authBloc.state is UnAuthenticated &&
            //     state.path != LoginScreen.pathRoute) {
            //   return LoginScreen.pathRoute;
            // }

            // // if (authBloc.state is Authenticated) {
            //   return state.path;
            // // }
            if(state.fullPath=='/'){
              return LoginScreen.pathRoute;
            }
            if (authBloc.state is Authenticated &&
                (state.fullPath!.contains(LoginScreen.pathRoute))) {
              return HomeScreen.pathRoute;
            }
            return null;
          },
          debugLogDiagnostics: true,
          errorBuilder: (context, state) => const Scaffold(
                  body: Center(
                child: Text("404 Error page"),
              )),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text("Splash"),
                ),
              ),
            ),
            GoRoute(
              path: LoginScreen.pathRoute,
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: UserDetailsGatheringScreen.pathRoute,
              builder: (context, state) => const UserDetailsGatheringScreen(),
            ),
            GoRoute(
              path: HomeScreen.pathRoute,
              builder: (context, state) => const HomeScreen(),
            )
          ]);
}

class BlocListenable<T, U> extends ChangeNotifier implements Listenable {
  final Bloc<T, U> bloc;

  BlocListenable(this.bloc) {
    bloc.stream.listen((state) {
      debugPrint("[Auth] Stream refred Auth Block Listeneble called");

      notifyListeners();
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
