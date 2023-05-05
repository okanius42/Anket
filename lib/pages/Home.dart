import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:survey/Drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("Surveys");
  getData() async {
    QuerySnapshot querySnapshot = await _collectionReference.get();
    final allData =
        querySnapshot.docs.map((e) => e.data()).toList(growable: true);
    print('All Data = $allData');
    int i = allData.length;
    print('Lenght of All Data = $i');
    return i;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.width * .02361111066),
            child: Container(
              height: size.height * .58,
              width: size.width * .85,
              child: Padding(
                padding: EdgeInsets.only(top: height * .06105736876),
                child: Column(
                  children: [
                    InkWell(
                      child: const Text('Get Data'),
                    ),
                    FutureBuilder(
                        future: getData(),
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString());
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        drawer: drawerBuild());
  }
}
