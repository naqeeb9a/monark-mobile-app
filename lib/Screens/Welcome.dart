import 'package:flutter/material.dart';
import 'package:monark_app/Screens/SignUp.dart';
import 'package:monark_app/Screens/bottomNav.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/media_query.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
        body: Center(
          child: Container(
            height: dynamicHeight(context, .3),
            width: dynamicWidth(context, .9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                coloredButton(
                  context,
                  "Log In",
                  function: () {
                    push(
                      context,
                      Login(),
                    );
                  },
                ),
                coloredButton(
                  context,
                  "Sign Up",
                  function: () {
                    push(
                      context,
                      SignUp(),
                    );
                  },
                ),
                coloredButton(
                  context,
                  "Sign In as Guest",
                  function: () async {
                    SharedPreferences saveUser =
                        await SharedPreferences.getInstance();
                    saveUser.setString("loginInfo", "guest");
                    pushAndRemoveUntil(
                      context,
                      BottomNav(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
