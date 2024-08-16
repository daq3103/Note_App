import 'dart:io';

class MyUser {
  String uid;
  String name;
  String image;

  // Updated constructor to accept 'uid'
  MyUser({required this.uid , required this.name , required this.image});

  // Method to update user information
  void updateInforUser({String? nameU, int? ageU, String? imageU}) {
    if (nameU != null) {
      name = nameU;
    }
    if (imageU != null) {
      image = imageU;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'image': image,
    };
  }
}
