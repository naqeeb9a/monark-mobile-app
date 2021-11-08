import 'dart:ui';

import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/SignUp.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

final _formKey = GlobalKey<FormState>();
final email = TextEditingController();
final password = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isloading = false;

  loginUser() async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    const createUserAccessToken = r'''
                mutation customerAccessTokenCreate($input: CustomerAccessTokenCreateInput!) {
                  customerAccessTokenCreate(input: $input) {
                    customerAccessToken {
                      accessToken
                      expiresAt
                    }
                    customerUserErrors {
                      code
                      field
                      message
                    }
                  }
                }
            ''';
    var variables = {
      "input": {
        "email": email.text.toString(),
        "password": password.text.toString()
      }
    };
    final HttpLink httpLink = HttpLink(
        "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
        defaultHeaders: {
          "X-Shopify-Storefront-Access-Token":
              "fce9486a511f6a4f45939c2c6829cdaa"
        });
    GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
    final QueryOptions options = QueryOptions(
        document: gql(createUserAccessToken), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      return "Server Error";
    } else {
      if (result.data!["customerAccessTokenCreate"]["customerAccessToken"] !=
          null) {
        saveUser.setString(
            "loginInfo",
            result.data!["customerAccessTokenCreate"]["customerAccessToken"]
                ["accessToken"]);
        return result.data!["customerAccessTokenCreate"]["customerAccessToken"]
            ["accessToken"];
      } else {
        return result.data!["customerAccessTokenCreate"]["customerAccessToken"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isloading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                fontSize: dynamicWidth(context, .08),
                numberOfDots: 5,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: myGrey,
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
                            function: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              setState(() {
                                isloading = true;
                              });
                              var accessToken = await loginUser();
                              if (accessToken == "Server Error") {
                                Dialog(
                                  child: Text("Server Error"),
                                );
                                setState(() {
                                  isloading = false;
                                });
                              } else if (accessToken != null) {
                                SharedPreferences saveUser =
                                    await SharedPreferences.getInstance();
                                print(accessToken);
                                saveUser.setString(
                                    "loginInfo", accessToken.toString());
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => Home(
                                              accessToken: saveUser
                                                  .getString("loginInfo"),
                                            )),
                                    (Route<dynamic> route) => false);
                                email.clear();
                                password.clear();
                              } else {
                                setState(() {
                                  isloading = false;
                                });

                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: "",
                                  text: "Username or Password not Matched!!",
                                  backgroundColor: myRed,
                                  confirmBtnColor: myRed,
                                  animType: CoolAlertAnimType.scale,
                                  flareAnimationName: "Dance",
                                );
                              }
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
