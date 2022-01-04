import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:graphql/client.dart';
import 'package:monark_app/Screens/Login.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

checkLoginStatus(context, Function function) async {
  SharedPreferences saveUser = await SharedPreferences.getInstance();
  if (saveUser.getString("loginInfo") == null) {
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
  products(first:10 sortKey:BEST_SELLING query: "available_for_sale:true") {
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
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options = QueryOptions(
    document: gql(shopifyProducts),
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    // getShopifyProducts();
    return "Server Error";
  } else {
    return result.data!["products"]["edges"];
  }
}

getShopifyCollection(handle, {sortKey = "", reverse = ""}) async {
  var shopifyCollection;
  var variables = {
    "product_filters": [
      {
        "available": true,
      },
      {
        "price": {"min": lowerPriceFilter, "max": upperPriceFilter}
      }
    ]
  };
  if (sortKey == "") {
    shopifyCollection = r'''
query InStock($product_filters: [ProductFilter!]){''' +
        '''
  	collectionByHandle(handle: "$handle") {''' +
        r'''
    products(first: 250, filters: $product_filters) {
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
}
 ''';
  } else {
    if (reverse == "") {
      shopifyCollection = r'''
query InStock($product_filters: [ProductFilter!]){''' +
          '''
  collectionByHandle(handle:"$handle") {
    products(first:250 sortKey:$sortKey  filters:''' +
          r''' $product_filters) {
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
}
 ''';
    } else {
      shopifyCollection = r'''
query InStock($product_filters: [ProductFilter!]){''' +
          '''
  collectionByHandle(handle:"$handle") {
    products(first:250 sortKey:$sortKey reverse:$reverse  filters:''' +
          r''' $product_filters) {
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
}
 ''';
    }
  }
  final HttpLink httpLink = HttpLink(
      "https://monark-clothings.myshopify.com/api/2022-01/graphql.json",
      defaultHeaders: {
        "X-Shopify-Storefront-Access-Token": "fce9486a511f6a4f45939c2c6829cdaa"
      });
  GraphQLClient client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  final QueryOptions options =
      QueryOptions(document: gql(shopifyCollection), variables: variables);
  final QueryResult result = await client.query(options);

  if (result.hasException) {
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
                     processedAt
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

passwordReset(email) async {
  var reset = r'''
mutation customerRecover($email: String!) {
  customerRecover(email: $email) {
    customerUserErrors {
      code
      field
      message
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
    document: gql(reset),
    variables: {
      "email": email,
    },
  );
  final QueryResult result = await client.query(options);

  if (result.hasException) {
    return "Server Error";
  } else {
    return "done";
  }
}

createDraftOrders(subtotal, {guestCheck = false}) async {
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
  var orderVariables = guestCheck == true
      ? {
          "input": {
            "note": "Test draft order",
            "email": "${guestAddressList[2]}",
            "tags": [
              Platform.isAndroid
                  ? "Unregistered User via Android App"
                  : "Unregistered User via iOS App"
            ],
            "shippingLine": {
              "title": "Cash on Delivery",
              "price": (subtotal < 2000) ? 200 : 0
            },
            "shippingAddress": {
              "address1": guestAddressList[4].toString(),
              "city": guestAddressList[5].toString(),
              "province": guestAddressList[6].toString(),
              "country": guestAddressList[7].toString(),
              "zip": guestAddressList[8].toString()
            },
            "billingAddress": {
              "address1": guestAddressList[4].toString(),
              "city": guestAddressList[5].toString(),
              "province": guestAddressList[6].toString(),
              "country": guestAddressList[7].toString(),
              "zip": guestAddressList[8].toString()
            },
            "lineItems": localOrderList
          }
        }
      : {
          "input": {
            "customerId": utf8.decode(base64Decode(id)).toString(),
            "note": "Test draft order",
            "email": "$checkOutEmail",
            "tags": [
              Platform.isAndroid
                  ? "Registered User via Android App"
                  : "Registered User via iOS App"
            ],
            "shippingLine": {
              "title": "Cash on Delivery",
              "price": (subtotal < 2000) ? 200 : 0
            },
            "shippingAddress": {
              "address1":
                  addressList[group.value]["node"]["address1"].toString(),
              "city": addressList[group.value]["node"]["city"].toString(),
              "province":
                  addressList[group.value]["node"]["province"].toString(),
              "country": addressList[group.value]["node"]["country"].toString(),
              "zip": addressList[group.value]["node"]["zip"].toString()
            },
            "billingAddress": {
              "address1":
                  addressList[group.value]["node"]["address1"].toString(),
              "city": addressList[group.value]["node"]["city"].toString(),
              "province":
                  addressList[group.value]["node"]["province"].toString(),
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
    return result.data!["draftOrderCreate"]["draftOrder"]["id"];
  }
}

getUserData(accessToken, context) async {
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
  } else if (result.data!["customer"] == null) {
    SharedPreferences saveUserEmail = await SharedPreferences.getInstance();
    SharedPreferences saveUserPassword = await SharedPreferences.getInstance();
    await loginUser(saveUserEmail.getString("email"),
        saveUserPassword.getString("password"));
    Phoenix.rebirth(context);
  } else {
    id = result.data!["customer"]["id"];
    checkOutEmail = result.data!["customer"]["email"];
    return result.data!["customer"];
  }
}

orderItems(orderId) async {
  var createUserAccessToken = r'''
mutation draftOrderComplete($id: ID!, $paymentPending: Boolean) {
  draftOrderComplete(id: $id, paymentPending: $paymentPending) {
    draftOrder {
      id
      order {
        id
        name
      }
    }
  }
}
 ''';
  var orderVariables = {"id": "$orderId", "paymentPending": true};
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
    return result.data!["draftOrderComplete"]["draftOrder"]["order"]["name"];
  }
}
