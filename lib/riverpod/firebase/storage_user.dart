import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class SaveUserNotifier extends StateNotifier<User?> {
  SaveUserNotifier(this._firebaseAuth) : super(_firebaseAuth.currentUser) {
    _firebaseAuth.authStateChanges().listen((user) {
      state = user;
      print(state);
      if (user != null) {
        final myUser = MyUser(
          uid: user.uid,
          name: user.displayName ?? '',
          image: user.photoURL ?? '',
        );
        _saveUserToFirestore(myUser); // Save myUser data to Firestore
      }
    });
  }

  final FirebaseAuth _firebaseAuth; 
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> _saveUserToFirestore(MyUser myUser) async {
    try {
      await _firestore.collection("users").doc(myUser.uid).set({
        'uid': myUser.uid,
        'name': myUser.name,
        'image': myUser.image,
      });
      print('User data saved to Firestore');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<void> updateUser({String? newName, File? newImage}) async {
    try {
      String? downloadURL;

      // Check if there is a new image, if so, upload it to Firebase Storage
      if (newImage != null) {
        downloadURL = await _uploadImageToStorage(newImage);
      }

      // Update user information on Firebase Authentication
      if (state != null) {
        await state!.updateProfile(
          displayName: newName ?? state!.displayName,
          photoURL: downloadURL ?? state!.photoURL,
        );
        await state!.reload(); // Reload user information to apply changes
        state = _firebaseAuth.currentUser;

        // Update information on Firestore
        final updatedUser = MyUser(
          uid: state!.uid,
          name: state!.displayName ?? '',
          image: state!.photoURL ?? '',
        );
        await _saveUserToFirestore(updatedUser);
        print('User updated successfully');
      }
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  Future<File?> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      File file = File(image.path);
      if (state != null) {
        try {
          // Upload image to Firebase Storage
          String downloadURL = await _uploadImageToStorage(file);

          // Update Firebase user's profile with the new photo URL
          await state!.updateProfile(photoURL: downloadURL);
          await state!.reload(); // Reload the user to reflect the changes
          state =
              _firebaseAuth.currentUser; 
          // Update MyUser and save to Firestore
          final myUser = MyUser(
            uid: state!.uid,
            name: state!.displayName ?? '',
            image: downloadURL,
          );
          await _saveUserToFirestore(myUser);
        } catch (e) {
          print('Error during photo upload and update: $e');
        }
      }
      return file;
    }
    return null;
  }

  Future<String> _uploadImageToStorage(File file) async {
    try {
      // Create a unique file name for the image
      String fileName = 'user_images/${_firebaseAuth.currentUser!.uid}.jpg';
      print('Uploading file to: $fileName'); // In ra đường dẫn tệp

      // Upload the file to Firebase Storage
      TaskSnapshot snapshot =
          await _firebaseStorage.ref(fileName).putFile(file);
      if (snapshot.state == TaskState.success) {
        String downloadURL = await snapshot.ref.getDownloadURL();
        print(
            'File uploaded successfully. Download URL: $downloadURL'); // In ra URL tải về
        return downloadURL;
      } else {
        throw FirebaseException(
          plugin: 'firebase_storage',
          message: 'File upload failed',
        );
      }
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }
}

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final saveUserNotifierProvider = StateNotifierProvider<SaveUserNotifier, User?>(
  (ref) => SaveUserNotifier(ref.read(firebaseAuthProvider)),
);
