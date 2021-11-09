import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';
import 'Login.dart';

class Welcome extends StatefulWidget {
  Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
                  style: TextStyle(
                    fontSize: dynamicWidth(context, .06),
                    color: myBlack,
                  ),
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
                  onTap: () async {
                    SharedPreferences saveUser =
                        await SharedPreferences.getInstance();
                    saveUser.setString("loginInfo", "");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Home(
                                  accessToken: saveUser.getString("loginInfo"),
                                )),
                        (Route<dynamic> route) => false);
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
