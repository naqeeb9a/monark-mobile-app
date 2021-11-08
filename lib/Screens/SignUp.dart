import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
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
  bool isloading = false;
  userSignUp() async {
    print(sEmail.text);
    print(sPassword.text);
    print(fName.text);
    print(lName.text);
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
      print(result.data);
      return "Server Error";
    } else {
      if (result.data!["customerCreate"]["customer"] != null) {
        print(result.data!["customerCreate"]["customer"]["id"]);
        return result.data!["customerCreate"]["customer"]["id"];
      } else {
        return result.data!["customerCreate"]["customer"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (isloading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 20,
                numberOfDots: 5,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: myGrey,
            appBar: bar2(context),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                color: myBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: dynamicWidth(context, .09),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .08),
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
                          height: dynamicHeight(context, .06),
                        ),
                        coloredButton(
                          context,
                          "SignUp",
                          myRed,
                          myWhite,
                          false,
                          function: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            setState(() {
                              isloading = true;
                            });
                            var response = await userSignUp();
                            print(response);
                            if (response == "Server Error") {
                              setState(() {
                                isloading = false;
                              });
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title:
                                      "Creating Customer Limit exceeded. Please try again later.");
                            } else if (response == null) {
                              setState(() {
                                isloading = false;
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
                                isloading = false;
                              });
                              Navigator.pop(context);
                            } else {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: "Unidentified Error");
                            }
                          },
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        richTextWidget(
                            context,
                            "Already have an account?  ",
                            "Log In",
                            dynamicWidth(context, .04),
                            dynamicWidth(context, .05),
                            Login(),
                            myBlack,
                            myRed,
                            false),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
