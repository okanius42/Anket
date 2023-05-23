import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class asdasd extends StatefulWidget {
  const asdasd({Key? key}) : super(key: key);

  @override
  State<asdasd> createState() => _asdasdState();
}

class _asdasdState extends State<asdasd> {
  final userSurveyServices services = userSurveyServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: InkWell(
      onTap: () {
        services.getSurvey();
      },
      child: Container(
          width: 250,
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: const Center(
            child: Text(
              'Try',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          )),
    )));
  }
}

class userSurveyServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  getSurvey() async {
    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection("Surveys").get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    for (int index = 0; index < allData.length; index++) {
      Map<String, dynamic> map = allData[index] as Map<String, dynamic>;
      var id = map["User-ID"];
      if (9 == id) {}
      print('List of All Data = $map and id= $id');
    }
    print('allData = $allData');
  }
}
