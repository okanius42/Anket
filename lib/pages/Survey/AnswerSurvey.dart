import 'dart:core';

import 'package:flutter/material.dart';
import 'package:survey/pages/Profile.dart';

import '../../Services/FirestoreServices/answer_services.dart';

class AnswerSurvey extends StatefulWidget {
  bool isCheck;
  List list;
  int surveyID;
  AnswerSurvey(
      {super.key,
      required this.isCheck,
      required this.list,
      required this.surveyID});
  @override
  State<AnswerSurvey> createState() => _AnswerSurveyState();
}

class _AnswerSurveyState extends State<AnswerSurvey> {
  final AnswerService answerService = AnswerService();

  @override
  Widget build(BuildContext context) {
    List checkListItems = widget.list;
    int surveyId = widget.surveyID;
    var size = MediaQuery.of(context).size;
    var height =
        size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02361111066),
          child: SizedBox(
            height: height * .95,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * .02361111066,
                  vertical: size.height * .01102941155),
              child: Center(
                child: Column(
                  children: [
                    Text("topic"),
                    SizedBox(
                      height: size.height * .01433823502,
                    ),
                    Text("explain"),
                    SizedBox(
                      height: size.height * .01433823502,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        children: List.generate(
                            checkListItems.length,
                            (index) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text(
                                  checkListItems[index]["title"],
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                                value: checkListItems[index]["value"],
                                onChanged: (value) {
                                  setState(() {
                                    if (widget.isCheck) {
                                      for (var element in checkListItems) {
                                        element["value"] = false;
                                      }
                                      checkListItems[index]["value"] = value;
                                    } else {
                                      checkListItems[index]["value"] = value;
                                    }
                                  });
                                })),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .01433823502,
                    ),
                    InkWell(
                      onTap: () {
                        answerService.answer(checkListItems, surveyId).then(
                            (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile())));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * .00551470577),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * .00551470577,
                              horizontal: size.width * .01180555533),
                          child: const Center(
                            child: Text(
                              "Answer",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
