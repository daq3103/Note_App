// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class AuthRiverpod extends StateNotifier<User?> {
//   AuthRiverpod(this._firebaseAuth) : super(_firebaseAuth.currentUser) {
//     _firebaseAuth.authStateChanges().listen((user) {
//       state = user;
//     });
//   }
//   final FirebaseAuth _firebaseAuth;
//   Future<UserCredential?> signupwithEmail(String email, String password) async {
//     try {
//       final userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       state = userCredential.user;
//       final idToken = state?.getIdToken();
//       print('Successfully signed up with email link!');
//       print('ID Token: $idToken');
//     } catch (e) {
//       // ignore: avoid_print
//       print('Error : $e');
//     }
//     return null;
//   }

//   Future<UserCredential?> signIn(String email, String password) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       state = userCredential.user;
//       print(state!.getIdToken().toString());
//         print('Successfully signed in with email link!');
//     } catch (e) {
//       print('Error : $e');
//     }
//   }
// }
// final firebaseAuthProvider =
//     Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
// final authDataSourceProvider = StateNotifierProvider<AuthRiverpod , User?>(
//   (ref) => AuthRiverpod(ref.read(firebaseAuthProvider)),
// );