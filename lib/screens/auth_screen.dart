import 'package:flutter/material.dart';
import 'package:note_app/riverpod/login/auth_riverpod.dart';
import 'package:note_app/riverpod/note/theme_manager.dart';
import 'package:note_app/screens/home_page_screen.dart';
import 'package:note_app/widgets/widget_Login_screen/divider_with_text.dart';
import 'package:note_app/widgets/widget_Login_screen/login_form.dart';
import 'package:note_app/widgets/widget_Login_screen/login_button.dart';
import 'package:note_app/widgets/widget_Login_screen/social_login.dart';
import 'package:note_app/widgets/widget_Login_screen/switch_auth_mode.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final register = useState<bool>(false);
    final isLoading = useState<bool>(false);
    final getTheme = ref.watch(themeNotifierProvider);
    final GlobalKey<FormState> formKey = GlobalKey();
    final controllerName = useTextEditingController();
    final controllerEmail = useTextEditingController();
    var controllerPassword = useTextEditingController();
    final auth = ref.read(authDataSourceProvider.notifier);

    Future<void> checkLogin() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      if (token != null) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    }

    useEffect(() {
      controllerName.text = '';
      controllerPassword.text = '';
      controllerEmail.text = '';
      checkLogin();
      return null;
    });

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 100, bottom: 30, right: 20, left: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(register.value == false ? 'Log in' : 'Sign up',
                style: getTheme.textTheme.titleLarge!.copyWith(fontSize: 32)),
            Opacity(
              opacity: 0.5,
              child: Text('Please enter your details !',
                  style: getTheme.textTheme.titleSmall!.copyWith(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            LoginForm(
              formKey: formKey,
              register: register,
              controllerName: controllerName,
              controllerEmail: controllerEmail,
              controllerPassword: controllerPassword,
              getTheme: getTheme,
            ),
            LoginButton(
              formKey: formKey,
              register: register,
              isLoading: isLoading,
              auth: auth,
              controllerEmail: controllerEmail,
              controllerPassword: controllerPassword,
              controllerName: controllerName,
              getTheme: getTheme,
            ),
            const DividerWithText(),
            SocialLogin(auth: auth, isLoading: isLoading),
            const Spacer(),
            SwitchAuthMode(register: register),
          ]),
        ),
      ),
    );
  }
}
