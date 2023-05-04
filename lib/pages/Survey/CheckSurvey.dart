import 'package:flutter/material.dart';
import 'package:survey/Services/Firestore_services.dart';
import 'package:survey/pages/Survey/AddASurvey.dart';

class CheckSurvey extends StatefulWidget {
  final List<String> names;
  final String label;
  final String explain;
  final bool val;
  const CheckSurvey(
      {super.key,
      required this.names,
      required this.label,
      required this.explain,
      required this.val});

  @override
  State<CheckSurvey> createState() => _CheckSurveyState();
}

class _CheckSurveyState extends State<CheckSurvey> {
  bool isCheck = false;
  final ScrollController _scrollController = ScrollController();
  final FirestoreService _firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
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
                    widget.label,
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
                        child: Scrollbar(
                          controller: _scrollController,
                          thumbVisibility: true,
                          child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: widget.names.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: BeveledRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(.5),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * .03180555533),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: size.width * .75,
                                          child: Text(
                                              widget.names.elementAt(index))),
                                    ],
                                  ),
                                ),
                              );
                            },
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
                      _firestoreService
                          .surveyAdd(widget.val, widget.label, widget.explain,
                              widget.names)
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
                  widget.val ? const Text('True') : const Text('False')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
