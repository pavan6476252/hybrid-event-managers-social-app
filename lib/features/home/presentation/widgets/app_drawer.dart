import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hybrid/features/posts/presentation/pages/current_user_posts.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                return UserAccountsDrawerHeader(
                  accountName: Text(
                    state.user.displayName ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    state.user.email ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: state.user.photoURL == null
                      ? null
                      : CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              state.user.photoURL ?? "")),
                );
              }
              return const SizedBox();
            },
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.my_library_books_sharp),
              title: const Text('My Posts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, CurrentPostsView.pathName);
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle drawer item tap for Settings
                Navigator.pop(context);
              },
            ),
          ),
          Spacer(),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Logout'),
              onTap: () {
                context.read<AuthenticationBloc>().add(SignOutEvent());
              },
            ),
          ),
        ],
      ),
    );
  }
}
