import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnswerService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection("Users");

  Future<void> answer(List list, int surveyId) async {
    QuerySnapshot answerCollection = await _firebaseFirestore
        .collection("Surveys")
        .doc(surveyId.toString())
        .collection("Answers")
        .get();
    int answerCount = (answerCollection.size) + 1;
    List myList =
        List.generate(list.length, (index) => {"Value": list[index]["value"]});
    Map<String, dynamic> map = {};
    final userDocs = _firebaseFirestore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.email);
    userDocs.get().then((DocumentSnapshot value) {
      map = value.data() as Map<String, dynamic>;
      var ref = _firebaseFirestore
          .collection("Surveys")
          .doc(surveyId.toString())
          .collection("Answers")
          .doc(answerCount.toString());
      var answerAdd = ref.set(
          {"User-ID": map["id"], "Answers": myList, "Survey-ID": surveyId});
      return answerAdd;
    }, onError: (e) => print("Error getting document : $e"));
  }
}
