import 'package:flutter/material.dart';
import 'package:note_app/screens/home_page_screen.dart';
class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> register;
  final ValueNotifier<bool> isLoading;
  final dynamic auth;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final TextEditingController controllerName;
  final ThemeData getTheme;

  const LoginButton({super.key, 
    required this.formKey,
    required this.register,
    required this.isLoading,
    required this.auth,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.controllerName,
    required this.getTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: const Color.fromARGB(255, 93, 172, 236)),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              isLoading.value = true;
              if (register.value) {
                await auth
                    .signupwithEmail(
                        controllerEmail.text,
                        controllerPassword.text,
                        controllerName.text)
                    .then((val) {
                  register.value = false;
                });
              } else {
                await auth
                    .signIn(controllerEmail.text, controllerPassword.text)
                    .then((onValue) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()),
                  );
                });
              }
              isLoading.value = false;
            }
          },
          child: isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  register.value ? 'Sign up' : 'Log in',
                  style: getTheme.textTheme.labelMedium!
                      .copyWith(fontSize: 18, color: Colors.white),
                ),
        ),
      ),
    );
  }
}