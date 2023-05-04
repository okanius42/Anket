import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:survey/Services/Firestore_services.dart';

import '../../Drawer.dart';

class Surveys extends StatefulWidget {
  const Surveys({Key? key}) : super(key: key);

  @override
  State<Surveys> createState() => _SurveysState();
}

class _SurveysState extends State<Surveys> {
  final FirestoreService _firestoreService = FirestoreService();
  final ScrollController _scrollController = ScrollController();
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
            child: Column(
              children: [
                Image.asset('assets/survey.png'),
                Container(
                  height: size.height * .70,
                  width: size.width * .95,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(12)),
                  child: StreamBuilder(
                    stream: _firestoreService.getSurvey(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(
                              child: SizedBox(
                                width: size.width * .2,
                                height: height * .10343836784,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.black),
                                ),
                              ),
                            )
                          : Scrollbar(
                              controller: _scrollController,
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot survey =
                                      snapshot.data!.docs[index];
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.black.withOpacity(.5),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * .02361111066,
                                          top: height * .000001),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: size.width * .8,
                                              height: height * .08,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Topic:${survey["topic"]}'),
                                                  SizedBox(
                                                    height: height * .005,
                                                  ),
                                                  Text(
                                                      'Explain:${survey["explain"]}'),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: drawerBuild());
  }
}
