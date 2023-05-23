import 'package:flutter/material.dart';
import 'package:survey/Services/FirestoreServices/answer_services.dart';
import 'package:survey/pages/Survey/AddASurvey.dart';

import '../../Services/FirestoreServices/survey_services.dart';

class CheckSurvey extends StatefulWidget {
  final List<String> names;
  final List<int> numbers;
  final String topic;
  final String explain;
  final bool check;
  const CheckSurvey(
      {super.key,
      required this.names,
      required this.numbers,
      required this.topic,
      required this.explain,
      required this.check});

  @override
  State<CheckSurvey> createState() => _CheckSurveyState();
}

class _CheckSurveyState extends State<CheckSurvey> {
  final SurveyService surveyService = SurveyService();
  final ScrollController _scrollController = ScrollController();
  AnswerService answerService = AnswerService();
  @override
  Widget build(BuildContext context) {
    List list = List.generate(widget.names.length,
        (index) => {"title": widget.names[index], "number": 0, "value": false});

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .02361111066),
        child: SizedBox(
          height: size.height * .95,
          width: size.width * .91,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * .01102941155,
                horizontal: size.width * .02361111066),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .06,
                  ),
                  Text(
                    widget.topic,
                    style: const TextStyle(
                        fontSize: 32,
                        fontStyle: FontStyle.italic,
                        decorationStyle: TextDecorationStyle.solid),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Explain'),
                            content: Text(widget.explain),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  size: 32,
                                  Icons.close,
                                  color: Colors.red,
                                  shadows: <Shadow>[
                                    Shadow(
                                        color: Colors.black, blurRadius: 15.0)
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Center(
                      child: Text(
                        "open explain",
                        style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            color: Colors.blueAccent,
                            fontSize: 14,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * .00551470577,
                        bottom: size.height * .00551470577),
                    child: Center(
                      child: SizedBox(
                        height: size.height * .58,
                        width: size.width * .9,
                        child: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Column(
                            children: List.generate(
                              list.length,
                              (index) {
                                return CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
                                  title: Text(
                                    list[index]["title"],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  value: list[index]["value"],
                                  onChanged: (value) {
                                    setState(() {
                                      if (!widget.check) {
                                        for (var element in list) {
                                          element["value"] = false;
                                        }
                                        list[index]["value"] = value;
                                      } else {
                                        list[index]["value"] = value;
                                      }
                                      print('List of List $list');
                                    });
                                  },
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Explain'),
                              content: Text(widget.explain),
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * .00551470577),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          //color: colorPrimaryShade,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * .00551470577,
                            horizontal: size.width * .01180555533),
                        child: const Center(
                          child: Text(
                            "Open Explain",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  InkWell(
                    onTap: () {
                      surveyService.uploadAnswer(list);
                      surveyService
                          .addSurvey(
                              widget.check, widget.topic, widget.explain, list)
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddASurvey())));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * .00551470577),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            //color: colorPrimaryShade,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * .00551470577,
                              horizontal: size.width * .01180555533),
                          child: const Center(
                            child: Text(
                              "Add A Survey",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.check ? const Text('True') : const Text('False')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
