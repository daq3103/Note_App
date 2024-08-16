import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRiverpod extends StateNotifier<User?> {
  AuthRiverpod(this._firebaseAuth) : super(_firebaseAuth.currentUser) {
    _firebaseAuth.authStateChanges().listen((user) {
      state = user;
    });
  }
  final FirebaseAuth _firebaseAuth;
  Future<void> saveLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final idToken = await state!.getIdToken();
      await prefs.setString('token', idToken.toString());
    } catch (e) {
      print('Error : $e');
    }
  }

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

  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final idToken = await state?.getIdToken();
      print(idToken);
      saveLogin();
      print('Successfully signed in with email link!');
    } catch (e) {
      // ignore: avoid_print
      print('Error : $e');
    }
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
    saveLogin();
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

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
