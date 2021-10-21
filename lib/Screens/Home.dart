import 'dart:convert';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/AboutUs.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Detailpage.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:http/http.dart' as http;
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/config.dart';
import 'Orders.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context),
      drawer: SafeArea(
        child: Container(
          color: myWhite,
          child: Drawer(child: drawerItems(context)),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                searchbar(),
                SizedBox(
                  height: 30,
                ),
                rowText("Categories", context,
                    function: getShopifyCategory(),
                    text2: "See all",
                    check: true,
                    categoryCheck: true),
                SizedBox(
                  height: 20,
                ),
                categoryList(context),
                SizedBox(
                  height: 20,
                ),
                rowText("New Arrivals", context,
                    function: getShopifyCollection(95736987777),
                    text2: "See all",
                    check: true),
                SizedBox(
                  height: 20,
                ),
                cardList(context, function: getShopifyCollection(95736987777)),
                SizedBox(
                  height: 20,
                ),
                rowText("Made in Turkey", context,
                    function: getShopifyCollection(95422742657),
                    text2: "See all",
                    check: true),
                SizedBox(
                  height: 20,
                ),
                cardList(context, function: getShopifyCollection(95422742657)),
                SizedBox(
                  height: 20,
                ),
                rowText("Products", context,
                    text2: "See all",
                    check: true,
                    function: getShopifyProducts(),
                    productCheck: true),
                SizedBox(
                  height: 20,
                ),
                cardList(context,
                    function: getShopifyProducts(), products: true)
                // detailGrid(getShopifyProducts(), context, false)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

PreferredSizeWidget bar(context, {check = false}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: AppBar(
      backgroundColor: Colors.transparent,
      leading: (check == true)
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_outlined))
          : null,
      iconTheme: IconThemeData(color: myBlack),
      elevation: 0,
      actions: (check == true)
          ? [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined)),
              IconButton(onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }, icon: Obx(() {
                return Badge(
                    badgeContent: Text(
                      cartItems.length.toString(),
                      style: TextStyle(color: myWhite),
                    ),
                    child: Icon(Icons.shopping_bag_outlined));
              }))
            ]
          : [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
                icon: Obx(
                  () {
                    return Badge(
                        badgeContent: Text(
                          cartItems.length.toString(),
                          style: TextStyle(color: myWhite),
                        ),
                        child: Icon(Icons.shopping_bag_outlined));
                  },
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_list,
                ),
              ),
            ],
    ),
  );
}

Widget searchbar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
        color: myWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: myGrey,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(2, 2))
        ]),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(Icons.search_sharp),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                hintText: "Search Your Product"),
          ),
        )
      ],
    ),
  );
}

Widget rowText(text, context,
    {function,
    text2 = "",
    bool check = false,
    bool categoryCheck = false,
    productCheck = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      (check == true)
          ? InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SeeAll(
                              check: categoryCheck,
                              text: text,
                              function: function,
                              checkProducts: productCheck,
                            )));
              },
              child: Text(
                text2,
              ),
            )
          : Container()
    ],
  );
}

getShopifyCategory() async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/smart_collections.json"));
  var jsonData = jsonDecode(response.body);
  return jsonData["smart_collections"];
}

Widget categoryList(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    child: FutureBuilder(
      future: getShopifyCategory(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return ListView.builder(
              itemCount: (snapshot.data as List).length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: categoryCards(context, snapshot.data[index]["title"],
                      snapshot.data[index]["id"]),
                );
              });
        } else {
          return Image.asset(
            "assets/loader.gif",
            scale: 7,
          );
        }
      },
    ),
  );
}

Widget categoryCards(
  context,
  imageText,
  id, {
  check = false,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeeAll(
                  text: imageText,
                  function: getShopifyCollection(id),
                  check: false)));
    },
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: (check == true)
                ? null
                : MediaQuery.of(context).size.width * 0.3,
            height: (check == true)
                ? null
                : MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0)),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.all(8),
            width: (check == true)
                ? null
                : MediaQuery.of(context).size.width * 0.3,
            height: (check == true)
                ? null
                : MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Text(
              imageText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myWhite,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            color: myBlack,
          ),
        )
      ],
    ),
  );
}

