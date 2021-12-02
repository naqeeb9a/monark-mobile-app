import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:graphql/client.dart';
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
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
      appBar: bar(
        context,
        bgColor: Colors.transparent,
        menuIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: SafeArea(
        child: Center(
          child: Container(
            width: dynamicWidth(context, .8),
            height: dynamicHeight(context, .8),
            child: globalAccessToken == "guest"
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      profilePicture(
                        context,
                      ),
                      profileText(context, "Sign in"),
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
                      profileText(context, "Order History"),
                      profileText(context, "Addresses"),
                      SizedBox(
                        height: dynamicHeight(context, 0.03),
                      ),
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
                    future: getUserData(globalAccessToken),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data);
                        if (snapshot.data == "Server Error") {
                          return Center(
                            child: Text("no internet"),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              profilePicture(
                                context,
                              ),
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
                              profileText(context, "Addresses"),
                              SizedBox(
                                height: dynamicHeight(context, 0.03),
                              ),
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
                          );
                        }
                      } else {
                        return Center(
                          child: JumpingDotsProgressIndicator(
                            color: darkTheme == true ? myWhite : myBlack,
                            numberOfDots: 5,
                            fontSize: dynamicWidth(context, .08),
                          ),
                        );
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
      Text(
        text1,
        style: TextStyle(
          fontSize: dynamicWidth(context, .04),
          color: darkTheme == true ? myWhite : myBlack,
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, 0.01),
      ),
      Divider(
        color: darkTheme == true ? myWhite : myBlack,
      ),
    ],
  );
}
