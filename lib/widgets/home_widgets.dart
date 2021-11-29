import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/config.dart';
import 'drawer_items.dart';
import 'media_query.dart';

ValueNotifier<bool> isDialOpen = ValueNotifier(false);

Widget cardList(context, {function}) {
  return FutureBuilder(
    future: function,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.done &&
          snapshot.data != null) {
        if (snapshot.data == "Server Error") {
          return SizedBox(
            height: dynamicHeight(context, .25),
            child: Image.asset("assets/network_error.png"),
          );
        } else {
          return SizedBox(
            height: dynamicHeight(context, .4),
            child: ListView.builder(
              itemCount: (snapshot.data as List).length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: dynamicWidth(context, 0.018),
                  ),
                  child: basicCards(
                    context,
                    snapshot.data[index]["node"]["images"]["edges"],
                    snapshot.data[index]["node"]["title"],
                    snapshot.data[index]["node"]["availableForSale"],
                    variantProduct: snapshot.data[index]["node"]["variants"]
                        ["edges"],
                    sizeOption: snapshot.data[index]["node"]["options"][0]
                        ["values"],
                    description: snapshot.data[index]["node"]["description"],
                    check:
                        snapshot.data[index]["node"]["availableForSale"] == true
                            ? false
                            : true,
                  ),
                );
              },
            ),
          );
        }
      } else {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.28,
          child: Image.asset(
            "assets/loader.gif",
            scale: 6,
          ),
        );
      }
    },
  );
}

discountPrice(before, after) {
  var a = before - after;
  var b = a / before;
  var c = b * 100;
  return c;
}

Widget basicCards(context, imageUrl, text, availableForSale,
    {sizeOption = "",
    description = "No Description",
    variantProduct = "",
    categoriesCheck = false,
    check = false}) {
  return (check == true)
      ? InkWell(
          onTap: () {
            var snackBar = SnackBar(
              backgroundColor: myRed,
              content: Text("Product's Out of Stock"),
              duration: const Duration(milliseconds: 1000),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              internalWidgetCard(
                  context, imageUrl, variantProduct, text, categoriesCheck,
                  outOfStock: true),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    dynamicWidth(context, .03),
                  ),
                  color: myBlack.withOpacity(.4),
                ),
                height: dynamicHeight(context, .86),
                width: dynamicWidth(context, 0.46),
                child: Image.asset(
                  "assets/soldOut.png",
                  scale: 2.6,
                ),
              )
            ],
          ),
        )
      : InkWell(
          onTap: (categoriesCheck == true)
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAll(
                        text: text,
                        function: getShopifyCollection(availableForSale),
                        check: false,
                      ),
                    ),
                  );
                }
              : () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                              image: imageUrl,
                              variantProduct: variantProduct,
                              text: text,
                              array: sizeOption,
                              description: description,
                              availableForSale: availableForSale)));
                },
          child: internalWidgetCard(
              context, imageUrl, variantProduct, text, categoriesCheck));
}

Widget internalWidgetCard(
    context, imageUrl, variantProduct, text, categoriesCheck,
    {outOfStock = false}) {
  return Container(
    margin: (outOfStock == true) ? EdgeInsets.all(5) : EdgeInsets.all(0),
    width: (outOfStock == true)
        ? dynamicWidth(context, 0.45)
        : dynamicWidth(context, 0.47),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, .08),
              ),
              child: Container(
                height: dynamicHeight(context, .34),
                width: dynamicWidth(context, .47),
                color: myWhite,
                child: CachedNetworkImage(
                  imageUrl: categoriesCheck == true
                      ? imageUrl
                      : imageUrl[0]["node"]["src"],
                  fit: BoxFit.cover,
                  placeholder: (context, string) {
                    return Image.asset(
                      "assets/loader.gif",
                      scale: 6,
                    );
                  },
                ),
              ),
            ),
            (categoriesCheck == true)
                ? Container()
                : Positioned(
                    bottom: 15,
                    right: 15,
                    child: CircleAvatar(
                      radius: dynamicWidth(context, 0.04),
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.favorite,
                        size: dynamicWidth(context, 0.05),
                        color: myRed,
                      ),
                    ),
                  )
          ],
        ),
        categoriesCheck == true
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontSize: dynamicWidth(context, .04),
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: darkTheme == true ? myWhite : myBlack,
                    fontSize: dynamicWidth(context, .03),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
        categoriesCheck == true
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (variantProduct[0]["node"]["compareAtPrice"] ==
                          variantProduct[0]["node"]["price"])
                      ? Text(
                          "Pkr. " +
                              double.parse(variantProduct[0]["node"]["price"])
                                  .toInt()
                                  .toString(),
                          style: TextStyle(
                            color: darkTheme == true ? myWhite : myBlack,
                            fontWeight: FontWeight.w600,
                            fontSize: dynamicWidth(context, .034),
                          ),
                        )
                      : Text(
                          "Pkr. " +
                              double.parse(variantProduct[0]["node"]
                                      ["compareAtPrice"])
                                  .toInt()
                                  .toString(),
                          style: TextStyle(
                            color: darkTheme == true ? myWhite : myBlack,
                            decoration: TextDecoration.lineThrough,
                            fontSize: dynamicWidth(context, .034),
                          ),
                        ),
                  (variantProduct[0]["node"]["compareAtPrice"] ==
                          variantProduct[0]["node"]["price"])
                      ? Container()
                      : Text(
                          "Pkr. " +
                              double.parse(variantProduct[0]["node"]["price"])
                                  .toInt()
                                  .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: dynamicWidth(context, .034),
                            color: darkTheme == true ? myWhite : myRed,
                          ),
                        )
                ],
              ),
        SizedBox(
          height: dynamicHeight(context, 0.01),
        ),
      ],
    ),
  );
}

