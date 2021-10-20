import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Login.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';

final _formKey = GlobalKey<FormState>();

final fName = TextEditingController();
final lName = TextEditingController();
final email = TextEditingController();
final password = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: bar2(context),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: myBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: dynamicWidth(context, .09),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .08),
                  ),
                  inputTextField(
                    context,
                    false,
                    "First Name",
                    fName,
                    function: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  inputTextField(
                    context,
                    false,
                    "Last Name",
                    lName,
                    function: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  inputTextField(
                    context,
                    false,
                    "Email",
                    email,
                    function: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .01),
                  ),
                  inputTextField(
                    context,
                    true,
                    "Password",
                    password,
                    function: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return 'Password must have 8 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .1),
                  ),
                  coloredButton(
                      context, "SignUp", Login(), myRed, myWhite, false),
                  SizedBox(
                    height: dynamicHeight(context, .04),
                  ),
                  richTextWidget(
                      context,
                      "Already have an account?  ",
                      "Log In",
                      dynamicWidth(context, .04),
                      dynamicWidth(context, .05),
                      Login(),
                      myBlack,
                      myRed,
                      false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
