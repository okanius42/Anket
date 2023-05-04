import 'package:flutter/material.dart';
import 'package:survey/pages/Survey/CheckSurvey.dart';

class AddChoice extends StatefulWidget {
  String topic;
  String explain;
  bool val;
  AddChoice(
      {super.key,
      required this.topic,
      required this.explain,
      required this.val});

  @override
  State<AddChoice> createState() => _AddChoiceState();
}

class _AddChoiceState extends State<AddChoice> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  List<String> surveyList = [];
  void add() {
    setState(() {
      surveyList.remove(_textEditingController.text);
      surveyList.add(_textEditingController.text);
    });
  }

  void update(String name) {
    setState(() {
      for (int i = 0; i < surveyList.length; i++) {
        if (name == surveyList.elementAt(i)) {
          surveyList[i] = _textEditingController.text;
        }
      }
    });
  }

  void delete(String name) {
    setState(() {
      surveyList.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .02361111066),
          child: Padding(
            padding: EdgeInsets.only(top: size.height * .02361111066),
            child: Column(
              children: [
                SizedBox(height: size.height * .04963235201),
                Text(
                  'Topic:${widget.topic}',
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
                                  Shadow(color: Colors.black, blurRadius: 15.0)
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
                SizedBox(height: size.height * .0297794112),
                TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.abc_outlined,
                      color: Colors.black,
                    ),
                    hintText: 'Choice',
                    prefixText: ' ',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .01433823502),
                InkWell(
                  onTap: () {
                    add();
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
                          "Add a Choice",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * .01433823502),
                InkWell(
                  onTap: () {
                    setState(() {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckSurvey(
                                    names: surveyList,
                                    label: widget.topic,
                                    explain: widget.explain,
                                    val: widget.val,
                                  )));
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
                          "Okey",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * .02757352889,
                    bottom: size.height * .00551470577,
                  ),
                  child: Center(
                    child: Container(
                      height: size.height * .51,
                      width: size.width * .95,
                      child: Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: surveyList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * .02361111066),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: size.width * .67,
                                          child: Text(
                                              surveyList.elementAt(index))),
                                      SizedBox(
                                        height: size.height * .04411764623,
                                        width: size.width * .10588225,
                                        child: IconButton(
                                          icon: const Icon(Icons.update),
                                          onPressed: () {
                                            update(surveyList.elementAt(index));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * .04411764623,
                                        width: size.width * .10588225,
                                        child: IconButton(
                                          icon:
                                              const Icon(Icons.delete_forever),
                                          onPressed: () {
                                            delete(surveyList.elementAt(index));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
