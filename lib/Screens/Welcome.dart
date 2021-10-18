import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/Screens/Login.dart';
import 'SignUp.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.1,
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                multiPropertyText("Welcome to ", "Monark", size: 22),
                Text(
                  "Explore Us",
                  style: TextStyle(fontSize: 20, color: myBlack),
                ),
                Image.asset("assets/shopping.png"),
                coloredButton(context, "Login", function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                }),
                coloredButton(context, "SignUp", function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                }, noColor: true)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget coloredButton(context, text, {function = "", noColor=false}) {
  return (noColor == true)
      ? MaterialButton(
          onPressed: (function == "") ? () {} : function,
          child: Text(
            text,
            style: TextStyle(color: myBlack, fontSize: 18),
          ),
        )
      : Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: titleRed.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 10,
                offset: Offset(7, 9),
              )
            ],
          ),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width * 0.74,
            height: MediaQuery.of(context).size.height * 0.06,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: myRed,
            onPressed:(function=="")?(){} :function,
            child: Text(
              text,
              style: TextStyle(color: myWhite, fontSize: 18),
            ),
          ),
        );
}
