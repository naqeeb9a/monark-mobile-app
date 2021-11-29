import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
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
  TextEditingController searchText = TextEditingController();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: myWhite,
      appBar: bar(
        context,
        menuIcon: true,
        bgColor: myWhite,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      setStateFunction: () {
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              searchText.text == ""
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .2),
                      ),
                      child: Image.asset(
                        "assets/icons/searchIcon.png",
                        color: myBlack,
                        height: dynamicHeight(context, .3),
                      ),
                    )
                  : detailGrid(
                      getSearchResults(searchText.text),
                      context,
                      false,
                    ),
            ],
          ),
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
