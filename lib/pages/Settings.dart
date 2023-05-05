import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _dateInput = TextEditingController();

  @override
  void initState() {
    _dateInput.text = '';
    super.initState();
  }

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
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _name,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01433823502,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _surname,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Surname',
                          hintStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01433823502,
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _dateInput,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_month_outlined),
                          hintText: 'Enter Date',
                          hintStyle: TextStyle(color: Colors.black),
                          focusColor: Colors.black,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDatePickerMode: DatePickerMode.day,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black)),
                                  child: child!,
                                );
                              });
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy--MM-dd').format(pickedDate);
                            setState(() {
                              _dateInput.text = formattedDate;
                            });
                          } else {
                            //Date is not selected
                          }
                        },
                      ),
                      SizedBox(
                        height: height * .03433823502,
                      ),
                      InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
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
                                "Set",
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
                  )),
            ),
          ),
        ),
        drawer: drawerBuild());
  }
}
