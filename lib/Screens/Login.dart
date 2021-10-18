import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/SignUp.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/config.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

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
                  rowText("Login", context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                  ),
                  inputTextField("Email", function: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return 'Please enter a valid Email';
                    }
                    return null;
                  }),
                  inputTextField("Password",
                      function: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return 'Password must have 8 characters';
                        }
                        return null;
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: myBlack,
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
                  coloredButton(
                    context,
                    "Login",
                    function: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  multiPropertyText(
                    "Don't have an account?  ",
                    "Sign Up",
                    function: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget inputTextField(text,
    {function = "", icon = "", function2 = "", password = false}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (function == "") ? () {} : function,
    cursorColor: myBlack,
    keyboardType: TextInputType.emailAddress,
    obscureText: (password == true) ? obscureText : false,
    decoration: InputDecoration(
      suffixIcon: (icon == "")
          ? null
          : InkWell(onTap: (function2 == "") ? () {} : function2, child: icon),
      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
      labelText: text,
      labelStyle: TextStyle(
        color: myBlack,
        fontSize: 16.0,
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: myGrey)),
    ),
  );
}

Widget multiPropertyText(text, text1, {function = "", double size = 14}) {
  return InkWell(
    onTap: (function == "") ? () {} : function,
    child: RichText(
        text: TextSpan(children: [
      TextSpan(
        text: text,
        style: TextStyle(fontSize: size, color: myBlack),
      ),
      TextSpan(
        text: text1,
        style: TextStyle(
            fontSize: size, color: myBlack, fontWeight: FontWeight.bold),
      )
    ])),
  );
}
