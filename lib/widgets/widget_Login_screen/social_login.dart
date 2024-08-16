import 'package:flutter/material.dart';
import 'package:note_app/screens/home_page_screen.dart';
import 'package:note_app/widgets/widget_Login_screen/login_svg.dart';

class SocialLogin extends StatelessWidget {
  final dynamic auth;
  final ValueNotifier<bool> isLoading;

  const SocialLogin({
    required this.auth,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgLogin(
            svgLink: 'assets/svg/google.svg',
            onPressedLogin: (context, notifier) async {
              isLoading.value = true;
              await auth.signInWithGoogle().then((onValue) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage()), 
                  (route) => false,
                );
              });
              isLoading.value = false;
            }),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SvgLogin(
            svgLink: 'assets/svg/apple.svg',
            onPressedLogin: (context, notifier) {},
          ),
        ),
        SvgLogin(
          svgLink: 'assets/svg/facebook.svg',
          onPressedLogin: (context, notifier) async {
            isLoading.value = true;
            await auth.signInWithFacebook();
            isLoading.value = false;
          },
        ),
      ],
    );
  }
}