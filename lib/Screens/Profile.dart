import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/Screens/Orders.dart';
import 'package:monark_app/Screens/Wishlist.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/drawer_items.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final PageController controller;
  Profile({Key? key, required this.controller}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    print(globalAccessToken);
    globalContextProfile = context;
    super.build(context);
    logoutUser(accessToken) async {
      SharedPreferences saveUser = await SharedPreferences.getInstance();

      var deleteUserAccessToken = r'''
              mutation customerAccessTokenDelete($customerAccessToken: String!) {
                customerAccessTokenDelete(customerAccessToken: $customerAccessToken) {
                  deletedAccessToken
                  deletedCustomerAccessTokenId
                  userErrors {
                    field
                    message
                  }
                }
              }
 ''';
      var variables = {"customerAccessToken": accessToken.toString()};
      final HttpLink httpLink = HttpLink(
          "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
          defaultHeaders: {
            "X-Shopify-Storefront-Access-Token":
                "fce9486a511f6a4f45939c2c6829cdaa"
          });
      GraphQLClient client =
          GraphQLClient(link: httpLink, cache: GraphQLCache());
      final QueryOptions options = QueryOptions(
          document: gql(deleteUserAccessToken), variables: variables);
      final QueryResult result = await client.query(options);
      if (result.hasException) {
        return "Server Error";
      } else {
        await saveUser.clear();
        Phoenix.rebirth(context);
      }
    }

    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      appBar: bar(context, bgColor: noColor, leadingIcon: true, menuIcon: true,
          function: () {
        _scaffoldKey.currentState!.openEndDrawer();
      }, functionIcon: () {
        widget.controller.animateTo(0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut);
      }),
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: dynamicWidth(context, .8),
            height: dynamicHeight(context, .8),
            child: globalAccessToken == "guest"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      profilePicture(
                        context,
                      ),
                      heightBox(context, .06),
                      profileText(context, "Guest"),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WishlistPage(profileName: "Guest"),
                            ),
                          );
                        },
                        child: profileText(context, "My Wishlist"),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Please Sign in to View order History"),
                            duration: const Duration(milliseconds: 1000),
                          ));
                        },
                        child: profileText(context, "Order History"),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Sign in to View Addresses"),
                            duration: const Duration(milliseconds: 1000),
                          ));
                        },
                        child: profileText(context, "Addresses"),
                      ),
                      SizedBox(
                        height: dynamicHeight(context, 0.03),
                      ),
                      heightBox(context, .06),
                      coloredButton(context,
                          (globalAccessToken == "guest") ? "Sign In" : "logout",
                          function: () async {
                        if (globalAccessToken == "guest") {
                          SharedPreferences saveUser =
                              await SharedPreferences.getInstance();
                          saveUser.clear();
                          Phoenix.rebirth(context);
                        } else {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            backgroundColor: noColor,
                          );
                          logoutUser(globalAccessToken);
                        }
                      }),
                      SizedBox(
                        height: dynamicHeight(context, 0.03),
                      ),
                    ],
                  )
                : FutureBuilder(
                    future: getUserData(globalAccessToken,context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == "Server Error") {
                          return Center(
                            child: retryFunction(context, function: () {
                              setState(() {});
                            }),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              profilePicture(
                                context,
                              ),
                              heightBox(context, .06),
                              profileText(
                                context,
                                titleCase(snapshot.data["firstName"]) +
                                    " " +
                                    titleCase(snapshot.data["lastName"]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WishlistPage(
                                        profileName: snapshot.data["firstName"],
                                      ),
                                    ),
                                  );
                                },
                                child: profileText(context, "My Wishlist"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  push(
                                    context,
                                    Orders(),
                                  );
                                },
                                child: profileText(context, "Order History"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  push(
                                    context,
                                    AddressPage(
                                      check: true,
                                    ),
                                  );
                                },
                                child: profileText(context, "Addresses"),
                              ),
                              heightBox(context, .06),
                              coloredButton(
                                  context,
                                  (globalAccessToken == "guest")
                                      ? "Sign In"
                                      : "logout", function: () async {
                                if (globalAccessToken == "guest") {
                                  SharedPreferences saveUser =
                                      await SharedPreferences.getInstance();
                                  saveUser.clear();
                                  Phoenix.rebirth(context);
                                } else {
                                  CoolAlert.show(
                                    barrierDismissible: false,
                                    context: context,
                                    type: CoolAlertType.loading,
                                    backgroundColor: noColor,
                                  );
                                  dynamic response =
                                      logoutUser(globalAccessToken);
                                  if (response == "Server Error") {
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        text: "Check Your Internet ",
                                        backgroundColor: noColor);
                                  }
                                }
                              }),
                              SizedBox(
                                height: dynamicHeight(context, 0.03),
                              ),
                            ],
                          );
                        }
                      } else {
                        return Center(child: jumpingDots(context));
                      }
                    }),
          ),
        ),
      ),
    );
  }
}

Widget profileText(context, text1) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: dynamicWidth(context, 0.8),
        padding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, 0.014),
        ),
        child: Text(
          text1,
          style: TextStyle(
            fontSize: dynamicWidth(context, .03),
            color: darkTheme == true ? myWhite : myBlack,
          ),
        ),
      ),
      Divider(
        color: darkTheme == true ? myWhite : myBlack,
      ),
    ],
  );
}
