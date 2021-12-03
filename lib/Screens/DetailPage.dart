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

class DetailPage extends StatefulWidget {
  final dynamic image;
  final dynamic variantProduct;
  final String text;
  final dynamic array;
  final dynamic description;
  final bool availableForSale;
  final String productType;

  const DetailPage(
      {Key? key,
      required this.image,
      this.description,
      this.array,
      required this.variantProduct,
      required this.text,
      required this.availableForSale,
      required this.productType})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedSize = "";
  int productIndex = 0;
  int currentPos = 0;
  var quantity = 1.obs;
  List sizeArray = [];
  int saleDifference = 0;
  String sizeGuideImage = "";
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
    } else if (widget.productType.toString() == "Jackets") {
      setState(() {
        sizeGuideImage = "assets/sizeChart/Jackets.jpg";
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
    selectedSize = sizeArray[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == false ? myWhite : darkThemeBlack,
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
                    Positioned(
                      bottom: dynamicHeight(context, 0.09),
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
                child: Container(
                  width: dynamicWidth(context, 1),
                  height: dynamicHeight(context, .4),
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
                  child: Column(
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
                                  widget.text,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: dynamicWidth(context, .04),
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
                                                  ["node"]["compareAtPrice"] ==
                                              null)
                                      ? "Pkr. " +
                                          double.parse(widget.variantProduct[productIndex]["node"]["price"])
                                              .toInt()
                                              .toString()
                                      : "Pkr. " +
                                          double.parse(widget
                                                      .variantProduct[productIndex]
                                                  ["node"]["compareAtPrice"])
                                              .toInt()
                                              .toString(),
                                  style: TextStyle(
                                    color: darkTheme == true ? myWhite : myRed,
                                    fontWeight: FontWeight.bold,
                                    fontSize: dynamicWidth(context, .04),
                                  ),
                                ),
                                Text(
                                  (widget.variantProduct[productIndex]["node"]
                                                  ["compareAtPrice"] ==
                                              widget.variantProduct[
                                                      productIndex]["node"]
                                                  ["price"] ||
                                          widget.variantProduct[productIndex]
                                                  ["node"]["compareAtPrice"] ==
                                              null)
                                      ? ""
                                      : "You Save  " +
                                          saleDifference.toString() +
                                          " Pkr",
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
                      (widget.array.toString().contains("Default") ||
                              widget.array == "")
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: sizeGuideImage == ""
                                    ? dynamicHeight(context, .01)
                                    : 0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Size",
                                    style: TextStyle(
                                      color:
                                          darkTheme == true ? myWhite : myBlack,
                                      fontSize: dynamicWidth(context, .05),
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
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical:
                                                  dynamicHeight(context, .01),
                                            ),
                                            child: Text(
                                              "Size Guide",
                                              style: TextStyle(
                                                color: darkTheme == true
                                                    ? myWhite
                                                    : myBlack,
                                                fontSize:
                                                    dynamicWidth(context, .042),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                      (widget.array.toString().contains("Default") ||
                              widget.array == "")
                          ? Container()
                          : sizeOptions(
                              context,
                              sizeArray,
                              widget.variantProduct,
                            ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: dynamicHeight(context, .008),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Qty",
                              style: TextStyle(
                                color: darkTheme == true ? myWhite : myBlack,
                                fontSize: dynamicWidth(context, .05),
                              ),
                            ),
                          ],
                        ),
                      ),
                      heightBox(context, .008),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: dynamicWidth(context, .25),
                          decoration: BoxDecoration(
                            color: noColor,
                            borderRadius: BorderRadius.circular(
                              dynamicWidth(context, .03),
                            ),
                            border: Border.all(
                              color: darkTheme == true
                                  ? myWhite
                                  : myBlack.withOpacity(.3),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                },
                                child: Container(
                                  width: dynamicWidth(context, .09),
                                  height: dynamicWidth(context, .09),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: dynamicWidth(context, .05),
                                      color:
                                          darkTheme == true ? myWhite : myRed,
                                    ),
                                  ),
                                ),
                              ),
                              Obx(() {
                                return Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    color:
                                        darkTheme == true ? myWhite : myBlack,
                                    fontSize: dynamicWidth(context, .05),
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
                                  width: dynamicWidth(context, .09),
                                  height: dynamicWidth(context, .09),
                                  child: Icon(
                                    Icons.add,
                                    size: dynamicWidth(context, .05),
                                    color: darkTheme == true ? myWhite : myRed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: dynamicHeight(context, .03),
                        ),
                        child: bottomButton(
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
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                child: SizedBox(
                  width: dynamicWidth(context, 1),
                  height: dynamicHeight(context, .06),
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
              Positioned(
                top: dynamicHeight(context, .43),
                right: dynamicWidth(context, .08),
                child: CircleAvatar(
                  radius: dynamicWidth(context, 0.05),
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.favorite,
                    size: dynamicWidth(context, 0.06),
                    color: myRed,
                  ),
                ),
              )
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
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(context, .01),
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
                  width: dynamicWidth(context, .08),
                  height: dynamicWidth(context, .09),
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
                      width: 1.4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      array[index].toString(),
                      style: TextStyle(
                        fontSize: dynamicWidth(context, .035),
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
    height: dynamicHeight(context, .05),
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
        if (text.toString() == cartItems[0]["title"].toString() &&
            size.toString() == cartItems[0]["size"].toString()) {
          cartItems[0]["quantity"] =
              int.parse(cartItems[0]["quantity"].toString()) +
                  int.parse(cartQuantity.toString());
          cartItems[0]["total"] = int.parse(cartItems[0]["total"].toString()) +
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
        "Add to Cart",
        style: TextStyle(
          color: myWhite,
          fontSize: dynamicWidth(context, .05),
        ),
      ),
    ),
  );
}
