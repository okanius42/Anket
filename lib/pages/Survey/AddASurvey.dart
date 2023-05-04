import 'package:flutter/material.dart';

import '../../Drawer.dart';
import 'AddAChoice.dart';

class AddASurvey extends StatefulWidget {
  const AddASurvey({Key? key}) : super(key: key);

  @override
  State<AddASurvey> createState() => _AddASurveyState();
}

class _AddASurveyState extends State<AddASurvey> {
  TextEditingController topic = TextEditingController();
  TextEditingController explain = TextEditingController();
  bool val = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02361111066),
          child: Container(
            height: size.height * .58,
            width: size.width * .85,
            child: Padding(
              padding: EdgeInsets.only(top: height * .06105736876),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * .01587491587,
                    ),
                    TextField(
                      controller: topic,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.topic,
                            color: Colors.black,
                          ),
                          hintText: 'Topic',
                          prefixText: ' ',
                          hintStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: height * .02198065275,
                    ),
                    TextField(
                      controller: explain,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.abc,
                            color: Colors.black,
                          ),
                          hintText: 'Explain',
                          prefixText: ' ',
                          hintStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: height * .03297097913,
                    ),
                    Row(
                      children: [
                        const Text('Çoktan Seçmeli :'),
                        Checkbox(
                          value: val,
                          onChanged: (value) => setState(() {
                            val = value!;
                          }),
                        ),
                        val ? const Text('True') : const Text('False')
                      ],
                    ),
                    SizedBox(
                      height: height * .03297097913,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddChoice(
                                      topic: topic.text,
                                      explain: explain.text,
                                      val: val,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height * .00610573687),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                            child: Text(
                              "Okay",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: drawerBuild(),
    );
  }
}
