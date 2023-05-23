import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:survey/Services/Auth_Services.dart';
import 'package:survey/User/Login.dart';
import 'package:survey/firebase_options.dart';
import 'package:survey/pages/Profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthState _authState = AuthState();
  User? user = FirebaseAuth.instance.currentUser;
  static Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };
  MaterialColor primeColor = MaterialColor(0xFFFFFFFF, color);
  MaterialColor accentColor = MaterialColor(0xFF337C36, color);
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survey',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.blue,
            selectionHandleColor: Colors.black),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black), color: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.white,
            onPrimary: Colors.black,
            secondary: Colors.red,
            onSecondary: Colors.white,
            error: Colors.blueAccent,
            onError: Colors.white,
            background: Colors.white,
            onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black),
      ),
      home: user == null ? LoginPage() : const Profile(),
    );
  }
}
