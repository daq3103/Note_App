import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/login_sreen/auth_riverpod.dart';
import 'package:flutter_application_1/riverpod/theme_manager.dart';
import 'package:flutter_application_1/widgets/widget_Login_screen.dart/infor_form.dart';
import 'package:flutter_application_1/widgets/widget_Login_screen.dart/login_svg.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginSreen extends HookConsumerWidget {
  const LoginSreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register = useState<bool>(false);
    final getTheme = ref.watch(themeNotifierProvider);
    final GlobalKey<FormState> formKey = GlobalKey();
    final controllerName = useTextEditingController();
    final controllerEmail = useTextEditingController();
    final controllerPassword = useTextEditingController();
  //  final auth = ref.read(authDataSourceProvider.notifier);
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(top: 100, bottom: 30, right: 20, left: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(register.value == false ? 'Log in' : 'Sign up',
              style: getTheme.textTheme.titleLarge!.copyWith(fontSize: 32)),
          Opacity(
            opacity: 0.5,
            child: Text('Please enter your details !',
                style: getTheme.textTheme.titleSmall!.copyWith(fontSize: 16)),
          ),
          const SizedBox(height: 20),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// display name if sign in
                if (register.value)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: getTheme.textTheme.titleMedium!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        LoginForm(
                            iconform: const Icon(Icons.person),
                            hintTextForm: 'Enter your name',
                            controler: controllerName)
                      ],
                    ),
                  ),
// display Email Form
                Text(
                  'Email',
                  style: getTheme.textTheme.titleMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                LoginForm(
                    iconform: const Icon(Icons.email),
                    hintTextForm: 'Enter your email',
                    controler: controllerEmail),
                const SizedBox(height: 20),
                Text(
                  'Password',
                  style: getTheme.textTheme.titleMedium!
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
// display Password Form
                LoginForm(
                    iconform: const Icon(Icons.person),
                    hintTextForm: 'Enter your password',
                    controler: controllerPassword),
// forgot password
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 50),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        register.value ? '' : 'Forgot password',
                        style: getTheme.textTheme.bodySmall!.copyWith(
                            color: const Color.fromARGB(255, 54, 149, 226)),
                      ),
                    ],
                  ),
                ),
// button login
                Center(
                    child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor:
                              const Color.fromARGB(255, 93, 172, 236)),
                      onPressed: () {
                        // if (formKey.currentState!.validate()) {
                        //   if (register.value) {
                        //     auth.signupwithEmail(
                        //         controllerEmail.text, controllerPassword.text);
                        //   } else {
                        //     auth.signIn(
                        //         controllerEmail.text, controllerPassword.text);
                        //   }
                        // }
                      },
                      child: Text(
                        register.value ? 'Sign up' : 'Log in',
                        style: getTheme.textTheme.labelMedium!
                            .copyWith(fontSize: 18, color: Colors.white),
                      )),
                )),
              ],
            ),
          ),
// line
          const Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Or log in with'),
              ),
              Expanded(
                child: Divider(
                  color: Colors.black,
                  height: 36,
                ),
              ),
            ],
          ),
// icon
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgLogin(svgLink: 'assets/svg/google.svg'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SvgLogin(svgLink: 'assets/svg/apple.svg'),
              ),
              SvgLogin(svgLink: 'assets/svg/facebook.svg'),
            ],
          ),
          const Spacer(),
//
          Center(
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
          )),
        ]),
      ),
    );
  }
}
