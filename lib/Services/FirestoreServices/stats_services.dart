import 'package:cloud_firestore/cloud_firestore.dart';

class StatsService {
  final CollectionReference _surveyReference =
      FirebaseFirestore.instance.collection("Surveys");
  getSurveyStats() async {
    QuerySnapshot querySnapshot = await _surveyReference.get();
    final surveyData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    return surveyData.length;
  }

  final CollectionReference _answersReference =
      FirebaseFirestore.instance.collection("Surveys");
  getAnswerStats() async {
    QuerySnapshot querySnapshot = await _answersReference.get();
    final allData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    int i = allData.length;
    return i;
  }

  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");
  getUserStats() async {
    QuerySnapshot querySnapshot = await _userReference.get();
    final allData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    return allData.length;
  }
}
