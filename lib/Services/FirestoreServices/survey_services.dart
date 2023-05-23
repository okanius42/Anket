import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");

  Future<void> addSurvey(
      bool check, String topic, String explain, List list) async {
    QuerySnapshot surveyCollection =
        await _firebaseFirestore.collection("Surveys").get();
    int surveyCount = (surveyCollection.size) + 1;

    DocumentSnapshot userDocument = await _userReference
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    var i = userDocument.get("id");

    List myList = List.generate(
        list.length,
        (index) => {
              "title": list[index]["title"],
              "number": list[index]["value"] == true ? 1 : 0
            });

    var ref =
        _firebaseFirestore.collection("Surveys").doc(surveyCount.toString());
    var surveyAdd = ref.set(
      {
        'Bool': check,
        'Topic': topic,
        'Explain': explain,
        'User-ID': i,
        "list": myList
      },
    );
    return surveyAdd;
  }

  Future<void> uploadAnswer(List list) async {
    DocumentSnapshot userDocument = await _userReference
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    QuerySnapshot surveyCollection =
        await _firebaseFirestore.collection("Surveys").get();
    int surveyCount = (surveyCollection.size) + 1;
    var userId = userDocument.get("id");
    List myList = List.generate(list.length, (index) => list[index]["value"]);
    var ref = _firebaseFirestore
        .collection("Surveys")
        .doc(surveyCount.toString())
        .collection("Answers")
        .doc(0.toString());
    ref.set({'Answers': myList, 'User-ID': userId});
  }

  Stream<QuerySnapshot> getAllSurvey() {
    return _firebaseFirestore.collection("Surveys").snapshots();
  }

  getSurveyAmount() async {
    QuerySnapshot surveyQuery =
        await _firebaseFirestore.collection("Surveys").get();
    return surveyQuery.docs.map((e) => e.data()).toList(growable: true).length;
  }
}
