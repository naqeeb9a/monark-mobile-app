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

import '../config.dart';

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
      await saveUser.remove("loginInfo");
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
            itemCount: drawerItemList.length,
            itemBuilder: (context, index) {
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
                  context, MaterialPageRoute(builder: (context) => Login()));
            } else {
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
        minRadius: dynamicWidth(context, .16),
        backgroundColor: titleRed,
        backgroundImage: NetworkImage(
          "https://www.pngarts.com/files/11/Avatar-Transparent-Background-PNG.png?width=800",
        ),
      ),
      SizedBox(
        height: dynamicHeight(context, .03),
      ),
      (customerInfo == false || customerInfo == null)
          ? Text(
              "Adam Balina",
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
