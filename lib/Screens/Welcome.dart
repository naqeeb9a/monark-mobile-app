import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';

import '../config.dart';
import 'Login.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      body: SafeArea(
        child: Center(
          child: Container(
            height: dynamicHeight(context, .92),
            width: dynamicWidth(context, .92),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                richTextWidget(
                    context,
                    "Welcome to ",
                    "Monark",
                    dynamicWidth(context, .05),
                    dynamicWidth(context, .064),
                    "",
                    myBlack,
                    myRed,
                    ""),
                AutoSizeText(
                  "Explore Us",
                  style: TextStyle(fontSize: 20.0, color: myBlack),
                ),
                Image.asset(
                  "assets/shopping.png",
                  height: dynamicHeight(context, .4),
                ),
                coloredButton(
                  context,
                  "Login",
                  myRed,
                  myWhite,
                  true,
                  page: Login(),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .02),
                    ),
                    child: Text(
                      "Continue as a Guest",
                      style: TextStyle(
                        fontSize: dynamicWidth(context, .056),
                        color: myRed,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
