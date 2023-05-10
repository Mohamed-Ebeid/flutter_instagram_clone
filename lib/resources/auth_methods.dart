import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';
import 'package:instagram_flutter/models/user.dart' as userModel;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //Singup a user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoURL = await StorageMethods()
            .uploadingImageToStorage('profilePics', file, false);

        userModel.User user = userModel.User(
            username: username,
            uid: cred.user!.uid, //! means it can't be null
            photoUrl: photoURL,
            email: email,
            bio: bio,
            followers: [],
            following: []);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = 'Success!';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Login a user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error accurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success!";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Getting user info
  Future<userModel.User> getUserInfo() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return userModel.User.fromSnap(snap);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
