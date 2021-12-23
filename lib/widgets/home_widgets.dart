import 'package:another_xlider/another_xlider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:intl/intl.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:recase/recase.dart';

import '../utils/config.dart';
import 'drawer_items.dart';
import 'media_query.dart';

Widget basicCards(context, imageUrl, text,
    {handle = "",
    sizeOption = "",
    description = "No Description",
    variantProduct = "",
    productType = "",
    categoriesCheck = false,
    wishList = "",
    refreshScreen = ""}) {
  return InkWell(
    onTap: (categoriesCheck == true)
        ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeeAll(
                  text: text,
                  function: getShopifyCollection(handle),
                  handle: handle,
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
                  productType: productType,
                  wishList: wishList,
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
  return StatefulBuilder(builder: (context, stateful) {
    return Container(
      width: dynamicWidth(context, 0.47),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  dynamicWidth(context, .06),
                ),
                child: Container(
                  height: dynamicWidth(context, .61),
                  width: dynamicWidth(context, .47),
                  color: myWhite,
                  child: CachedNetworkImage(
                    imageUrl: categoriesCheck == true
                        ? imageUrl
                        : imageUrl[0]["node"]["src"],
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => SizedBox(
                      height: dynamicHeight(context, 0.4),
                      child: Center(child: retryFunction(context, check: true)),
                    ),
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
                            wishListItems.add(wishList);
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
                            refreshScreen();
                          } else {
                            for (int i = 0; i < wishListItems.length; i++) {
                              if (wishListItems[i]["node"]["id"] ==
                                  wishList["node"]["id"]) {
                                wishListItems.removeAt(i);
                                var snackBar = SnackBar(
                                  content: Text(
                                    'Item Removed from Wish List',
                                    style: TextStyle(
                                      color: darkTheme == false
                                          ? myWhite
                                          : myBlack,
                                    ),
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor:
                                      darkTheme == true ? myWhite : myBlack,
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                refreshScreen();
                                check = "yes";
                                break;
                              } else {
                                check = "no";
                              }
                            }

                            if (check == "no" && check != "yes") {
                              wishListItems.add(wishList);
                              var snackBar = SnackBar(
                                content: Text(
                                  'Item Added to Wish List',
                                  style: TextStyle(
                                    color:
                                        darkTheme == false ? myWhite : myBlack,
                                  ),
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor:
                                    darkTheme == true ? myWhite : myBlack,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              refreshScreen();
                            }
                          }
                        },
                        child: CircleAvatar(
                          radius: dynamicWidth(context, 0.03),
                          backgroundColor: myWhite,
                          child: Icon(
                            Icons.favorite_border_rounded,
                            size: dynamicWidth(context, 0.04),
                            color: myBlack.withOpacity(.3),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          heightBox(context, 0.01),
          categoriesCheck == true
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: "Aeonik",
                      color: darkTheme == true ? myWhite : myBlack,
                      fontSize: dynamicWidth(context, .03),
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    text.toString().titleCase,
                    style: TextStyle(
                      color: darkTheme == true ? myWhite : myBlack,
                      fontSize: dynamicWidth(context, .028),
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
                            "PKR. " +
                                numberFormat(double.parse(
                                        variantProduct[0]["node"]["price"])
                                    .toInt()
                                    .toString()),
                            style: TextStyle(
                              fontFamily: "Aeonik",
                              color: darkTheme == true ? myWhite : myBlack,
                              fontWeight: FontWeight.w900,
                              fontSize: dynamicWidth(context, .028),
                            ),
                          )
                        : Text(
                            "PKR. " +
                                numberFormat(double.parse(variantProduct[0]
                                        ["node"]["compareAtPrice"])
                                    .toInt()
                                    .toString()),
                            style: TextStyle(
                              fontFamily: "Aeonik",
                              color: darkTheme == true ? myWhite : myBlack,
                              decoration: TextDecoration.lineThrough,
                              fontSize: dynamicWidth(context, .028),
                            ),
                          ),
                    (variantProduct[0]["node"]["compareAtPrice"] ==
                                variantProduct[0]["node"]["price"] ||
                            variantProduct[0]["node"]["compareAtPrice"] == null)
                        ? Container()
                        : Text(
                            "PKR. " +
                                numberFormat(double.parse(
                                        variantProduct[0]["node"]["price"])
                                    .toInt()
                                    .toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: dynamicWidth(context, .028),
                              color: darkTheme == true ? myWhite : myRed,
                            ),
                          )
                  ],
                ),
        ],
      ),
    );
  });
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
            fontSize: dynamicWidth(context, .082),
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
                  width: dynamicWidth(context, .06),
                ),
              ),
            )
          : SizedBox(
              width: 0.0,
            ),
    ],
  );
}

