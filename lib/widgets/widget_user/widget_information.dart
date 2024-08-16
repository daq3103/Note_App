import 'package:flutter/material.dart';
import 'package:note_app/riverpod/note/note_riverpod.dart';
import 'package:note_app/riverpod/note/theme_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WidgetInfor extends ConsumerWidget {
  const WidgetInfor(
      {super.key,
      required this.iconIf,
      required this.textIf,
      required this.selectIf});
  final IconData iconIf;
  final String textIf;
  final void Function(BuildContext context, NoteNotifier notifier) selectIf;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    final notifier = ref.read(noteNotifierProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          selectIf(context , notifier);
        },
        child: Row(
          children: [
            Icon(
              iconIf,
              size: 40,
            ),
            const SizedBox(width: 60),
            Text(
              textIf,
              style: theme.textTheme.bodyLarge!.copyWith(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
