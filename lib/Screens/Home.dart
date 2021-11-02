import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/drawer_items.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  var accessToken;
  Home({Key? key, this.accessToken = ""}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _loading = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    setState(() {
      _loading = true;
    });
  }

  checkLoginStatus() async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    if (saveUser.getString("loginInfo") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Welcome()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        widget.accessToken = saveUser.getString("loginInfo");
        print(widget.accessToken);
        _loading = false;
      });
    }
  }

  var customerinfo;
  getUserData(accessToken) async {
    var createUserAccessToken = '''
{
    customer (customerAccessToken: "$accessToken")
    {
         id
         email
         defaultAddress{
             address1
         }
         phone
         firstName
         lastName
    }
}
 ''';
    final HttpLink httpLink = HttpLink(
        "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
        defaultHeaders: {
          "X-Shopify-Storefront-Access-Token":
              "fce9486a511f6a4f45939c2c6829cdaa"
        });
    GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
    final QueryOptions options = QueryOptions(
      document: gql(createUserAccessToken),
    );
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.hasException);
      return "Server Error";
    } else {
      return result.data!["customer"];
    }
  }

  @override
  Widget build(BuildContext context) {
    // getShopifyProducts();
    return (_loading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                fontSize: 20,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: myGrey,
            appBar: bar(context, false),
            drawer: SafeArea(
              child: (widget.accessToken == "")
                  ? Drawer(
                      child: drawerItems(
                        context,
                      ),
                    )
                  : FutureBuilder(
                      future: getUserData(widget.accessToken),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Drawer(
                            child: drawerItems(context,
                                customerInfo: snapshot.data,
                                accessToken: widget.accessToken),
                          );
                        } else {
                          return Drawer(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 20,
                            ),
                          );
                        }
                      }),
            ),
            body: SafeArea(
              child: Center(
                child: Container(
                  width: dynamicWidth(context, .94),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: dynamicHeight(context, .03),
                        ),
                        searchbar(),
                        SizedBox(
                          height: dynamicHeight(context, .03),
                        ),
                        rowText(
                          "Categories",
                          context,
                          function: getShopifyCategory(),
                          text2: "See all",
                          check: true,
                          categoryCheck: true,
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        categoryList(context),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        rowText(
                          "Suits",
                          context,
                          function: getShopifyCollection("suits"),
                          text2: "See all",
                          check: true,
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        cardList(context,
                            function: getShopifyCollection("suits")),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        rowText(
                          "Made In Turkey",
                          context,
                          function: getShopifyCollection("made-in-turkey"),
                          text2: "See all",
                          check: true,
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        cardList(context,
                            function: getShopifyCollection("made-in-turkey")),
                        SizedBox(
                          height: dynamicHeight(context, .04),
                        ),
                        rowText(
                          "Products",
                          context,
                          text2: "See all",
                          check: true,
                          function: getShopifyProducts(),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        cardList(
                          context,
                          function: getShopifyProducts(),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: floatingButton(context),
          );
  }
}
