import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note_app/riverpod/note/note_db.dart';
import 'package:note_app/screens/home_page_screen.dart';
import 'package:note_app/screens/new_note.dart';
import 'package:note_app/riverpod/note/theme_manager.dart';
import 'package:note_app/screens/auth_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseHelper = DatabaseHelper();
  await databaseHelper.initDatabase();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);
    return MaterialApp(
      title: 'Note App',
      theme: theme,
      routes: <String, WidgetBuilder>{
        '/contentScreen': (BuildContext context) {
          return ContentScreen();
        },
        '/home' : (BuildContext context) {
          return const HomePage();
        }
      },
      home: const LoginScreen(),
    );
  }
}