dynamic imageAlert(context, image, assetImage) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Material(
          child: Container(
            width: dynamicWidth(context, .9),
            decoration: BoxDecoration(
              color: noColor,
              borderRadius: BorderRadius.circular(
                dynamicWidth(
                  context,
                  dynamicWidth(context, .03),
                ),
              ),
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
                          child: InkWell(
                            onTap: () {
                              pop(context);
                            },
                            child: Icon(
                              Icons.clear,
                              color: myRed,
                              size: dynamicWidth(context, .08),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

CarouselController buttonCarouselController = CarouselController();

Widget homeSlider(context, height, length, viewFraction, image, bool detail,
    {function = "", page = ""}) {
  return CarouselSlider.builder(
    itemCount: length,
    carouselController: buttonCarouselController,
    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        detail == true
            ? (image == "loading")
                ? sliderContainer(context, "loading", detail)
                : (image == false)
                    ? sliderContainer(context, image, detail)
                    : sliderContainer(
                        context,
                        image[itemIndex]["image_url"],
                        detail,
                      )
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
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      autoPlay: detail,
      autoPlayInterval: Duration(seconds: 6),
      viewportFraction: viewFraction,
      autoPlayAnimationDuration: Duration(seconds: 2),
      autoPlayCurve: Curves.fastLinearToSlowEaseIn,
    ),
  );
}

Widget sliderContainer(context, image, bool detail) {
  return InteractiveViewer(
    child: (image == "loading")
        ? Image.asset(
            "assets/loader.gif",
            scale: 6,
          )
        : (image == false)
            ? SizedBox(
                height: dynamicHeight(context, 0.4),
                child: Center(
                  child: retryFunction(context, check: true),
                ),
              )
            : Stack(
                children: [
                  SizedBox(
                    width: dynamicWidth(context, 1),
                    height: dynamicHeight(context, 1),
                    child: Padding(
                      padding: detail == false
                          ? EdgeInsets.all(0)
                          : EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, 0.02),
                            ),
                      child: ClipRRect(
                        borderRadius: (detail == true)
                            ? BorderRadius.circular(
                                dynamicWidth(context, 0.08),
                              )
                            : BorderRadius.circular(0),
                        child: CachedNetworkImage(
                          imageUrl: image,
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
                    ),
                  ),
                ],
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
                              child: RadioButtonGroup(
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
                                onSelected: (String selected) =>
                                    sortFilterCheck = selected,
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
                              child: RadioButtonGroup(
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
                                onSelected: (String selected) =>
                                    sizeFilterCheck = selected,
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
                          values: [lowerPriceFilter, upperPriceFilter],
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
                            lowerPriceFilter = lowerValue;
                            upperPriceFilter = upperValue;
                            setState(() {});
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
                            Text(
                              "From : " + lowerPriceFilter.toString(),
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .04),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                            Text(
                              "To : " + upperPriceFilter.toString(),
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .04),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightBox(context, .1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          coloredButton(context, "Apply Filters",
                              width: dynamicWidth(context, .46), function: () {
                            pop(context);
                          }),
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

Widget jumpingDots(context) {
  return Center(
    child: JumpingText(
      ".....",
      end: Offset(0.0, -0.1),
      style: TextStyle(
        color: darkTheme == true ? myWhite : myBlack,
        fontSize: dynamicWidth(context, .08),
      ),
    ),
  );
}

numberFormat(number) {
  final oCcy = new NumberFormat("#,##,##0", "en_US");
  return oCcy.format(int.parse(number.toString()));
}
