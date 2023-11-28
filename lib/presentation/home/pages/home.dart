import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/presentation/bloc/auth_bloc.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Auth'),
      ),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          
        if (state is AuthenticatedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome, ${state.user.displayName}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(SignOutEvent());
                  },
                  child: const Text('Sign Out'),
                ),
              ],
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(SignInWithGoogleEvent());
                },
                child: Text('Sign In with Google'),
              ),
            );
          }
        },
      ),
    );
  }
}
