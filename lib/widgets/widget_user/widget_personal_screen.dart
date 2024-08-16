import 'package:flutter/material.dart';
import 'package:note_app/riverpod/note/theme_manager.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyInformation extends HookConsumerWidget {
  const MyInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final getTheme = ref.watch(themeNotifierProvider);
    final nameController = useTextEditingController();
    final ageController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact info',
            style: getTheme.textTheme.labelLarge!.copyWith(fontSize: 32)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextFormField(
                  style: getTheme.textTheme.bodyLarge!.copyWith(fontSize: 32),
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  minLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 86),
                child: TextFormField(
                  style: getTheme.textTheme.bodyLarge!.copyWith(fontSize: 32),
                  controller: ageController,
                  decoration: const InputDecoration(
                    hintText: 'Age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    return null;
                  },
                  maxLines: null,
                  minLines: 1,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final String name = nameController.text;
                        final String age = ageController.text;
                        print(age);
                      }
                    },
                    child: const Text('Oke')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
