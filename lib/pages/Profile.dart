import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:survey/Services/Auth_Services.dart';
import 'package:survey/Services/Firestore_services.dart';
import 'package:survey/User/Login.dart';

import '../Drawer.dart';
import '../User/Register.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  int anket = 5;
  int cevap = 8;
  String topic = '';
  String explain = '';
  int _selectedIndex = 0;
  AuthService _authService = AuthService();
  FirestoreService _firestoreService = FirestoreService();

  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Anket'),
        Text("Bu bir ankettir."),
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Cevap'),
        Text("Bu bir cevaplanmış ankettir"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: null, icon: Icon(Icons.settings))],
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
                        stream: _firestoreService.FieldStream(),
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
                              snapshot.data!.data()! as Map<String, dynamic>;
                          print('Data of Firebase: $data');
                          return Text(data['username']);
                        },
                      )),
                  Container(
                    margin: EdgeInsets.only(top: height * .005),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Anket'), Text('$anket')],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: height * .005, left: size.width * .03),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text('Cevap'), Text('$cevap')],
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
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: (_selectedIndex == 0) ? anket : cevap,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black.withOpacity(.5),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: size.width * .02361111066,
                              top: height * .000001),
                          child: InkWell(
                            onTap: () {
                              (_selectedIndex == 0)
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width: size.width * .9,
                                  child:
                                      _widgetOptions.elementAt(_selectedIndex),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
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
