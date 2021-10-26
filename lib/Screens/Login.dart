import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/SignUp.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';

final _formKey = GlobalKey<FormState>();
final email = TextEditingController();
final password = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: bar2(context),
      body: SafeArea(
        child: Center(
          child: Container(
            width: dynamicWidth(context, .92),
            height: dynamicHeight(context, .84),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            color: myBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: dynamicWidth(context, .09),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .1),
                    ),
                    inputTextField(
                      context,
                      "Email",
                      email,
                      function: (value) {
                        if (EmailValidator.validate(value)) {
                        } else {
                          return "Enter Valid Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .04),
                    ),
                    inputTextField(
                      context,
                      "Password",
                      password,
                      password: true,
                      function: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must have 8 characters';
                        }
                        return null;
                      },
                      function2: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .1),
                    ),
                    coloredButton(
                      context,
                      "Login",
                      myRed,
                      myWhite,
                      true,
                      function: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: dynamicHeight(context, .04),
                    ),
                    richTextWidget(
                      context,
                      "Don't have an account?  ",
                      "Sign Up",
                      dynamicWidth(context, .04),
                      dynamicWidth(context, .05),
                      SignUp(),
                      myBlack,
                      myRed,
                      true,
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
