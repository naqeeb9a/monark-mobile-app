import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

checkLoginStatus(context, Function function) async {
  SharedPreferences saveUser = await SharedPreferences.getInstance();
  if (saveUser.getString("loginInfo") == null) {
    print("clear");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Welcome()),
        (Route<dynamic> route) => false);
  } else {
    function();
  }
}

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
    return "Server Error";
  } else {
    return result.data!["collections"]["edges"];
  }
}

getShopifyProductsBestSelling() async {
  var shopifyProducts = '''
{
  products(first:250 sortKey:BEST_SELLING) {
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
    return "Server Error";
  } else {
    return result.data!["products"]["edges"];
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
        id
        orders(first:10){
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
                                         variants(first:1){
                                        edges{
                                        node{
                                            price     
                                          }
                                        }
                                        }
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
    return "Server Error";
  } else {
    if (result.data!["customer"] == null) {
      return "Token Expired";
    } else {
      return result.data!["customer"]["orders"]["edges"];
    }
  }
}

createDraftOrders(subtotal) async {
  var localOrderList = [];
  for (var i = 0; i < cartItems.length; i++) {
    localOrderList.add({
      "variantId":
          utf8.decode(base64Decode(cartItems[i]["variantId"])).toString(),
      "quantity": (cartItems[i]["quantity"])
    });
  }
  var createUserAccessToken = r'''
mutation draftOrderCreate($input: DraftOrderInput!) {
  draftOrderCreate(input: $input) {
    userErrors {
      field
      message
    }
    draftOrder {
     id
     name
     status
     subtotalPrice
     totalPrice
     customer{
         displayName
         id
         ordersCount
         defaultAddress{
             address1
             city
         }
     }
     billingAddress{
         address1
         city
     }
    }
  }
}
 ''';
  var orderVariables = {
    "input": {
      "customerId": utf8.decode(base64Decode(id)).toString(),
      "note": "Test draft order",
      "email": "$checkOutEmail",
      "tags": ["Ordered via mobile application ANDROID"],
      "shippingLine": {
        "title": "Cash on Delivery",
        "price": (subtotal < 2000) ? 200 : 0
      },
      "shippingAddress": {
        "address1": addressList[group.value]["node"]["address1"].toString(),
        "city": addressList[group.value]["node"]["city"].toString(),
        "province": addressList[group.value]["node"]["province"].toString(),
        "country": addressList[group.value]["node"]["country"].toString(),
        "zip": addressList[group.value]["node"]["zip"].toString()
      },
      "billingAddress": {
        "address1": addressList[group.value]["node"]["address1"].toString(),
        "city": addressList[group.value]["node"]["city"].toString(),
        "province": addressList[group.value]["node"]["province"].toString(),
        "country": addressList[group.value]["node"]["country"].toString(),
        "zip": addressList[group.value]["node"]["zip"].toString()
      },
      "lineItems": localOrderList
    }
  };
  final HttpLink httpLink = HttpLink(
    "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-10/graphql.json",
  );
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options = QueryOptions(
      document: gql(createUserAccessToken), variables: orderVariables);
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    return "Server Error";
  } else {
    print(result.data!["draftOrderCreate"]["draftOrder"]["id"]);
    print(result.data!["draftOrderCreate"]["draftOrder"]["totalPrice"]);
    return result.data!["draftOrderCreate"]["draftOrder"]["id"];
  }
}

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
        "X-Shopify-Storefront-Access-Token": "fce9486a511f6a4f45939c2c6829cdaa"
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
