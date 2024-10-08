import 'package:flutter/material.dart';
import 'package:note_app/riverpod/firebase/storage_user.dart';
import 'package:note_app/riverpod/note/theme_manager.dart';
import 'package:note_app/screens/user_infor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBarHomeSreen extends HookConsumerWidget
    implements PreferredSizeWidget {
  const AppBarHomeSreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =
        ref.watch(themeNotifierProvider); // Đọc theme từ ThemeNotifier
    final note = ref.watch(saveUserNotifierProvider);
    return AppBar(
      toolbarHeight: 70,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(21, 0, 0, 0),
        child: Row(
          children: [
// title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// text appbar
                Text(
                  "Note.d",
                  style: theme.textTheme.titleLarge!.copyWith(fontSize: 32),
                ),
                Text(
                  "Enjoy note taking with friends",
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 18),
                ),
              ],
            ),
            const Spacer(),

// avatar
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => const UserInfor(),
                );
              },
              child: CircleAvatar(
                radius: 30,
                backgroundImage: note?.photoURL != null
                    ? NetworkImage(
                        note!.photoURL.toString(),
                      )
                    : const AssetImage(
                        "assets/images/avt.png",
                      ) as ImageProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
