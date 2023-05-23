import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> ageUpdate(DateTime birthday, int age) {
    final User? user = _firebaseAuth.currentUser;
    final email = user?.email;
    var ref = _firebaseFirestore.collection("Users").doc(email).update({
      'year': birthday.year,
      'month': birthday.month,
      'day': birthday.day,
      'age': age,
    });
    return ref;
  }

  Future<void> nameUpdate(String name) {
    final User? user = _firebaseAuth.currentUser;
    final email = user?.email;
    var ref = _firebaseFirestore
        .collection("Users")
        .doc(email)
        .update({'name': name});
    return ref;
  }

  Future<void> surnameUpdate(String surname) {
    final User? user = _firebaseAuth.currentUser;
    final email = user?.email;
    var ref = _firebaseFirestore
        .collection("Users")
        .doc(email)
        .update({'surname': surname});
    return ref;
  }

  Stream<DocumentSnapshot> getUserInfo() {
    return _firebaseFirestore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.email)
        .snapshots();
  }

  String? getUid() {
    final User? user = _firebaseAuth.currentUser;
    final uid = user?.uid;
    return uid;
  }

  String? getEmail() {
    final User? user = _firebaseAuth.currentUser;
    final email = user?.email;
    return email;
  }
}
