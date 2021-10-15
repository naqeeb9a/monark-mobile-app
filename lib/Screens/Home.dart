import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Detailpage.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/SeeAll.dart';

import 'Orders.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context),
      drawer: SafeArea(
        child: Container(
          color: Colors.white,
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
                    array: imageArray,
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
                rowText("Featured", context,
                    array: featuredArray, text2: "See all", check: true),
                SizedBox(
                  height: 20,
                ),
                cardList(context, featuredArray),
                SizedBox(
                  height: 20,
                ),
                rowText("Best Sell", context,
                    array: bestSell, text2: "See all", check: true),
                SizedBox(
                  height: 20,
                ),
                cardList(context, bestSell),
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
      iconTheme: IconThemeData(color: Colors.black),
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
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(Icons.shopping_bag_outlined));
              }))
            ]
          : [
              IconButton(onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }, icon: Obx(() {
                return Badge(
                    badgeContent: Text(
                      cartItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(Icons.shopping_bag_outlined));
              })),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_list,
                ),
              )
            ],
    ),
  );
}

Widget searchbar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
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
    {array, text2 = "", bool check = false, bool categoryCheck = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                              array: array,
                            )));
              },
              child: Text(
                text2,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : Container()
    ],
  );
}

Widget categoryList(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    child: ListView.builder(
        itemCount: imageArray.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: categoryCards(context, imageArray[index]["title"],
                imageArray[index]["imageUrl"]),
          );
        }),
  );
}

Widget categoryCards(BuildContext context, imageText, imageUrl) {
  return InkWell(
    onTap: () {},
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.1,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(),
              )),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Text(
              imageText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            color: Colors.black26,
          ),
        )
      ],
    ),
  );
}

Widget cardList(context, array) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.28,
    child: ListView.builder(
        itemCount: featuredArray.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: basicCards(context, array[index]["imageUrl"],
                array[index]["price"], array[index]["title"]),
          );
        }),
  );
}

Widget basicCards(context, imageUrl, price, text) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    image: imageUrl,
                    price: price,
                    text: text,
                  )));
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width / 3,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(text),
      ],
    ),
  );
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
    {"icon": Icons.info_outline, "text": "About Us", "screen": Orders()}
  ];
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      CircleAvatar(
        minRadius: 50,
        backgroundColor: Colors.red,
        backgroundImage: NetworkImage(
            "https://cdn.allthings.how/wp-content/uploads/2020/11/allthings.how-how-to-change-your-picture-on-zoom-profile-picture-759x427.png?width=800"),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        "Adam Balina",
        style: TextStyle(
            fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
      ),
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
          color: Colors.blue,
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              Text(
                "  Logout",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
    ],
  );
}
