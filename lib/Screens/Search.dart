import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool loading = false;
  dynamic futureSearchData = "";
  TextEditingController searchText = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    globalContextSearch = context;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        menuIcon: true,
        bgColor: noColor,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: dynamicWidth(context, .02),
                left: dynamicWidth(context, .02),
                right: dynamicWidth(context, .02),
              ),
              child: Hero(
                tag: "SearchBar",
                child: Material(
                  color: noColor,
                  child: searchbar(
                    context,
                    controller: searchText,
                    setStateFunction: () async {
                      setState(() {
                        loading = true;
                      });
                      futureSearchData =
                          await getSearchResults(searchText.text);
                      setState(() {
                        loading = false;
                      });
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dynamicHeight(context, 0.01)),
                child: searchText.text == ""
                    ? Image.asset(
                        "assets/icons/searchIcon.png",
                        color:
                            darkTheme == true ? myRed : myBlack.withOpacity(.1),
                        scale: 1.8,
                      )
                    : (loading == true)
                        ? Image.asset(
                            "assets/loader.gif",
                            scale: 4,
                          )
                        : futureSearchData == "Server Error"
                            ? Center(
                                child:
                                    retryFunction(context, function: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  futureSearchData =
                                      await getSearchResults(searchText.text);
                                  print(futureSearchData);
                                  setState(() {
                                    loading = false;
                                  });
                                }),
                              )
                            : futureSearchData.length == 0
                                ? Center(
                                    child: Text(
                                      "No Products Found",
                                      style: TextStyle(
                                        color: darkTheme == true
                                            ? myWhite
                                            : myBlack,
                                        fontSize: dynamicWidth(context, .05),
                                      ),
                                    ),
                                  )
                                : customGrid(
                                    context,
                                    true,
                                    false,
                                    futureSearchData,
                                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

getSearchResults(query) async {
  var searchResult = '''
{
  products(first:250 sortKey:RELEVANCE query:"$query") {
    edges {
      node {
        id
        description
        title
        productType
        availableForSale
        totalInventory
        variants(first :10){
            edges{
                node
                {
                    id
                    price
                    sku
                    compareAtPrice
                    requiresShipping
                    availableForSale
                }
            }
        }
        options{
            values
        }
        images(first:10){
            edges{
                node{
                    src
                }
            }
        }
      }
    }
  }
}
 ''';
  final HttpLink httpLink = HttpLink(
      "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
      defaultHeaders: {
        "X-Shopify-Storefront-Access-Token": "fce9486a511f6a4f45939c2c6829cdaa"
      });
  GraphQLClient client = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
  final QueryOptions options = QueryOptions(
    document: gql(searchResult),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    getSearchResults(query);
    return "Server Error";
  } else {
    return result.data!["products"]["edges"];
  }
}
