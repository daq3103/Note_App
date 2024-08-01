import 'package:flutter/material.dart';
import 'package:flutter_application_1/riverpod/note/note_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SvgLogin extends ConsumerWidget {
  const SvgLogin({super.key, required this.svgLink, required this.onPressedLogin});
  final String svgLink;
  final void Function(BuildContext context, NoteNotifier notifier) onPressedLogin;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final notifier = ref.watch(noteNotifierProvider.notifier);
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromARGB(31, 95, 62, 62),
      ),
      child: InkWell(
          onTap: () {
            onPressedLogin(context , notifier);
          },
          child: SvgPicture.asset(
            svgLink,
          )),
    );
  }
}
