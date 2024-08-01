import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class AuthRiverpod extends StateNotifier<User?> {
  AuthRiverpod(this._firebaseAuth) : super(_firebaseAuth.currentUser) {
    _firebaseAuth.authStateChanges().listen((user) {
      state = user;
    });
  }
  final FirebaseAuth _firebaseAuth;
  static List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  Future<void> signupwithEmail(
      String email, String password, String name) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await state!.updateProfile(displayName: name);
      // Tải lại thông tin người dùng để đảm bảo các thay đổi đã được áp dụng
      await state!.reload();
      // Cập nhật trạng thái với người dùng đã tải lại
      state = FirebaseAuth.instance.currentUser;
      print('Successfully signed up with email link!');
    } catch (e) {
      // ignore: avoid_print
      print('Error : $e');
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final idToken = await state?.getIdToken();
      print(idToken);
      print('Successfully signed in with email link!');
    } catch (e) {
      // ignore: avoid_print
      print('Error : $e');
    }
    return null;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return Future.error('Đăng nhập bị hủy bỏ');
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

// login with facebook
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
    print('test : $facebookAuthCredential');
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final authDataSourceProvider = StateNotifierProvider<AuthRiverpod, User?>(
  (ref) => AuthRiverpod(ref.read(firebaseAuthProvider)),
);
