import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey/User/Login.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //Sign IN Method
  Future<User?> signIN(String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user;
  }

  //Sign Out Method
  signOut(BuildContext context) async {
    return await _firebaseAuth.signOut().then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  auth() async {
    return await _firebaseAuth.currentUser?.sendEmailVerification();
  }

  //Register Method
  Future<User?> signUp(String username, String email, String password) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    QuerySnapshot productCollection =
        await _firebaseFirestore.collection('Users').get();
    int productCount = (productCollection.size) + 1;
    await _firebaseFirestore.collection("Users").doc(email).set({
      "username": username,
      "email": email,
      "id": productCount,
    });
    return user.user;
  }

  Future updateProfile(String displayName) async {
    User? user = _firebaseAuth.currentUser;
    var display = await user?.updateDisplayName(displayName);
    return display;
  }
}

class AuthState {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();
  Future<String?> getCurrentUID() async {
    return _firebaseAuth.currentUser?.uid;
  }
}
