import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        bgColor: noColor,
        leadingIcon: true,
      ),
      body: Center(
        child: SizedBox(
          width: dynamicWidth(context, .9),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      "Forget Password?",
                      style: TextStyle(
                        fontFamily: "Aeonik",
                        color: darkTheme == true ? myWhite : myBlack,
                        fontSize: dynamicWidth(context, .082),
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              inputTextField(
                context,
                "Email",
                forgotPassword,
                hintText: "Email",
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: dynamicHeight(context, .1),
                ),
                child: coloredButton(context, "Send Verification Email",
                    width: dynamicWidth(context, .6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
