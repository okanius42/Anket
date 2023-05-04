import 'package:flutter/material.dart';
import 'package:survey/Drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                child: const Center(
                  child: Text(
                    'Home Page',
                    style: TextStyle(
                        fontSize: 32, decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ),
          ),
        ),
        drawer: drawerBuild());
  }
}
