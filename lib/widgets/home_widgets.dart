import 'package:another_xlider/another_xlider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/shopify_functions.dart';

import '../utils/config.dart';
import 'drawer_items.dart';
import 'media_query.dart';

Widget basicCards(context, imageUrl, text, availableForSale,
    {sizeOption = "",
    description = "No Description",
    variantProduct = "",
    productType = "",
    categoriesCheck = false,
    check = false,
    wishList = "",
    refreshScreen = ""}) {
  return (check == true)
      ? InkWell(
          onTap: () {
            var snackBar = SnackBar(
              backgroundColor: myRed,
              content: Text("Product Out of Stock"),
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
              Image.asset(
                "assets/soldOut.png",
                scale: 2.6,
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
                        availableForSale: availableForSale,
                        productType: productType,
                      ),
                    ),
                  );
                },
          child: internalWidgetCard(
              context, imageUrl, variantProduct, text, categoriesCheck,
              wishList: wishList, refreshScreen: refreshScreen),
        );
}

Widget internalWidgetCard(
    context, imageUrl, variantProduct, text, categoriesCheck,
    {outOfStock = false, wishList = "", refreshScreen = ""}) {
  return Container(
    margin: EdgeInsets.all(0),
    width: dynamicWidth(context, 0.47),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, .06),
              ),
              child: Container(
                height: dynamicHeight(context, .32),
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
            categoriesCheck == true
                ? Container()
                : Positioned(
                    bottom: dynamicHeight(context, 0.02),
                    right: dynamicWidth(context, 0.04),
                    child: GestureDetector(
                      onTap: () {
                        var check = "";

                        if (wishListItems.length == 0) {
                          wishListItems.insert(0, wishList);
                          var snackBar = SnackBar(
                            content: Text(
                              'Item Added to Wish List',
                              style: TextStyle(
                                color: darkTheme == false ? myWhite : myBlack,
                              ),
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor:
                                darkTheme == true ? myWhite : myBlack,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          for (int i = 0; i < wishListItems.length; i++) {
                            if (wishListItems[i]["node"]["id"] ==
                                wishList["node"]["id"]) {
                              wishListItems.removeAt(i);
                              check = "no";
                            } else {
                              wishListItems.insert(0, wishList);
                              check = "ok";
                              break;
                            }
                          }
                          if (check == "ok") {
                            var snackBar = SnackBar(
                              content: Text(
                                'Item Added to Wish List',
                                style: TextStyle(
                                  color: darkTheme == false ? myWhite : myBlack,
                                ),
                              ),
                              duration: const Duration(seconds: 1),
                              backgroundColor:
                                  darkTheme == true ? myWhite : myBlack,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (check == "no") {
                            var snackBar = SnackBar(
                              content: Text(
                                'Item Removed from Wish List',
                                style: TextStyle(
                                  color: darkTheme == false ? myWhite : myBlack,
                                ),
                              ),
                              duration: const Duration(seconds: 1),
                              backgroundColor:
                                  darkTheme == true ? myWhite : myBlack,
                            );
                            refreshScreen();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: CircleAvatar(
                        radius: dynamicWidth(context, 0.04),
                        backgroundColor: myWhite,
                        child: Icon(
                          Icons.favorite,
                          size: dynamicWidth(context, 0.05),
                          color: myRed,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        categoriesCheck == true
            ? Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: "Aeonik",
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
                              variantProduct[0]["node"]["price"] ||
                          variantProduct[0]["node"]["compareAtPrice"] == null)
                      ? Text(
                          "Pkr. " +
                              double.parse(variantProduct[0]["node"]["price"])
                                  .toInt()
                                  .toString(),
                          style: TextStyle(
                            fontFamily: "Aeonik",
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
                            fontFamily: "Aeonik",
                            color: darkTheme == true ? myWhite : myBlack,
                            decoration: TextDecoration.lineThrough,
                            fontSize: dynamicWidth(context, .034),
                          ),
                        ),
                  (variantProduct[0]["node"]["compareAtPrice"] ==
                              variantProduct[0]["node"]["price"] ||
                          variantProduct[0]["node"]["compareAtPrice"] == null)
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
      ],
    ),
  );
}

Widget rowText(text, context, {function = "", check = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: dynamicWidth(context, .78),
        child: AutoSizeText(
          text,
          style: TextStyle(
            fontFamily: "Aeonik",
            color: darkTheme == true ? myWhite : myBlack,
            fontSize: dynamicWidth(context, .092),
            fontWeight: FontWeight.w800,
          ),
          maxLines: 1,
        ),
      ),
      check == true
          ? InkWell(
              onTap: () {
                filterContainer(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dynamicHeight(context, .01),
                  horizontal: dynamicWidth(context, .02),
                ),
                child: Image.asset(
                  "assets/icons/filterIcon.png",
                  color: darkTheme == true ? myWhite : myRed,
                  width: dynamicWidth(context, .07),
                ),
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
                          width: dynamicWidth(context, 1),
                          fit: BoxFit.fitHeight,
                        )
                      : CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.fitWidth,
                          width: dynamicWidth(context, .96),
                          height: dynamicHeight(context, .5),
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

Widget homeSlider(context, height, length, viewFraction, image, bool detail,
    {function = "", page = ""}) {
  return CarouselSlider.builder(
    itemCount: length,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        detail == true
            ? sliderContainer(context, image[itemIndex], detail)
            : InkWell(
                onTap: page == "" ? () {} : page,
                child: sliderContainer(
                  context,
                  image[itemIndex]["node"]["src"].toString(),
                  detail,
                ),
              ),
    options: CarouselOptions(
      enableInfiniteScroll: detail,
      height: height,
      onPageChanged: (function != "")
          ? (index, value) {
              function(index);
            }
          : null,
      enlargeCenterPage: true,
      viewportFraction: viewFraction,
      autoPlay: detail,
      autoPlayInterval: Duration(seconds: 6),
      autoPlayAnimationDuration: Duration(seconds: 2),
      aspectRatio: 2.0,
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
    ),
  );
}

Widget sliderContainer(context, String image, bool detail) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(
      detail == false ? dynamicWidth(context, 0.0) : dynamicWidth(context, .08),
    ),
    child: InteractiveViewer(
      child: CachedNetworkImage(
        imageUrl: image,
        // fit: detail == false ? BoxFit.fitHeight : BoxFit.cover,
        fit: BoxFit.cover,
        width: dynamicWidth(context, 1),
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
  return Container(
    width: dynamicWidth(context, .54),
    child: Drawer(
      child: drawerItems(
        context,
      ),
    ),
  );
}

String titleCase(String text) {
  if (text.length <= 1) return text.toUpperCase();
  var words = text.split(' ');
  var capitalized = words.map((word) {
    var first = word.substring(0, 1).toUpperCase();
    var rest = word.substring(1);
    return '$first$rest';
  });
  return capitalized.join(' ');
}

filterContainer(context) {
  dynamic _lowerValue = 0.obs;
  dynamic _upperValue = 0.obs;

  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, StateSetter setState) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    dynamicWidth(context, .08),
                  ),
                ),
                child: Container(
                  height: dynamicHeight(context, .9),
                  width: dynamicWidth(context, .84),
                  decoration: BoxDecoration(
                    color: darkTheme == true ? darkThemeBlack : myWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        dynamicWidth(context, .08),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: dynamicHeight(context, .03),
                                horizontal: dynamicWidth(context, .08),
                              ),
                              child: Image.asset(
                                "assets/icons/crossIcon.png",
                                color: darkTheme == true ? myWhite : myRed,
                                height: dynamicHeight(context, .026),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: dynamicWidth(context, .08),
                              top: dynamicHeight(context, .01),
                              bottom: dynamicHeight(context, .01),
                            ),
                            child: Text(
                              "Sort By",
                              style: TextStyle(
                                fontFamily: "Aeonik",
                                fontSize: dynamicWidth(context, .04),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: dynamicWidth(context, .26),
                              top: dynamicHeight(context, .01),
                              bottom: dynamicHeight(context, .01),
                            ),
                            child: Text(
                              "Size",
                              style: TextStyle(
                                fontFamily: "Aeonik",
                                fontSize: dynamicWidth(context, .04),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: dynamicWidth(context, .4),
                            height: dynamicHeight(context, .24),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: darkTheme == true
                                    ? myWhite
                                    : myBlack.withOpacity(.3),
                              ),
                              child: CheckboxGroup(
                                labels: <String>[
                                  "Best Sellers",
                                  "Low - High",
                                  "High - Low",
                                ],
                                labelStyle: TextStyle(
                                  color: darkTheme == true ? myWhite : myBlack,
                                  fontSize: dynamicWidth(context, .032),
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 1.0,
                                ),
                                activeColor:
                                    darkTheme == true ? myWhite : myRed,
                                checkColor:
                                    darkTheme == true ? myBlack : myWhite,
                                onSelected: (List<String> checked) => print(
                                  checked.toString(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: dynamicWidth(context, .4),
                            height: dynamicHeight(context, .24),
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: darkTheme == true
                                    ? myWhite
                                    : myBlack.withOpacity(.3),
                              ),
                              child: CheckboxGroup(
                                labels: <String>[
                                  "Small",
                                  "Medium",
                                  "Large",
                                  "Extra Large",
                                ],
                                labelStyle: TextStyle(
                                  color: darkTheme == true ? myWhite : myBlack,
                                  fontSize: dynamicWidth(context, .032),
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 1.0,
                                ),
                                activeColor:
                                    darkTheme == true ? myWhite : myRed,
                                checkColor:
                                    darkTheme == true ? myBlack : myWhite,
                                onSelected: (List<String> checked) => print(
                                  checked.toString(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: dynamicWidth(context, .08),
                              top: dynamicHeight(context, .01),
                              bottom: dynamicHeight(context, .01),
                            ),
                            child: Text(
                              "Price Range",
                              style: TextStyle(
                                fontFamily: "Aeonik",
                                fontSize: dynamicWidth(context, .04),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: dynamicWidth(context, .72),
                        child: FlutterSlider(
                          values: [30, 420],
                          rangeSlider: true,
                          max: 50000,
                          min: 0,
                          handlerAnimation: FlutterSliderHandlerAnimation(
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.bounceIn,
                            duration: Duration(milliseconds: 500),
                            scale: 1.5,
                          ),
                          trackBar: FlutterSliderTrackBar(
                            activeTrackBar: BoxDecoration(
                              color: darkTheme == true ? myWhite : myBlack,
                            ),
                            inactiveTrackBar: BoxDecoration(
                              color: darkTheme == true
                                  ? myWhite.withOpacity(.3)
                                  : myBlack.withOpacity(.3),
                            ),
                          ),
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            _lowerValue = lowerValue;
                            _upperValue = upperValue;
                            // setState((){
                            //
                            // });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: dynamicHeight(context, .01),
                          horizontal: dynamicWidth(context, .08),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return Text(
                                "From : " + _lowerValue.toString(),
                                style: TextStyle(
                                  fontSize: dynamicWidth(context, .04),
                                  fontWeight: FontWeight.w600,
                                  color: darkTheme == true ? myWhite : myBlack,
                                ),
                              );
                            }),
                            Obx(() {
                              return Text(
                                "To : " + _upperValue.toString(),
                                style: TextStyle(
                                  fontSize: dynamicWidth(context, .04),
                                  fontWeight: FontWeight.w600,
                                  color: darkTheme == true ? myWhite : myBlack,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      heightBox(context, .1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          coloredButton(
                            context,
                            "Apply Filters",
                            width: dynamicWidth(context, .46),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      });
    },
  );
}
