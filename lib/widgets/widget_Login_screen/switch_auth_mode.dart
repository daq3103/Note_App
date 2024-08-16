import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SwitchAuthMode extends StatelessWidget {
  final ValueNotifier<bool> register;

  const SwitchAuthMode({super.key, 
    required this.register,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: register.value
                  ? "Already have an account? "
                  : "Don't have an account?",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            TextSpan(
              text: register.value ? "Log in" : ' Sign up',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  register.value = !register.value;
                },
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}