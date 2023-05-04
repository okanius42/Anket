import 'package:flutter/material.dart';

import '../Drawer.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
                    'Settings',
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
