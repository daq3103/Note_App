import 'package:flutter/material.dart';
import 'package:note_app/widgets/widget_user/login_icon.dart';
class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> register;
  final TextEditingController controllerName;
  final TextEditingController controllerEmail;
  final TextEditingController controllerPassword;
  final ThemeData getTheme;

  const LoginForm({super.key, 
    required this.formKey,
    required this.register,
    required this.controllerName,
    required this.controllerEmail,
    required this.controllerPassword,
    required this.getTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (register.value)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: getTheme.textTheme.titleMedium!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  LoginIcon(
                      iconform: const Icon(Icons.person),
                      hintTextForm: 'Enter your name',
                      controler: controllerName)
                ],
              ),
            ),
          Text(
            'Email',
            style: getTheme.textTheme.titleMedium!
                .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          LoginIcon(
              iconform: const Icon(Icons.email),
              hintTextForm: 'Enter your email',
              controler: controllerEmail),
          const SizedBox(height: 20),
          Text(
            'Password',
            style: getTheme.textTheme.titleMedium!
                .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          LoginIcon(
              iconform: const Icon(Icons.person),
              hintTextForm: 'Enter your password',
              controler: controllerPassword),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 50),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  register.value ? '' : 'Forgot password',
                  style: getTheme.textTheme.bodySmall!
                      .copyWith(color: const Color.fromARGB(255, 54, 149, 226)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
