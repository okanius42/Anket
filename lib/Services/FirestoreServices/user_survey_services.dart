import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSurveyServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");

  Future<List<Map<String, dynamic>>> getSurveyList() async {
    DocumentSnapshot userDocument = await _userReference
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    var i = userDocument.get("id");

    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection("Surveys").get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> list = [];
    for (int index = 0; index < allData.length; index++) {
      Map<String, dynamic> map = allData[index] as Map<String, dynamic>;
      if (i == map["User-ID"]) {
        list.add(map);
      }
    }
    return list;
  }

  Future<List<Map<String, dynamic>>> getAnswerList() async {
    DocumentSnapshot userDocument = await _userReference
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get();
    var userId = userDocument.get("id");
    QuerySnapshot surveySnapshot =
        await _firebaseFirestore.collection("Surveys").get();
    final surveyData = surveySnapshot.docs.map((doc) => doc.data()).toList();
    int surveyAmount = surveyData.length;
    List<Map<String, dynamic>> list = [];

    for (int index = 0; index < surveyAmount; index++) {
      QuerySnapshot answerSnapshot = await _firebaseFirestore
          .collection("Surveys")
          .doc((index + 1).toString())
          .collection("Answers")
          .get();
      Map<String, dynamic> surveyMap =
          surveyData[index] as Map<String, dynamic>;
      final answerData = answerSnapshot.docs.map((doc) => doc.data()).toList();
      int answerAmount = answerData.length;
      for (int indexAnswer = 0; indexAnswer < answerAmount; indexAnswer++) {
        Map<String, dynamic> answerMap =
            answerData[indexAnswer] as Map<String, dynamic>;
        if (userId == answerMap["User-ID"]) {
          list.add(surveyMap);
        }
      }
    }
    print("Answer Data = $list");
    return list;
  }
}
