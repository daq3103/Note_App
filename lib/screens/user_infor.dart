import 'package:note_app/riverpod/firebase/storage_user.dart';
import 'package:note_app/riverpod/login/auth_riverpod.dart';
import 'package:note_app/screens/auth_screen.dart';
import 'package:note_app/widgets/widget_user/widget_information.dart';
import 'package:note_app/widgets/widget_user/widget_personal_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

class UserInfor extends ConsumerStatefulWidget {
  const UserInfor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInforState();
}

class _UserInforState extends ConsumerState<UserInfor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetInfor(
          iconIf: Icons.person,
          textIf: 'Avatar',
          selectIf: (context, notifier) {
            ref.read(saveUserNotifierProvider.notifier).takePhoto();
          },
        ),
        WidgetInfor(
            iconIf: Icons.info_sharp,
            textIf: 'Information',
              selectIf: (context, notifier) => Navigator.push(context, MaterialPageRoute(builder: (context) => const MyInformation()))),
        WidgetInfor(
          iconIf: Icons.chat,
          textIf: 'AI-Chat',
          selectIf: (context, notifier) {},
        ),
// log out   
        WidgetInfor(
          iconIf: Icons.logout,
          textIf: 'Log Out',
          selectIf: (context, notifier) {
            ref
                .read(authDataSourceProvider.notifier)
                .signOut()
                .then((value) {
                 Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
                });
          },
        ),
      ],
    );
  }
}