Widget floatingButton(context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    openCloseDial: isDialOpen,
    backgroundColor: myRed,
    overlayColor: myGrey,
    overlayOpacity: 0.5,
    spacing: dynamicHeight(context, .01),
    spaceBetweenChildren: dynamicHeight(context, .01),
    closeManually: true,
    children: [
      SpeedDialChild(
        onTap: () {
          print("object");
          launch(
            "whatsapp://send?phone=+923036663017&text=Hi",
            forceSafariVC: false,
            forceWebView: false,
          );
        },
        elevation: 2.0,
        child: CircleAvatar(
          backgroundColor: myWhite,
          radius: dynamicWidth(context, .1),
          backgroundImage: AssetImage(
            "assets/whatsapp.png",
          ),
        ),
      ),
      SpeedDialChild(
        onTap: () {
          launch(
            "http://m.me/monark.com.pk?ref=mobile_app",
            forceSafariVC: false,
            forceWebView: false,
          );
        },
        elevation: 2.0,
        child: CircleAvatar(
          backgroundColor: myWhite,
          radius: dynamicWidth(context, .1),
          backgroundImage: AssetImage(
            "assets/messenger.png",
          ),
        ),
      ),
    ],
  );
}

Widget rowText(text, context, {function = "", check = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: TextStyle(
          color: darkTheme == true ? myWhite : myBlack,
          fontSize: dynamicWidth(context, .092),
          fontWeight: FontWeight.w900,
        ),
      ),
      check == true
          ? InkWell(
              onTap: function == "" ? () {} : function,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .01),
                  horizontal: dynamicWidth(context, .02),
                ),
                child: Image.asset("assets/icons/filterIcon.png"),
              ),
            )
          : Container()
    ],
  );
}

dynamic imageAlert(context, image, assetImage) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            dynamicWidth(
              context,
              dynamicWidth(context, .03),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            dynamicWidth(context, .03),
          ),
          child: Stack(
            children: [
              Hero(
                tag: 1,
                child: InteractiveViewer(
                  child: assetImage == true
                      ? Image.asset(
                          image,
                          width: dynamicWidth(context, .96),
                          fit: BoxFit.fitHeight,
                        )
                      : CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.fitWidth,
                          width: dynamicWidth(context, .96),
                          height: dynamicHeight(context, .8),
                          placeholder: (context, string) {
                            return Image.asset(
                              "assets/loader.gif",
                              scale: 4,
                            );
                          },
                        ),
                ),
              ),
              Container(
                width: dynamicWidth(context, 1),
                height: dynamicHeight(context, .05),
                color: noColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: dynamicWidth(context, .02),
                      ),
                      child: ColoredBox(
                        color: myWhite,
                        child: Icon(
                          Icons.clear,
                          color: myRed,
                          size: dynamicWidth(context, .08),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget homeSlider(
  context,
  height,
  length,
  viewFraction,
  image,
  bool detail,
) {
  return CarouselSlider.builder(
    itemCount: length,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        detail == true
            ? sliderContainer(context, image[itemIndex], detail)
            : InkWell(
                onTap: () {
                  imageAlert(
                    context,
                    image[itemIndex]["node"]["src"].toString(),
                    detail,
                  );
                },
                child: sliderContainer(
                  context,
                  image[itemIndex]["node"]["src"].toString(),
                  detail,
                ),
              ),
    options: CarouselOptions(
      enableInfiniteScroll: detail,
      height: height,
      enlargeCenterPage: true,
      viewportFraction: viewFraction,
      autoPlay: detail,
      autoPlayInterval: Duration(seconds: 6),
      autoPlayAnimationDuration: Duration(seconds: 2),
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
    ),
  );
}

Widget sliderContainer(context, String image, bool detail) {
  return Container(
    width: dynamicWidth(context, 1),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .08),
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(
        detail == false
            ? dynamicWidth(context, 0.0)
            : dynamicWidth(context, .08),
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.fill,
        placeholder: (context, string) {
          return Image.asset(
            "assets/loader.gif",
            scale: 6,
          );
        },
      ),
    ),
  );
}

Widget drawer(context) {
  return SizedBox(
    width: dynamicWidth(context, .54),
    child: Drawer(
      child: drawerItems(
        context,
      ),
    ),
  );
}