getShopifyProducts() async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/products.json"));
  var jsonData = jsonDecode(response.body);
  return jsonData["products"];
}

Widget cardList(context, {function, products}) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: ListView.builder(
              itemCount: (snapshot.data as List).length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: (products == true)
                      ? basicCards(
                          context,
                          snapshot.data[index]["image"]["src"],
                          snapshot.data[index]["title"],
                          price: double.parse(
                                  snapshot.data[index]["variants"][0]["price"])
                              .toInt()
                              .toString(),
                          sizeOption: snapshot.data[index]["options"][0]
                              ["values"],
                          description:
                              snapshot.data[index]["body_html"].toString())
                      : basicCards(
                          context,
                          snapshot.data[index]["image"]["src"],
                          snapshot.data[index]["title"],
                          id: snapshot.data[index]["id"],
                          description: snapshot.data[index]["body_html"].toString()),
                );
              }),
        );
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          child: Image.asset(
            "assets/loader.gif",
            scale: 7,
          ),
        );
      }
    },
  );
}

Widget basicCards(context, imageUrl, text,
    {price = "fetching ...",
    sizeOption = "",
    id = 0,
    description =
        "A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart. I am alone, and feel the charm of existence in this spot, which was created for the bliss of souls like mine."}) {
  return InkWell(
    onTap: () {
      if (price.contains("fetching")) {
        var snackBar = SnackBar(
          content: Text("Price is still fetching ......."),
          duration: const Duration(milliseconds: 1000),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
      
                      price: price,
                      text: text,
                      array: sizeOption,
                      description: description,
                    )));
      }
    },
    child: Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, string) {
                  return Image.asset(
                    "assets/loader.gif",
                    scale: 7,
                  );
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: (id != 0)
                  ? FutureBuilder(
                      future: getPriceOfCollection(id),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          price = snapshot.data[0];
                          sizeOption = snapshot.data[1];
                          return Text(
                            "Rs. " + double.parse(price).toInt().toString(),
                            style: TextStyle(fontWeight: FontWeight.w500),
                          );
                        } else {
                          price = "fetching ...";
                          return Text("fetching ...");
                        }
                      })
                  : Text(
                      "Rs. " + price.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

getPriceOfCollection(id) async {
  var response = await http.get(Uri.parse(
      "https://32a2c56e6eeee31171cc4cb4349c2329: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@monark-clothings.myshopify.com/admin/api/2021-07/products/$id.json"));
  var jsonData = jsonDecode(response.body);
  return [
    jsonData["product"]["variants"][0]["price"],
    jsonData["product"]["options"][0]["values"]
  ];
}

Widget drawerItems(context) {
  List drawerItemList = [
    {"icon": Icons.person_outline, "text": "Profile", "screen": Profile()},
    {
      "icon": Icons.shopping_cart_outlined,
      "text": "Orders",
      "screen": Orders()
    },
    {
      "icon": Icons.notifications_outlined,
      "text": "Notifications",
      "screen": Orders()
    },
    {"icon": Icons.help_outline, "text": "Help", "screen": Orders()},
    {"icon": Icons.star_outline, "text": "Rate Us", "screen": Orders()},
    {"icon": Icons.info_outline, "text": "About Us", "screen": AboutUs()}
  ];
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      profilePicture(),
      SizedBox(
        height: 10,
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
                          builder: (context) =>
                              drawerItemList[index]["screen"]));
                },
                leading: Icon(drawerItemList[index]["icon"]),
                title: Text(drawerItemList[index]["text"].toString()),
              );
            }),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
        child: MaterialButton(
          height: MediaQuery.of(context).size.height * 0.07,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: myRed,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Welcome(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_outlined,
                color: myWhite,
              ),
              Text(
                "  Logout",
                style: TextStyle(color: myWhite),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Widget profilePicture() {
  return Column(
    children: [
      CircleAvatar(
        minRadius: 50,
        backgroundColor: titleRed,
        backgroundImage: NetworkImage(
            "https://cdn.allthings.how/wp-content/uploads/2020/11/allthings.how-how-to-change-your-picture-on-zoom-profile-picture-759x427.png?width=800"),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Adam Balina",
        style: TextStyle(
            fontSize: 25, color: myBlack, fontWeight: FontWeight.bold),
      )
    ],
  );
}
