import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Login.dart';
import 'package:monark_app/Screens/Welcome.dart';

import 'Home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: bar2(context),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  rowText("Sign Up", context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  inputTextField(
                    "Name",
                    function: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                  ),
                  inputTextField(
                    "Email",
                    function: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  inputTextField("Password",
                      function: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must have 8 characters';
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                      password: true,
                      function2: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      }),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 11,
                  ),
                  coloredButton(context, "Sign Up", function: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    Navigator.pop(context);
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  multiPropertyText("Have an account already? ", "Sign In",
                      function: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
