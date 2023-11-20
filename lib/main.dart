import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hybrid/bloc/bloc_observer.dart';
import 'package:hybrid/bloc/theme/theme_cubit.dart';
import 'package:hybrid/features/auth/user_details_gather.dart';
import 'package:hybrid/firebase_options.dart';

import 'package:hybrid/utils/router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/profile/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  if (kIsWeb) {
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
  } else {
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getTemporaryDirectory());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        )
      ,  BlocProvider(
          create: (context) => ProfileBloc(),
        )
      ],
      child: MyAppView(),
      //   child: Builder(builder: (context) {
      //     final state = context.watch<ThemeCubit>().state;
      //     return MaterialApp.router(
      //       routerConfig: AppRouter.goRouter,
      //       title: 'Flutter Demo',
      //       themeMode: state is ThemeSystem
      //           ? ThemeMode.system
      //           : state is ThemeDark
      //               ? ThemeMode.dark
      //               : ThemeMode.light,
      //       theme: PTheme.lightTheme,
      //       darkTheme: PTheme.darkTheme,
      //     );
      //   }),
      // );
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        Brightness? themeMode = state is ThemeSystem
            ? null
            : state is ThemeDark
                ? Brightness.dark
                : Brightness.light;
        print(themeMode);

        // return MaterialApp(
// home: UserDetailsGatheringScreen(),
        // );
        return MaterialApp.router(
          routerConfig: AppRouter.goRouter(context.watch<AuthBloc>()),
          theme: ThemeData(brightness: themeMode),
          themeMode: ThemeMode.light);
          // theme: PTheme.lightTheme,
          // darkTheme: PTheme.darkTheme,
          // home: Scaffold(
          //   appBar: AppBar(
          //     actions: [
          //       IconButton(
          //           onPressed: () {
          //             if (state is ThemeDark) {
          //               context.read<ThemeCubit>().toggleTheme(ThemeEnum.light);
          //             } else {
          //               context.read<ThemeCubit>().toggleTheme(ThemeEnum.dark);
          //             }
          //           },
          //           icon: Icon(Icons.sunny))
          //     ],
          //   ),
          // ),
        // );
      },
    );
  }
}
