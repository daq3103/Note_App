import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginForm extends HookWidget {
  const LoginForm({
    super.key,
    required this.iconform,
    required this.hintTextForm,
    required this.controler,
  });

  final Icon iconform;
  final String hintTextForm;
  final TextEditingController controler;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controler,
      decoration: InputDecoration(
        prefixIcon: iconform,
        border: const OutlineInputBorder(),
        hintText: hintTextForm,
      ),
    );
  }
}
