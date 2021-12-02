import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SignUp.dart';
import 'bottomNav.dart';

final _formKey = GlobalKey<FormState>();
final email = TextEditingController();
final password = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;

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
    return isLoading == true
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                fontSize: dynamicWidth(context, .08),
                numberOfDots: 5,
                color: darkTheme == true ? myWhite : myBlack,
              ),
            ),
          )
        : SafeArea(
            child: SizedBox(
              width: dynamicWidth(context, 1),
              height: dynamicHeight(context, 1),
              child: Material(
                child: Stack(
                  children: [
                    Container(
                      width: dynamicWidth(context, 1),
                      height: dynamicHeight(context, .32),
                      color: myRed,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: dynamicHeight(context, .04),
                          ),
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(
                              color: myWhite,
                              fontSize: dynamicWidth(context, .06),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        width: dynamicWidth(context, 1),
                        height: dynamicHeight(context, .7),
                        decoration: BoxDecoration(
                          color: darkTheme == false ? myWhite : darkThemeBlack,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              dynamicHeight(context, .04),
                            ),
                            topRight: Radius.circular(
                              dynamicHeight(context, .04),
                            ),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, .05),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: dynamicHeight(context, .1),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                          color: darkTheme == false
                                              ? myBlack
                                              : myWhite,
                                          fontSize: dynamicWidth(context, .04),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .01),
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
                                    height: dynamicHeight(context, .014),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Password",
                                        style: TextStyle(
                                          color: darkTheme == false
                                              ? myBlack
                                              : myWhite,
                                          fontSize: dynamicWidth(context, .04),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .01),
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
                                    height: dynamicHeight(context, .01),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                          color: darkTheme == false
                                              ? myBlack
                                              : myWhite,
                                          fontSize: dynamicWidth(context, .04),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .08),
                                  ),
                                  coloredButton(
                                    context,
                                    "Login",
                                    function: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                      var accessToken = await loginUser();
                                      print(accessToken);
                                      if (accessToken == "Server Error") {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.warning,
                                          title: "No Internet",
                                          text:
                                              "Check your internet connection!!",
                                          backgroundColor: myRed,
                                          confirmBtnColor: myRed,
                                          animType: CoolAlertAnimType.scale,
                                        );
                                      } else if (accessToken != null) {
                                        SharedPreferences saveUser =
                                            await SharedPreferences
                                                .getInstance();

                                        saveUser.setString("loginInfo",
                                            accessToken.toString());
                                        pushAndRemoveUntil(
                                          context,
                                          BottomNav(),
                                        );
                                        email.clear();
                                        password.clear();
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          title: "",
                                          text:
                                              "Username or Password not Matched!!",
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
                                    darkTheme == false ? myBlack : myWhite,
                                    darkTheme == false ? myBlack : myWhite,
                                    true,
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: dynamicWidth(context, 1),
                      height: dynamicHeight(context, .06),
                      child: bar(
                        context,
                        bgColor: noColor,
                        iconColor: myWhite,
                        leadingIcon: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
