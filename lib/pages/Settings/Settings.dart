import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:survey/Services/FirestoreServices/user_services.dart';

import '../../Drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _dateInput = TextEditingController();
  UserService userService = UserService();
  @override
  void initState() {
    _dateInput.text = '';
    super.initState();
  }

  DateTime? _chosenDateTime;

  calculateAge(DateTime pickedDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - pickedDate.year;
    int monthCurrent = currentDate.month;
    int monthPicked = pickedDate.month;
    if (monthPicked > monthCurrent) {
      age--;
    } else if (monthPicked == monthCurrent) {
      int dayCurrent = currentDate.day;
      int dayPicked = pickedDate.day;
      if (dayPicked > dayCurrent) {
        age--;
      }
    }
    return age;
  }

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 500,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (val) {
                    setState(() {
                      _chosenDateTime = val;
                    });
                  },
                  mode: CupertinoDatePickerMode.date),
            ),
            CupertinoButton(
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(ctx).pop(),
            )
          ],
        ),
      ),
    );
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
          padding: EdgeInsets.symmetric(horizontal: size.width * .01361111066),
          child: SizedBox(
            height: size.height * .58,
            child: Padding(
                padding: EdgeInsets.only(top: height * .06105736876),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .035,
                        ),
                        Text('Ad'),
                      ],
                    ),
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
                      height: height * .03433823502,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .035,
                        ),
                        Text('Soyadı'),
                      ],
                    ),
                    SizedBox(
                      height: height * .00433823502,
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
                      height: height * .02433823502,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .035,
                        ),
                        Text('Doğum Tarihi'),
                      ],
                    ),
                    SizedBox(
                      height: height * .00433823502,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .034,
                        ),
                        Icon(Icons.calendar_month_outlined),
                        SizedBox(
                          width: size.width * .025,
                        ),
                        SizedBox(
                          width: size.width * .38,
                          height: height * .05,
                          child: Center(
                            child: Text(
                              _chosenDateTime != null
                                  ? "${_chosenDateTime!.day.toString()}.${_chosenDateTime!.month.toString()}.${_chosenDateTime!.year.toString()} "
                                  : 'Doğum tarihinizi seçiniz',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * .175,
                        ),
                        CupertinoPageScaffold(
                          navigationBar: CupertinoNavigationBar(
                            middle: Text(
                              '',
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                            trailing: CupertinoButton(
                              padding: EdgeInsetsDirectional.zero,
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                width: size.width * .2,
                                height: height * .1,
                                margin: EdgeInsets.only(bottom: height * .01),
                                child: Center(
                                  child: Text(
                                    'Seç',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ),
                              ),
                              onPressed: () => _showDatePicker(context),
                            ),
                          ),
                          child: SafeArea(
                            child: Container(
                              width: size.width * .3,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.black87,
                      height: height * .0015,
                    ),
                    SizedBox(
                      height: height * .01933823502,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .035,
                        ),
                        Text('Yaş'),
                      ],
                    ),
                    SizedBox(
                      height: height * .01433823502,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * .035,
                        ),
                        Text(_chosenDateTime != null
                            ? "${calculateAge(_chosenDateTime!).toString()}"
                            : 'Doğum tarihinizi seçiniz'),
                      ],
                    ),
                    SizedBox(
                      height: height * .01433823502,
                    ),
                    Container(
                      color: Colors.black87,
                      height: height * .0015,
                    ),
                    SizedBox(
                      height: height * .01433823502,
                    ),
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (_name.text != '') {
                          userService.nameUpdate(_name.text);
                        }
                        if (_surname.text != '') {
                          userService.surnameUpdate(_surname.text);
                        }
                        if (_chosenDateTime != null) {
                          userService.ageUpdate(
                              _chosenDateTime!, calculateAge(_chosenDateTime!));
                        }
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
                              "Onayla",
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
      drawer: drawerBuild(),
    );
  }
}
