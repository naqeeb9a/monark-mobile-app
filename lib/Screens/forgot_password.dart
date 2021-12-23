import 'package:auto_size_text/auto_size_text.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final forgotPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

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
          child: Form(
            key: _formKey,
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
                  function: (value) {
                    if (EmailValidator.validate(value)) {
                    } else {
                      return "Enter Valid Email";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: dynamicHeight(context, .1),
                  ),
                  child: loading == true
                      ? jumpingDots(context)
                      : coloredButton(
                          context,
                          "Send Verification Email",
                          width: dynamicWidth(context, .6),
                          function: () async {
                            setState(() {
                              loading = true;
                            });
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              var result = await passwordReset(
                                  forgotPassword.text.toString());

                              if (result == "Server Error") {
                                setState(() {
                                  loading = false;
                                });
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  title: "No Internet",
                                  text: "Check your internet connection!!",
                                  backgroundColor: myRed,
                                  confirmBtnColor: myRed,
                                  animType: CoolAlertAnimType.scale,
                                );
                              } else if (result == "done") {
                                setState(() {
                                  loading = false;
                                });
                                CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    title: "Email Sent",
                                    text:
                                        "An email has been sent to you. PLease proceed there!!",
                                    backgroundColor: myRed,
                                    confirmBtnColor: myRed,
                                    animType: CoolAlertAnimType.scale,
                                    onCancelBtnTap: () {
                                      pop(context);
                                      pop(context);
                                    });
                              }

                              print(result);
                            }
                          },
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
