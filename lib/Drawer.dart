import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:survey/Services/Firestore_services.dart';

import 'Services/Auth_Services.dart';
import 'asdasd.dart';
import 'pages/About.dart';
import 'pages/Home.dart';
import 'pages/Profile.dart';
import 'pages/Settings.dart';
import 'pages/Statistics.dart';
import 'pages/Survey/AddASurvey.dart';
import 'pages/Survey/Surveys.dart';

class drawerBuild extends StatelessWidget {
  drawerBuild({super.key});
  AuthService _authService = AuthService();
  FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: StreamBuilder<DocumentSnapshot>(
                stream: _firestoreService.FieldStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                      'Something went wrong',
                      style: TextStyle(color: Colors.black),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading",
                        style: TextStyle(color: Colors.black));
                  }
                  Map<String, dynamic> data =
                      snapshot.data!.data()! as Map<String, dynamic>;
                  return Text(data['username'],
                      style: const TextStyle(color: Colors.black));
                }),
            accountEmail: Text(_firestoreService.getEmail().toString(),
                style: const TextStyle(color: Colors.black)),
            currentAccountPicture:
                const CircleAvatar(backgroundColor: Colors.blue),
          ),
          const Divider(color: Colors.black),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            title: const Text('Profile'),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Surveys'),
            leading: const Icon(Icons.done_all),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Surveys()));
            },
          ),
          ListTile(
            title: const Text('Add a Survey'),
            leading: const Icon(Icons.exposure_plus_1),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddASurvey()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Statistics'),
            leading: const Icon(Icons.bar_chart),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Statistics()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(Icons.explicit),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const About()));
            },
          ),
          ListTile(
            title: const Text('Log out'),
            leading: const Icon(Icons.logout),
            onTap: () {
              _authService.signOut(context);
            },
          ),
          ListTile(
            title: const Text('asdasd'),
            leading: const Icon(Icons.traffic_sharp),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const asdasd()));
            },
          ),
        ],
      ),
    );
  }
}
