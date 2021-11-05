import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/widgets/form_fields.dart';
import 'package:monark_app/widgets/media_query.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(searchText.text);
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: dynamicWidth(context, 0.9),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Hero(
                  tag: "SearchBar",
                  child: Material(
                      child: searchbar(
                          controller: searchText,
                          setstateFunction: () {
                            setState(() {});
                          }))),
            ),
            (searchText.text == "")
                ? Container()
                : detailGrid(getSearchResults(searchText.text), context, false)
          ],
        ),
      )),
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
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options = QueryOptions(
    document: gql(searchResult),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    print(result.hasException);
    return "Server Error";
  } else {
    return result.data!["products"]["edges"];
  }
}
