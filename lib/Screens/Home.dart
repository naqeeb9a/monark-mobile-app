import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Search.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/utils/config.dart';
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

  List sliderImage = [
    'https://images.unsplash.com/photo-1577538928305-3807c3993047?ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c2FsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://images.unsplash.com/photo-1607082350899-7e105aa886ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2FsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://media.istockphoto.com/photos/neon-flash-sale-banner-discount-product-advertising-marketing-banner-picture-id1204428300?k=20&m=1204428300&s=612x612&w=0&h=gmBsK52vSWsOR5qj_lXr9R43RAhP5k1WIn8igeua4BA=',
    'https://www.sanasafinaz.com/media/catalog/category/Sale-inner-Banner_1.jpg',
  ];

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
        globalAccessToken = widget.accessToken;

        _loading = false;
      });
    }
  }

  var customerInfo;

  getUserData(accessToken) async {
    globalAccessToken = accessToken;
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
      return "Server Error";
    } else {
      id = result.data!["customer"]["id"];
      checkOutEmail = result.data!["customer"]["email"];
      return result.data!["customer"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
            body: Center(
              child: JumpingDotsProgressIndicator(
                numberOfDots: 5,
                fontSize: dynamicWidth(context, .08),
              ),
            ),
          )
        : Scaffold(
            backgroundColor: myGrey,
            appBar: bar(context, false),
            drawer: SafeArea(
              child: (globalAccessToken == "")
                  ? Drawer(
                      child: drawerItems(
                        context,
                      ),
                    )
                  : FutureBuilder(
                      future: getUserData(globalAccessToken),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Drawer(
                            child: (snapshot.data == "Server Error")
                                ? Center(
                                    child: SizedBox(
                                      height: dynamicHeight(context, .25),
                                      child: Image.asset(
                                          "assets/network_error.png"),
                                    ),
                                  )
                                : drawerItems(context,
                                    customerInfo: snapshot.data,
                                    accessToken: globalAccessToken),
                          );
                        } else {
                          return Drawer(
                            child: JumpingDotsProgressIndicator(
                              numberOfDots: 5,
                              fontSize: dynamicWidth(context, .08),
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
                          height: dynamicHeight(context, .01),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ),
                            );
                          },
                          child: Hero(
                            tag: "SearchBar",
                            child: Material(
                              color: noColor,
                              child: searchbar(context, enabled: false),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: dynamicHeight(context, .02),
                        ),
                        // homeSlider(
                        //   context,
                        //   dynamicHeight(context, .22),
                        //   sliderImage.length,
                        //   .9,
                        //   sliderImage,
                        //   true,
                        // ),
                        // SizedBox(
                        //   height: dynamicHeight(context, .02),
                        // ),
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
