import 'package:graphql/client.dart';
import 'package:monark_app/utils/config.dart';

getShopifyCategory() async {
  var shopifyCategory = '''
{
  	collections(first: 250) {
    	edges {
      	node {
        	  id
            title
            handle
            image{
                src
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
    document: gql(shopifyCategory),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    getShopifyCategory();
    print(result.hasException);
    return "Server Error";
  } else {
    return result.data!["collections"]["edges"];
  }
}

getShopifyProducts() async {
  var shopifyProducts = '''
{
  products(first:250) {
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
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options = QueryOptions(
    document: gql(shopifyProducts),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    getShopifyProducts();
    print(result.hasException);
    return "Server Error";
  } else {
    return result.data!["products"]["edges"];
  }
}

getShopifyCollection(handle) async {
  var shopifyCollection = '''
{
  collectionByHandle(handle:"$handle") {
    products(first:250) {
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
}
 ''';
  final HttpLink httpLink = HttpLink(
      "https://monark-clothings.myshopify.com/api/2021-10/graphql.json",
      defaultHeaders: {
        "X-Shopify-Storefront-Access-Token": "fce9486a511f6a4f45939c2c6829cdaa"
      });
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options = QueryOptions(
    document: gql(shopifyCollection),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    getShopifyCollection(handle);
    print(result.hasException);
    return "Server Error";
  } else {
    return result.data!["collectionByHandle"]["products"]["edges"];
  }
}

getUserOrders() async {
  var createUserAccessToken = '''
{
    customer (customerAccessToken: "$globalAccessToken")
    {
         orders(first:5){
             edges{
                 node{
                     orderNumber 
                     email 
                     fulfillmentStatus 
                     cancelReason
                     lineItems(first:5){
                         edges{
                             node{
                                 title
                                 quantity
                                 variant {
                                     product{
                                         images(first:1){
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
    document: gql(createUserAccessToken),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    print(result.hasException);
    return "Server Error";
  } else {
    return result.data!["customer"]["orders"]["edges"];
  }
}
