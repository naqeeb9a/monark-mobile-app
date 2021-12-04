import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Login.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/rich_text.dart';
import 'package:progress_indicators/progress_indicators.dart';

final _formKey = GlobalKey<FormState>();

final fName = TextEditingController();
final lName = TextEditingController();
final sEmail = TextEditingController();
final sPassword = TextEditingController();
final cPassword = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  userSignUp() async {
    const createUserAccessToken = r'''
              mutation customerCreate($input: CustomerCreateInput!) {
  customerCreate(input: $input) {
    customer {
      id
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
        "email": sEmail.text.toString(),
        "password": sPassword.text.toString(),
        "firstName": fName.text.toString(),
        "lastName": lName.text.toString()
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
      if (result.data!["customerCreate"]["customer"] != null) {
        return result.data!["customerCreate"]["customer"]["id"];
      } else {
        return result.data!["customerCreate"]["customer"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                color: darkTheme == true ? myWhite : myBlack,
                fontSize: dynamicWidth(context, .08),
                numberOfDots: 5,
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
                            "Welcome to Monark",
                            style: TextStyle(
                              fontFamily: "Aeonik",
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
                                    height: dynamicHeight(context, .04),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "First Name",
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
                                    "First Name",
                                    fName,
                                    function: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a valid Name';
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
                                        "Last Name",
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
                                    "Last Name",
                                    lName,
                                    function: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a valid Name';
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
                                    sEmail,
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
                                    sPassword,
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
                                    height: dynamicHeight(context, .014),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Confirm Password",
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
                                    "Confirm Password",
                                    cPassword,
                                    password: true,
                                    function: (value) {
                                      if (value!.isEmpty ||
                                          value.toString() != sPassword.text) {
                                        return 'Password must be same as above';
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
                                    height: dynamicHeight(context, .04),
                                  ),
                                  coloredButton(
                                    context,
                                    "SignUp",
                                    function: () async {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      setState(() {
                                        isLoading = true;
                                      });
                                      var response = await userSignUp();
                                      if (response == "Server Error") {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.error,
                                            title:
                                                "Creating Customer Limit exceeded. Please try again later.",
                                            text:
                                                "Check your internet as well");
                                      } else if (response == null) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.warning,
                                            title: "Email already Taken");
                                      } else if (response != null) {
                                        sEmail.clear();
                                        sPassword.clear();
                                        fName.clear();
                                        lName.clear();
                                        cPassword.clear();
                                        setState(() {
                                          isLoading = false;
                                        });
                                        CoolAlert.show(
                                            context: context,
                                            type: CoolAlertType.success,
                                            title: "Successfully Created",
                                            text: "please login in Now",
                                            onConfirmBtnTap: () {
                                              Navigator.popUntil(context,
                                                  (route) => route.isFirst);
                                            });
                                      } else {
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.info,
                                          title: "Unidentified Error",
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: dynamicHeight(context, .02),
                                  ),
                                  richTextWidget(
                                    context,
                                    "Already have an account?  ",
                                    "Log In",
                                    dynamicWidth(context, .04),
                                    dynamicWidth(context, .05),
                                    Login(),
                                    darkTheme == false ? myBlack : myWhite,
                                    darkTheme == false ? myBlack : myWhite,
                                    false,
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
