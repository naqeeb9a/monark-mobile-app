import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Login.dart';
import 'package:monark_app/Screens/Orders.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/Screens/policies.dart';
import 'package:monark_app/Screens/store_finder.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

Widget drawerItems(context, {customerInfo = false, accessToken = ""}) {
  logoutUser(accessToken) async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    print(accessToken);
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
    GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
    final QueryOptions options = QueryOptions(
        document: gql(deleteUserAccessToken), variables: variables);
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.hasException);
      return "Server Error";
    } else {
      print(result.data);
      await saveUser.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Welcome()),
          (Route<dynamic> route) => false);
    }
  }

  List drawerItemList = [
    {
      "icon": Icons.person_outline,
      "text": "Profile",
      "screen": Profile(
        customerInfo: customerInfo,
      ),
    },
    {
      "icon": Icons.shopping_cart_outlined,
      "text": "Orders",
      "screen": Orders(),
    },
    {
      "icon": Icons.location_on_outlined,
      "text": "Addresses",
      "screen": AddressPage(
        check: true,
      ),
    },
    {
      "icon": Icons.policy_outlined,
      "text": "Policies",
      "screen": PoliciesPage(),
    },
    {
      "icon": Icons.store_outlined,
      "text": "Store Locator",
      "screen": StoreFinder(),
    },
    {
      "icon": Icons.info_outline,
      "text": "About Us",
      "screen": AboutUs(),
    }
  ];
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .03),
        ),
        child: profilePicture(context, customerInfo),
      ),
      Flexible(
        child: ListView.builder(
            itemCount: (accessToken == "")
                ? drawerItemList.length - 3
                : drawerItemList.length,
            itemBuilder: (context, index) {
              if (accessToken == "") {
                index = index + 3;
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => drawerItemList[index]["screen"],
                      ),
                    );
                  },
                  leading: Icon(drawerItemList[index]["icon"]),
                  title: Text(
                    drawerItemList[index]["text"].toString(),
                  ),
                );
              } else {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => drawerItemList[index]["screen"],
                      ),
                    );
                  },
                  leading: Icon(drawerItemList[index]["icon"]),
                  title: Text(
                    drawerItemList[index]["text"].toString(),
                  ),
                );
              }
            }),
      ),
      Container(
        margin: EdgeInsets.symmetric(
          vertical: dynamicHeight(context, .03),
          horizontal: dynamicWidth(context, .1),
        ),
        child: MaterialButton(
          height: dynamicHeight(context, 0.07),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: myRed,
          onPressed: () {
            if (accessToken == "") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            } else {
              CoolAlert.show(
                context: context,
                type: CoolAlertType.loading,
                backgroundColor: noColor,
              );
              logoutUser(accessToken);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (accessToken == "")
                  ? Icon(
                      Icons.login,
                      color: myWhite,
                      size: dynamicWidth(context, .07),
                    )
                  : Icon(
                      Icons.logout_outlined,
                      color: myWhite,
                      size: dynamicWidth(context, .07),
                    ),
              (accessToken == "")
                  ? Text(
                      "  Sign In",
                      style: TextStyle(
                        color: myWhite,
                        fontSize: dynamicWidth(context, .05),
                      ),
                    )
                  : Text(
                      "  Logout",
                      style: TextStyle(
                        color: myWhite,
                        fontSize: dynamicWidth(context, .05),
                      ),
                    ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget profilePicture(context, customerInfo) {
  return Column(
    children: [
      CircleAvatar(
        radius: dynamicWidth(context, .16),
        backgroundColor: myRed,
        child: ClipOval(
          child: Image.asset(
            "assets/profile.png",
          ),
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, .03),
      ),
      (customerInfo == false || customerInfo == null)
          ? Text(
              "Sign In",
              style: TextStyle(
                fontSize: dynamicWidth(context, .07),
                color: myBlack,
                fontWeight: FontWeight.bold,
              ),
            )
          : Text(
              customerInfo["firstName"] + " " + customerInfo["lastName"],
              style: TextStyle(
                fontSize: dynamicWidth(context, .07),
                color: myBlack,
                fontWeight: FontWeight.bold,
              ),
            )
    ],
  );
}
