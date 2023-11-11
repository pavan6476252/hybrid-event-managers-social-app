import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hybrid/bloc/auth/auth_bloc.dart';

import 'package:hybrid/theme/t_constants.dart';
import 'package:hybrid/utils/app_asset_const.dart';
import 'package:hybrid/utils/components/background_illustration.dart';
import 'package:hybrid/utils/components/buttons.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatefulWidget {
  static String pathRoute = '/login-view';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        BackGroundIllustrations.backGroundIllustration(
            context: context, top: MediaQuery.of(context).size.height * 0.6),
        BackGroundIllustrations.backGroundIllustration(
            context: context,
            top: -MediaQuery.of(context).size.height * 0.1,
            left: -MediaQuery.of(context).size.width * 1.5),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _headerPart(),
              _loginButtons(context),
              _footerPart(),
            ],
          ),
        )
      ]),
    );
  }

  _headerPart() {
    // Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppAssetConstants.loginSvg,
          width: 311,
          height: 311,
        ),
        Text(
          "Welcome to",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          "HyBrid",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  _footerPart() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: RichText(
            textAlign: TextAlign.center, // Center-align the text horizontally

            text: TextSpan(
              text: "By tapping 'Register' you agree to our\n",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w100,
                    color: AppColorConstants.gray,
                  ),
              children: [
                TextSpan(
                  text: 'Terms of Use',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColorConstants.blueAccent,
                      ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColorConstants.blueAccent,
                      ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  _loginButtons(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthLoadingCancelled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Cancelled"),
            backgroundColor: Colors.amber,
          ),
        );
      }
      if (state is AuthenticationError) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Eorr"),
          backgroundColor: Colors.redAccent,
        ));
      }
    }, builder: (context, state) {
      return Column(
        children: [
          CustomButtons.flatButton(
            onTap: () {
              BlocProvider.of<AuthBloc>(context).add(SignInWithGooglePressed());
            },
            bgColor: AppColorConstants.tomatoAccent,
            padding: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    Ionicons.logo_google,
                    color: AppColorConstants.white,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Text(
                          'Continue with Google',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18,
                                    color: AppColorConstants.white,
                                  ),
                        ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          CustomButtons.flatButton(
            onTap: () {},
            bgColor: AppColorConstants.black,
            padding: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                    (Ionicons.logo_facebook),
                    color: AppColorConstants.white,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Continue with Facebook',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 18,
                          color: AppColorConstants.white,
                        ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
    });
  }
}
