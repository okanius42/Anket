import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> surveyAdd(
      bool bool, String topic, String explain, List<String> list) async {
    QuerySnapshot productCollection =
        await _firebaseFirestore.collection('Surveys').get();
    int productCount = (productCollection.size) + 1;
    var ref =
        _firebaseFirestore.collection("Surveys").doc(productCount.toString());
    var surveyAdd = ref.set({
      'user-id': 0,
      'bool': bool,
      'topic': topic,
      'explain': explain,
      'list': list,
      'id': productCount
    });
    return surveyAdd;
  }

  Future<void> userUpdate(
      DateTime birthday, int age, String name, String surname) {
    final User? user = _firebaseAuth.currentUser;
    final email = user?.email;
    var ref = _firebaseFirestore.collection("Users").doc(email).update({
      'year': birthday.year,
      'month': birthday.month,
      'day': birthday.day,
      'age': age,
      'name': name,
      'surname': surname
    });
    return ref;
  }

  Stream<QuerySnapshot> getSurvey() {
    var ref = _firebaseFirestore.collection("Surveys").snapshots();
    return ref;
  }

  Stream<DocumentSnapshot> FieldStream() {
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

class StatsService {
  final CollectionReference _surveyReference =
      FirebaseFirestore.instance.collection("Surveys");
  getSurveyData() async {
    QuerySnapshot querySnapshot = await _surveyReference.get();
    final allData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    int i = allData.length;
    return i;
  }

  final CollectionReference _answerReference =
      FirebaseFirestore.instance.collection("Answers");
  getAnswerData() async {
    QuerySnapshot querySnapshot = await _answerReference.get();
    final allData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    int i = allData.length;
    return i;
  }

  final CollectionReference _usersReference =
      FirebaseFirestore.instance.collection("Users");
  getUserData() async {
    QuerySnapshot querySnapshot = await _usersReference.get();
    final allData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    int i = allData.length;
    return i;
  }
}
