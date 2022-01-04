import 'package:another_xlider/another_xlider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/Screens/DetailPage.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/widgets/coloredButton.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
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
                      child: StatefulBuilder(builder: (context, changeState) {
                        return GestureDetector(
                          onTap: () {
                            var check = "";
                            if (wishListItems.length == 0) {
                              wishListItems.add(wishList);
                              wishListItemsCheck.add(wishList["node"]["id"]);
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
                              changeState(() {});
                            } else {
                              for (int i = 0; i < wishListItems.length; i++) {
                                if (wishListItems[i]["node"]["id"] ==
                                    wishList["node"]["id"]) {
                                  wishListItems.removeAt(i);
                                  wishListItemsCheck.removeAt(i);
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
                                  if (refreshScreen != "") {
                                    refreshScreen();
                                  }
                                  changeState(() {});
                                  check = "yes";
                                  break;
                                } else {
                                  check = "no";
                                  changeState(() {});
                                }
                              }

                              if (check == "no" && check != "yes") {
                                wishListItems.add(wishList);
                                wishListItemsCheck.add(wishList["node"]["id"]);
                                var snackBar = SnackBar(
                                  content: Text(
                                    'Item Added to Wish List',
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
                                if (refreshScreen != "") {
                                  refreshScreen();
                                }
                                changeState(() {});
                              }
                            }
                          },
                          child: CircleAvatar(
                            radius: dynamicWidth(context, 0.03),
                            backgroundColor: myWhite,
                            child: Icon(
                              wishListItemsCheck
                                      .contains(wishList["node"]["id"])
                                  ? Icons.favorite
                                  : Icons.favorite_border_rounded,
                              size: dynamicWidth(context, 0.04),
                              color: wishListItemsCheck
                                      .contains(wishList["node"]["id"])
                                  ? myRed
                                  : myBlack.withOpacity(.3),
                            ),
                          ),
                        );
                      }),
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
                if (filterCheck == true) {
                  filterContainer(context, function);
                } else {
                  var snackBar = SnackBar(
                    content: Text(
                      'Nothing to filter Yet!!',
                      style: TextStyle(
                        color: darkTheme == false ? myWhite : myBlack,
                      ),
                    ),
                    duration: const Duration(seconds: 1),
                    backgroundColor: darkTheme == true ? myWhite : myBlack,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
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

int radioValue = 0;

RadioGroupController myController = RadioGroupController();

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

filterContainer(context, function) {
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
                          Padding(
                            padding: EdgeInsets.only(
                              left: dynamicWidth(context, .08),
                              top: dynamicHeight(context, .1),
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
                              top: dynamicHeight(context, .1),
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
                      Padding(
                        padding: EdgeInsets.only(
                          left: dynamicWidth(context, .06),
                          right: dynamicWidth(context, .06),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: dynamicWidth(context, .34),
                              height: dynamicHeight(context, .166),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: darkTheme == true
                                      ? myWhite
                                      : myBlack.withOpacity(.3),
                                ),
                                child: RadioGroup(
                                  controller: myController,
                                  values: [
                                    "Best Sellers",
                                    "Low - High",
                                    "High - Low",
                                  ],
                                  orientation: RadioGroupOrientation.Vertical,
                                  decoration: RadioGroupDecoration(
                                    spacing: 0.0,
                                    labelStyle: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .03),
                                    ),
                                    activeColor:
                                        darkTheme == true ? myWhite : myRed,
                                  ),
                                  onChanged: (selectedValue) =>
                                      sortFilterCheck =
                                          selectedValue.toString(),
                                ),
                              ),
                            ),
                            Container(
                              width: dynamicWidth(context, .34),
                              height: dynamicHeight(context, .166),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: darkTheme == true
                                      ? myWhite
                                      : myBlack.withOpacity(.3),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: .8,
                                          child: Checkbox(
                                            value: sizeArray[0],
                                            splashRadius: .4,
                                            checkColor: darkTheme == true
                                                ? myRed
                                                : myWhite,
                                            activeColor: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onChanged: (value) {
                                              print(value);
                                              setState(() {
                                                sizeArray[0] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Small",
                                          style: TextStyle(
                                            color: darkTheme == true
                                                ? myWhite
                                                : myBlack,
                                            fontSize:
                                                dynamicWidth(context, .03),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: .8,
                                          child: Checkbox(
                                            value: sizeArray[1],
                                            splashRadius: .4,
                                            checkColor: darkTheme == true
                                                ? myRed
                                                : myWhite,
                                            activeColor: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onChanged: (value) {
                                              setState(() {
                                                sizeArray[1] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Medium",
                                          style: TextStyle(
                                            color: darkTheme == true
                                                ? myWhite
                                                : myBlack,
                                            fontSize:
                                                dynamicWidth(context, .03),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: .8,
                                          child: Checkbox(
                                            value: sizeArray[2],
                                            splashRadius: .4,
                                            checkColor: darkTheme == true
                                                ? myRed
                                                : myWhite,
                                            activeColor: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onChanged: (value) {
                                              setState(() {
                                                sizeArray[2] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Large",
                                          style: TextStyle(
                                            color: darkTheme == true
                                                ? myWhite
                                                : myBlack,
                                            fontSize:
                                                dynamicWidth(context, .03),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: .8,
                                          child: Checkbox(
                                            value: sizeArray[3],
                                            splashRadius: .4,
                                            checkColor: darkTheme == true
                                                ? myRed
                                                : myWhite,
                                            activeColor: darkTheme == true
                                                ? myWhite
                                                : myRed,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            onChanged: (value) {
                                              setState(() {
                                                sizeArray[3] = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Text(
                                          "Extra Large",
                                          style: TextStyle(
                                            color: darkTheme == true
                                                ? myWhite
                                                : myBlack,
                                            fontSize:
                                                dynamicWidth(context, .03),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          handler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                color: myBlack.withOpacity(.3),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              type: MaterialType.circle,
                              color: Colors.white,
                              elevation: 0,
                              child: Center(
                                child: Icon(
                                  Icons.chevron_left,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          rightHandler: FlutterSliderHandler(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: Border.all(
                                color: myBlack.withOpacity(.3),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              type: MaterialType.circle,
                              color: Colors.white,
                              elevation: 0,
                              child: Center(
                                child: Icon(
                                  Icons.chevron_right,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                          handlerAnimation: FlutterSliderHandlerAnimation(
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.bounceIn,
                            duration: Duration(milliseconds: 500),
                            scale: 1.5,
                          ),
                          trackBar: FlutterSliderTrackBar(
                            activeTrackBarHeight: 1.5,
                            inactiveTrackBarHeight: 1.0,
                            activeTrackBar: BoxDecoration(
                              color: darkTheme == true
                                  ? myWhite
                                  : myBlack.withOpacity(.3),
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
                                fontSize: dynamicWidth(context, .03),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                            Text(
                              "To : " + upperPriceFilter.toString(),
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .03),
                                fontWeight: FontWeight.w600,
                                color: darkTheme == true ? myWhite : myBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightBox(context, .1),
                      Padding(
                        padding: EdgeInsets.only(
                          right: dynamicWidth(context, .04),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            coloredButton(
                              context,
                              "Apply Filters",
                              width: dynamicWidth(context, .3),
                              function: () {
                                
                                pop(context);
                                function();
                              },
                            ),
                          ],
                        ),
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
  // return Image.asset(
  //   "assets/icons/loading.gif",
  //   height: dynamicHeight(context, .16),
  // );
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

dynamic logOutAlert(context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return Align(
        alignment: Alignment.center,
        child: Material(
          color: noColor,
          child: Container(
            height: dynamicHeight(context, .14),
            width: dynamicWidth(context, .8),
            decoration: BoxDecoration(
              color: myRed,
              borderRadius: BorderRadius.circular(
                dynamicWidth(context, .04),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/loading.gif",
                  fit: BoxFit.fill,
                  height: dynamicHeight(context, .014),
                ),
                heightBox(context, .012),
                Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: dynamicWidth(context, .032),
                    color: myWhite,
                    fontWeight: FontWeight.bold,
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

dynamic customAlert(context) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return Align(
        alignment: Alignment.center,
        child: Material(
          color: noColor,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: dynamicHeight(context, .2),
            ),
            child: Container(
              height: dynamicHeight(context, .32),
              width: dynamicWidth(context, .8),
              decoration: BoxDecoration(
                color: myRed,
                borderRadius: BorderRadius.circular(
                  dynamicWidth(context, .04),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: dynamicHeight(context, .17),
                    width: dynamicWidth(context, .8),
                    child: Center(
                      child: Icon(
                        Icons.email_outlined,
                        color: myWhite,
                        size: dynamicWidth(context, .16),
                      ),
                    ),
                  ),
                  Container(
                    height: dynamicHeight(context, .15),
                    width: dynamicWidth(context, .8),
                    decoration: BoxDecoration(
                      color: myWhite,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(
                          dynamicWidth(context, .04),
                        ),
                        bottomLeft: Radius.circular(
                          dynamicWidth(context, .04),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'This email is already registered',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: dynamicWidth(context, .032),
                            color: myBlack,
                          ),
                        ),
                        coloredButton(
                          context,
                          "Ok",
                          width: dynamicWidth(context, .16),
                          heigth: dynamicHeight(context, .03),
                          function: () {
                            pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // return Material(
      //   color: noColor,
      //   child: Container(
      //     height: dynamicHeight(context, .12),
      //
      //     child: AlertDialog(
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(
      //           dynamicWidth(context, .02),
      //         ),
      //       ),
      //       content: Padding(
      //         padding: const EdgeInsets.all(25.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Image.asset(
      //               "assets/icons/loading.gif",
      //             ),
      //             SizedBox(height: 40),
      //             Text(
      //               'OOPS!',
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 20,
      //                 color: myRed,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    },
  );
}
