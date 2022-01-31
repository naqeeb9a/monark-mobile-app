import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:monark_app/Screens/SeeFullImage.dart';
import 'package:monark_app/utils/appRoutes.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:recase/recase.dart';

class DetailPage extends StatefulWidget {
  final dynamic image;
  final dynamic variantProduct;
  final String text;
  final dynamic array;
  final dynamic description;
  final String productType;
  final dynamic wishList;

  const DetailPage({
    Key? key,
    required this.image,
    this.description,
    this.array,
    required this.variantProduct,
    required this.text,
    required this.productType,
    required this.wishList,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeAnimation;
  late Animation<double> controlAnimation;
  String selectedSize = "";
  int productIndex = 0;
  int currentPos = 0;
  var quantity = 1.obs;
  List sizeArray = [];
  int saleDifference = 0;
  String sizeGuideImage = "";
  bool dragBool = false;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  sizeList() {
    for (int i = 0; i < widget.array.length; i++) {
      if (widget.variantProduct[i]["node"]["availableForSale"] == true) {
        sizeArray.add(widget.array[i]);
      }
    }
  }

  variantIndex() {
    for (int j = 0; j < widget.array.length; j++) {
      if (widget.variantProduct[j]["node"]["availableForSale"] == true) {
        productIndex = j;
        break;
      }
    }
  }

  sizeImage() {
    if (widget.productType.toString() == "Blazers") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Blazer.jpg";
      });
    } else if (widget.productType.toString() == "Casual Shirts") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Casual Shirt.jpg";
      });
    } else if (widget.productType.toString() == "Cotton Pants") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Chino.jpg";
      });
    } else if (widget.productType.toString() == "Suits") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Suit.jpg";
      });
    } else if (widget.productType.toString() == "Sweatshirts") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Sweatshirt.jpg";
      });
    } else if (widget.productType.toString() == "Jackets" ||
        widget.productType.toString() == "Hoodies") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Jackets.png";
      });
    } else if (widget.productType.toString() == "Sweaters") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Sweaters.jpg";
      });
    } else if (widget.productType.toString() == "Jeans") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Jeans.jpg";
      });
    } else if (widget.productType.toString() == "Formal Shirts") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Dress Shirts.jpg";
      });
    } else if (widget.productType.toString() == "trousers") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/trousers.jpg";
      });
    }
  }

  @override
  void initState() {
    super.initState();


    fadeAnimation =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    controlAnimation = Tween(begin: 0.0, end: 1.0).animate(fadeAnimation);
    if (widget.variantProduct[productIndex]["node"]["compareAtPrice"] != null) {
      saleDifference = double.parse(
                  widget.variantProduct[productIndex]["node"]["compareAtPrice"])
              .toInt() -
          double.parse(widget.variantProduct[productIndex]["node"]["price"])
              .toInt();
    }



    sizeImage();
    sizeList();
    variantIndex();
    selectedSize = sizeArray.length == 0 ? "0" : sizeArray[0];
  }

  @override
  Widget build(BuildContext context) {
    print(
        "pricea -> ${widget.variantProduct[productIndex]["node"]["compareAtPrice"]} + ${widget.variantProduct[productIndex]["node"]["price"]} ${double.parse(
            widget.variantProduct[productIndex]["node"]["compareAtPrice"])
            .toInt() -
            double.parse(widget.variantProduct[productIndex]["node"]["price"])
                .toInt()}");
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
      drawerScrimColor: darkTheme == true ? Colors.black54 : Colors.white54,
      endDrawer: drawer(context),
      body: SafeArea(
        child: Container(
          height: dynamicHeight(context, 1),
          width: dynamicWidth(context, 1),
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: dynamicWidth(context, 1),
                      height: dynamicHeight(context, .58),
                      color: myBlack.withOpacity(.2),
                      child: homeSlider(
                        context,
                        dynamicHeight(context, .58),
                        widget.image.length,
                        1.0,
                        widget.image,
                        false,
                        function: (value) {
                          setState(() {
                            currentPos = value;
                          });
                        },
                        page: () {
                          push(
                            context,
                            SeeFullImage(
                              image: widget.image,
                            ),
                          );
                        },
                      ),
                    ),
                    AnimatedPositioned(
                      bottom: dragBool == true
                          ? dynamicHeight(context, 0.166)
                          : dynamicHeight(context, 0.1),
                      duration: Duration(
                        milliseconds: 200,
                      ),
                      child: DotsIndicator(
                        decorator: DotsDecorator(
                          color: myWhite,
                          activeColor: myWhite,
                          size: const Size.square(5),
                          activeSize: const Size.square(10),
                        ),
                        dotsCount: widget.image.length,
                        position: currentPos.toDouble(),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails details) {
                    if (details.primaryDelta! > 0) {
                      setState(() {
                        dragBool = false;
                        fadeAnimation.reset();
                      });
                    } else if (details.primaryDelta! < 0) {
                      setState(() {
                        dragBool = true;
                        fadeAnimation.forward();
                      });
                    }
                  },
                  child: AnimatedContainer(
                    width: dynamicWidth(context, 1),
                    height: dragBool == true
                        ? dynamicHeight(context, .48)
                        : dynamicHeight(context, .4),
                    decoration: BoxDecoration(
                      color: darkTheme == false ? myWhite : darkThemeBlack,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          dynamicWidth(context, .08),
                        ),
                        topRight: Radius.circular(
                          dynamicWidth(context, .08),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: dynamicHeight(context, .02),
                      horizontal: dynamicWidth(context, .05),
                    ),
                    duration: Duration(
                      milliseconds: 200,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: dynamicWidth(context, .6),
                              height: dynamicHeight(context, .05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.text.titleCase,
                                    style: TextStyle(
                                      fontFamily: "Aeonik",
                                      fontWeight: FontWeight.bold,
                                      fontSize: dynamicWidth(context, .038),
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: dynamicHeight(context, .05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    (widget.variantProduct[productIndex]["node"]
                                                    ["compareAtPrice"] ==
                                                widget.variantProduct[productIndex]
                                                    ["node"]["price"] ||
                                            widget.variantProduct[productIndex]
                                                        ["node"]
                                                    ["compareAtPrice"] ==
                                                null)
                                        ? "PKR. " +
                                            numberFormat(double.parse(widget
                                                        .variantProduct[productIndex]
                                                    ["node"]["price"])
                                                .toInt()
                                                .toString())
                                        : "PKR. " + numberFormat(double.parse(widget.variantProduct[productIndex]["node"]["price"]).toInt().toString()),
                                    style: TextStyle(
                                      fontFamily: "Aeonik",
                                      color:
                                          darkTheme == true ? myWhite : myRed,
                                      fontWeight: FontWeight.bold,
                                      fontSize: dynamicWidth(context, .038),
                                    ),
                                  ),
                                  Text(
                                    (widget.variantProduct[productIndex]["node"]
                                                    ["compareAtPrice"] ==
                                                widget.variantProduct[
                                                        productIndex]["node"]
                                                    ["price"] ||
                                            widget.variantProduct[productIndex]
                                                        ["node"]
                                                    ["compareAtPrice"] ==
                                                null)
                                        ? ""
                                        : "You Save " +
                                            numberFormat(
                                                saleDifference.toString()) +
                                            " PKR",
                                    style: TextStyle(
                                      color: darkTheme == true
                                          ? myWhite
                                          : myBlack.withOpacity(.4),
                                      fontSize: dynamicWidth(context, .03),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        heightBox(context, .004),
                        (widget.array.toString().contains("Default") ||
                                widget.array == "")
                            ? Container()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Size",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .035),
                                    ),
                                  ),
                                  sizeGuideImage == ""
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            imageAlert(
                                              context,
                                              "$sizeGuideImage",
                                              true,
                                            );
                                          },
                                          child: Text(
                                            "Size Guide",
                                            style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                    color: darkTheme == true
                                                        ? myWhite
                                                        : myBlack,
                                                    offset: Offset(0, -5))
                                              ],
                                              color: noColor,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: myRed,
                                              decorationThickness: 4,
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                        (widget.array.toString().contains("Default") ||
                                widget.array == "")
                            ? Container()
                            : sizeOptions(
                                context,
                                sizeArray,
                                widget.variantProduct,
                              ),
                        heightBox(context, 0.01),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Qty",
                            style: TextStyle(
                              color: darkTheme == true ? myWhite : myBlack,
                              fontSize: dynamicWidth(context, .035),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: dynamicWidth(context, .2),
                              decoration: BoxDecoration(
                                color: noColor,
                                borderRadius: BorderRadius.circular(
                                  dynamicWidth(context, .01),
                                ),
                                border: Border.all(
                                  color: darkTheme == true
                                      ? myWhite
                                      : myBlack.withOpacity(.3),
                                  width: .2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (quantity > 1) {
                                        quantity--;
                                      }
                                    },
                                    child: Container(
                                      width: dynamicWidth(context, .03),
                                      height: dynamicWidth(context, .07),
                                      child: Center(
                                        child: Icon(
                                          Icons.remove,
                                          size: dynamicWidth(context, .03),
                                          color: darkTheme == true
                                              ? myWhite
                                              : myRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    return Text(
                                      quantity.toString(),
                                      style: TextStyle(
                                        color: darkTheme == true
                                            ? myWhite
                                            : myBlack,
                                        fontSize: dynamicWidth(context, .03),
                                      ),
                                    );
                                  }),
                                  InkWell(
                                    onTap: () {
                                      if (quantity < 3) {
                                        quantity++;
                                      }
                                    },
                                    child: Container(
                                      width: dynamicWidth(context, .03),
                                      height: dynamicWidth(context, .07),
                                      child: Icon(
                                        Icons.add,
                                        size: dynamicWidth(context, .03),
                                        color:
                                            darkTheme == true ? myWhite : myRed,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (dragBool == false) {
                                  setState(() {
                                    dragBool = true;
                                    fadeAnimation.forward();
                                  });
                                } else if (dragBool == true) {
                                  setState(() {
                                    dragBool = false;
                                    fadeAnimation.reset();
                                  });
                                }
                              },
                              child: Text(
                                "Description",
                                style: TextStyle(
                                  shadows: [
                                    Shadow(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      offset: Offset(0, -5),
                                    )
                                  ],
                                  color: noColor,
                                  fontSize: dynamicWidth(context, .035),
                                  decoration: TextDecoration.underline,
                                  decorationColor: myRed,
                                  decorationThickness: 4,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ),
                          ],
                        ),
                        dragBool == true
                            ? heightBox(context, .01)
                            : heightBox(context, 0.0),
                        dragBool == true
                            ? FadeTransition(
                                opacity: controlAnimation,
                                child: Text(
                                  widget.description.toString(),
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .03),
                                  ),
                                  maxLines: 4,
                                ),
                              )
                            : Container(
                                width: 0,
                                height: 0,
                              ),
                        heightBox(context, 0.018),
                        bottomButton(
                          context,
                          widget.image[0]["node"]["src"],
                          double.parse(widget.variantProduct[productIndex]
                                  ["node"]["price"])
                              .toInt()
                              .toString(),
                          widget.text,
                          quantity,
                          widget.variantProduct[productIndex]["node"]["sku"],
                          widget.variantProduct[productIndex]["node"]["id"],
                          selectedSize,
                        ),
                        heightBox(context, 0.01),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                child: SizedBox(
                  width: dynamicWidth(context, 1),
                  height: dynamicHeight(context, .062),
                  child: bar(
                    context,
                    menuIcon: true,
                    bgColor: noColor,
                    leadingIcon: true,
                    iconColor: myBlack,
                    function: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(
                  milliseconds: 200,
                ),
                bottom: dragBool == true
                    ? dynamicHeight(context, .52)
                    : dynamicHeight(context, .44),
                right: dynamicWidth(context, .08),
                child: GestureDetector(
                  onTap: () {
                    var check = "";
                    if (wishListItems.length == 0) {
                      wishListItems.add(widget.wishList);
                      wishListItemsCheck.add(widget.wishList["node"]["id"]);
                      var snackBar = SnackBar(
                        content: Text(
                          'Item Added to Wish List',
                          style: TextStyle(
                            color: darkTheme == false ? myWhite : myBlack,
                          ),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: darkTheme == true ? myWhite : myBlack,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState(() {});
                    } else {
                      for (int i = 0; i < wishListItems.length; i++) {
                        if (wishListItems[i]["node"]["id"] ==
                            widget.wishList["node"]["id"]) {
                          wishListItems.removeAt(i);
                          wishListItemsCheck.removeAt(i);
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

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {});
                          check = "yes";
                          break;
                        } else {
                          check = "no";
                        }
                      }

                      if (check == "no" && check != "yes") {
                        wishListItems.add(widget.wishList);
                        wishListItemsCheck.add(widget.wishList["node"]["id"]);
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
                        setState(() {});
                      }
                    }
                  },
                  child: CircleAvatar(
                    radius: dynamicWidth(context, 0.05),
                    backgroundColor: myWhite,
                    child: Icon(
                      wishListItemsCheck.contains(widget.wishList["node"]["id"])
                          ? Icons.favorite
                          : Icons.favorite_border_rounded,
                      size: dynamicWidth(context, 0.06),
                      color: wishListItemsCheck
                              .contains(widget.wishList["node"]["id"])
                          ? myRed
                          : myBlack.withOpacity(.3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sizeOptions(context, array, variantProduct, {function}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        array.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            right: dynamicWidth(context, .02),
          ),
          child: Material(
            color: noColor,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedSize = array[index];
                  productIndex = index;
                });
              },
              child: Ink(
                child: Container(
                  width: dynamicWidth(context, .07),
                  height: dynamicWidth(context, .075),
                  decoration: BoxDecoration(
                    color: darkTheme == true
                        ? selectedSize == array[index]
                            ? myWhite
                            : noColor
                        : selectedSize == array[index]
                            ? myRed
                            : noColor,
                    borderRadius: BorderRadius.circular(
                      dynamicWidth(context, .012),
                    ),
                    border: Border.all(
                      color: darkTheme == true
                          ? selectedSize == array[index]
                              ? myWhite
                              : myWhite.withOpacity(.5)
                          : selectedSize == array[index]
                              ? myRed
                              : myBlack.withOpacity(.3),
                      width: .2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      array[index].toString(),
                      style: TextStyle(
                        fontSize: dynamicWidth(context, .03),
                        color: darkTheme == true
                            ? selectedSize == array[index]
                                ? myBlack
                                : myWhite
                            : selectedSize == array[index]
                                ? myWhite
                                : myBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomButton(
    context, image, price, text, cartQuantity, sku, variantId, size) {
  return MaterialButton(
    color: myRed,
    height: dynamicHeight(context, .048),
    minWidth: dynamicWidth(context, .88),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        dynamicWidth(context, .08),
      ),
      side: BorderSide(color: Theme.of(context).primaryColor),
    ),
    onPressed: () {
      if (cartItems.length == 0) {
        cartItems.add({
          "imageUrl": image,
          "price": price,
          "title": text,
          "quantity": cartQuantity.value,
          "total": int.parse(price.toString()) *
              int.parse(cartQuantity.value.toString()),
          "sku": sku,
          "variantId": variantId,
          "size": size,
        });
      } else {
        for (int i = 0; i < cartItems.length; i++) {
          if (text.toString() == cartItems[i]["title"].toString() &&
              size.toString() == cartItems[i]["size"].toString()) {
            cartItems[i]["quantity"] =
                int.parse(cartItems[i]["quantity"].toString()) +
                    int.parse(cartQuantity.toString());
            cartItems[i]["total"] =
                int.parse(cartItems[i]["total"].toString()) +
                    (int.parse(price.toString()) *
                        int.parse(cartQuantity.value.toString()));
          } else {
            cartItems.add({
              "imageUrl": image,
              "price": price,
              "title": text,
              "quantity": cartQuantity.value,
              "total": int.parse(price.toString()) *
                  int.parse(cartQuantity.value.toString()),
              "sku": sku,
              "variantId": variantId,
              "size": size,
            });
          }
        }
      }

      var snackBar = SnackBar(
        content: (cartItems.length > 1)
            ? Text(cartItems.length.toString() + ' Items added to cart')
            : Text(cartItems.length.toString() + ' Item added to cart'),
        duration: const Duration(milliseconds: 500),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    child: Center(
      child: Text(
        "Add to Bag",
        style: TextStyle(
          color: myWhite,
          fontWeight: FontWeight.bold,
          fontSize: dynamicWidth(context, .04),
        ),
      ),
    ),
  );
}
