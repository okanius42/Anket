import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../Services/Auth_Services.dart';
import 'Login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordAgainController =
      TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.width * .02361111066),
            child: Container(
              height: size.height * .7,
              width: size.width * .85,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * .02361111066,
                    vertical: size.height * .01102941155),
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                            controller: _displayNameController,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              hintText: 'Username',
                              prefixText: ' ',
                              hintStyle: TextStyle(color: Colors.black),
                              focusColor: Colors.black,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.black,
                              )),
                            )),
                        SizedBox(
                          height: size.height * .01764705849,
                        ),
                        TextFormField(
                          controller: _emailController,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                            hintText: 'E-Mail',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && EmailValidator.validate(email)
                                  ? null
                                  : 'Enter a valid email',
                        ),
                        SizedBox(
                          height: size.height * .01764705849,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min. 6 characters'
                                  : null,
                        ),
                        SizedBox(
                          height: size.height * .01764705849,
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black,
                          controller: _passwordAgainController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.vpn_key,
                              color: Colors.black,
                            ),
                            hintText: 'Password Again',
                            prefixText: ' ',
                            hintStyle: TextStyle(color: Colors.black),
                            focusColor: Colors.black,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                            )),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value != null && value.length < 6
                                  ? 'Enter min. 6 characters'
                                  : null,
                        ),
                        SizedBox(
                          height: size.height * .07169117513,
                        ),
                        InkWell(
                          onTap: () {
                            final isValid = formKey.currentState!.validate();
                            if (!isValid) return;
                            if (_passwordController.text ==
                                _passwordAgainController.text) {
                              _authService
                                  .signUp(
                                      _displayNameController.text,
                                      _emailController.text,
                                      _passwordController.text)
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Wrong'),
                                      content: Text('2 password must be same'),
                                      actions: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              size: 32,
                                              color: Colors.black,
                                              shadows: <Shadow>[
                                                Shadow(
                                                    color: Colors.red,
                                                    blurRadius: 15.0)
                                              ],
                                            ))
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: size.height * .00551470577),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                //color: colorPrimaryShade,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * .00551470577,
                                  horizontal: size.width * .01180555533),
                              child: const Center(
                                  child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )),
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
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * .05514705779),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black.withOpacity(.75),
                    size: 26,
                  ),
                ),
                SizedBox(
                  width: size.width * .3,
                ),
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black.withOpacity(.75),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
