import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/drawer_items.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  var accessToken;
  Home({Key? key, this.accessToken = ""}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    if (widget.accessToken != "") {
      getUserData(widget.accessToken);
    }
  }

  getUserData(accessToken) async {
    print(accessToken);
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
      print(result.data!["customer"]["id"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar(context, false),
      drawer: SafeArea(
        child: Drawer(
          child: drawerItems(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: dynamicWidth(context, .94),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  searchbar(),
                  SizedBox(
                    height: dynamicHeight(context, .06),
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
                    "New Arrivals",
                    context,
                    function: getShopifyCollection(95736987777),
                    text2: "See all",
                    check: true,
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  cardList(context,
                      function: getShopifyCollection(95736987777)),
                  SizedBox(
                    height: dynamicHeight(context, .04),
                  ),
                  rowText(
                    "Made in Turkey",
                    context,
                    function: getShopifyCollection(95422742657),
                    text2: "See all",
                    check: true,
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  cardList(context,
                      function: getShopifyCollection(95422742657)),
                  SizedBox(
                    height: dynamicHeight(context, .04),
                  ),
                  rowText(
                    "Products",
                    context,
                    text2: "See all",
                    check: true,
                    function: getShopifyProducts(),
                    productCheck: true,
                  ),
                  SizedBox(
                    height: dynamicHeight(context, .02),
                  ),
                  cardList(
                    context,
                    function: getShopifyProducts(),
                    products: true,
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
