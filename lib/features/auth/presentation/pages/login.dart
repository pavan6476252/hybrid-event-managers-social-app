import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hybrid/features/auth/presentation/bloc/auth_bloc.dart';  

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const FlutterLogo(size: 150.0),
            const SizedBox(height: 32.0),
            OutlinedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(SignInWithGoogleEvent());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/svg/login_svg.svg', height: 20.0),
                  const SizedBox(width: 8.0),
                  const Text('Sign in with Google'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
