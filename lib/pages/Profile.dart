import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey/Services/Auth_Services.dart';
import 'package:survey/Services/FirestoreServices/user_services.dart';
import 'package:survey/Services/FirestoreServices/user_survey_services.dart';
import 'package:survey/pages/Settings/Settings.dart';

import '../Drawer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int surveyAmount = 5;
  int answerAmount = 8;
  String topic = '';
  String explain = '';
  int _selectedIndex = 0;
  AuthService authService = AuthService();
  UserService userService = UserService();
  UserSurveyServices userSurveyServices = UserSurveyServices();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    final List<Widget> _widgetOptions = <Widget>[
      SizedBox(
        width: size.width * .95,
        child: FutureBuilder(
          future: userSurveyServices.getSurveyList(),
          builder: (context, snapshot) {
            List<Map<String, dynamic>>? surveyList = snapshot.data;
            return !snapshot.hasData
                ? Center(
                    child: SizedBox(
                      width: size.width * .25,
                      height: height * .125,
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ListView.builder(
                      itemCount: surveyList!.length,
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: height * .01),
                            child: InkWell(
                              onTap: () {},
                              child: SizedBox(
                                width: size.width * .9,
                                height: height * .05,
                                child: Center(
                                  child: Text(surveyList![index]['Topic']),
                                ),
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
      FutureBuilder(
        future: userSurveyServices.getAnswerList(),
        builder: (context, snapshot) {
          List<Map<String, dynamic>>? surveyList = snapshot.data;

          return !snapshot.hasData
              ? Center(
                  child: SizedBox(
                    width: size.width * .25,
                    height: height * .125,
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                )
              : Scrollbar(
                  thumbVisibility: true,
                  controller: _scrollController,
                  child: ListView.builder(
                    itemCount: surveyList!.length,
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: height * .01),
                          child: InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: size.width * .9,
                              height: height * .05,
                              child: Center(
                                child: Text(surveyList![index]['Topic']),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      )
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: height * .03052868438,
                  left: size.width * .017708333,
                  right: size.width * .017708333),
              height: height * .07,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: Colors.black, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: size.width * .04722222133),
                      width: size.width * .66111109874,
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: userService.getUserInfo(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading");
                          }
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          print('Data of Firebase: $data');
                          return Text(data['username']);
                        },
                      )),
                  Container(
                    margin: EdgeInsets.only(top: height * .005),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Anket'),
                        FutureBuilder(
                            future: userSurveyServices.getSurveyList(),
                            builder: (context, snapshot) {
                              List<Map<String, dynamic>>? surveyList =
                                  snapshot.data;
                              return !snapshot.hasData
                                  ? CircularProgressIndicator()
                                  : Text('${surveyList!.length}');
                            })
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: height * .005, left: size.width * .03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [const Text('Cevap'), Text('$answerAmount')],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * .03052868438),
              height: height * .0018,
              width: size.width,
              color: Colors.black,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: height * .01831721062,
                  left: size.width * .017708333,
                  right: size.width * .017708333),
              height: height * .75,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: Colors.black, width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12)),
              child: _widgetOptions.elementAt(_selectedIndex),
            )
          ],
        ),
      ),
      drawer: drawerBuild(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black, // fixedColor: Colors.blue,
        selectedLabelStyle: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedIconTheme: const IconThemeData(opacity: .40),
        selectedIconTheme: const IconThemeData(opacity: 1, color: Colors.black),
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: true,
        iconSize: 24,
        mouseCursor: MouseCursor.uncontrolled,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Anketler'),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_outlined), label: 'Cevaplar'),
        ],
      ),
    );
  }
}
