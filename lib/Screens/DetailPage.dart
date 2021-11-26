import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
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

  const DetailPage({
    Key? key,
    required this.image,
    this.description,
    this.array,
    required this.variantProduct,
    required this.text,
    required this.availableForSale,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String selectedSize = "";
  int productIndex = 0;
  var quantity = 1.obs;
  List sizeArray = [];
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

  @override
  void initState() {
    super.initState();

    sizeList();
    variantIndex();
    selectedSize = sizeArray[0];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: myWhite,
      endDrawer: drawer(context),
      body: SafeArea(
        child: Container(
          height: dynamicHeight(context, 1),
          width: dynamicWidth(context, 1),
          child: Stack(
            children: [
              Positioned(
                top: 0.0,
                child: Container(
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
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: dynamicWidth(context, 1),
                  height: dynamicHeight(context, .44),
                  decoration: BoxDecoration(
                    color: myWhite,
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
                    vertical: dynamicHeight(context, .03),
                    horizontal: dynamicWidth(context, .05),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.text,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, .04),
                            ),
                          ),
                          Text(
                            (widget.variantProduct[productIndex]["node"]
                                        ["compareAtPrice"] ==
                                    widget.variantProduct[productIndex]["node"]
                                        ["price"])
                                ? "Pkr. " +
                                    double.parse(
                                            widget.variantProduct[productIndex]
                                                ["node"]["price"])
                                        .toInt()
                                        .toString()
                                : "Pkr. " +
                                    double.parse(
                                            widget.variantProduct[productIndex]
                                                ["node"]["compareAtPrice"])
                                        .toInt()
                                        .toString(),
                            style: TextStyle(
                              color: myRed,
                              fontWeight: FontWeight.bold,
                              fontSize: dynamicWidth(context, .04),
                            ),
                          ),
                        ],
                      ),
                      (widget.array.toString().contains("Default") ||
                              widget.array == "")
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: dynamicHeight(context, .01),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Size",
                                    style: TextStyle(
                                      fontSize: dynamicWidth(context, .05),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      imageAlert(
                                        context,
                                        "assets/size_guide.jpg",
                                        true,
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: dynamicHeight(context, .01),
                                      ),
                                      child: Text(
                                        "Size Guide",
                                        style: TextStyle(
                                          fontSize: dynamicWidth(context, .046),
                                          fontWeight: FontWeight.w200,
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
                          vertical: dynamicHeight(context, .01),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Qty",
                              style: TextStyle(
                                fontSize: dynamicWidth(context, .05),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: dynamicWidth(context, .3),
                            decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(
                                dynamicWidth(context, .02),
                              ),
                              border: Border.all(
                                color: myBlack.withOpacity(.3),
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
                                    width: dynamicWidth(context, .1),
                                    height: dynamicWidth(context, .1),
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: dynamicWidth(context, .054),
                                        color: myRed,
                                      ),
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                      fontSize: dynamicWidth(context, .054),
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
                                    width: dynamicWidth(context, .1),
                                    height: dynamicWidth(context, .1),
                                    child: Icon(
                                      Icons.add,
                                      size: dynamicWidth(context, .054),
                                      color: myRed,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: dynamicHeight(context, .04),
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
                    function: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
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
    return Container(
      height: dynamicHeight(context, .06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          array.length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, .02),
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
                    width: dynamicWidth(context, .1),
                    height: dynamicWidth(context, .1),
                    decoration: BoxDecoration(
                      color: selectedSize == array[index] ? myRed : myWhite,
                      borderRadius: BorderRadius.circular(
                        dynamicWidth(context, .012),
                      ),
                      border: Border.all(
                        color: selectedSize == array[index]
                            ? myRed
                            : myBlack.withOpacity(.3),
                        width: 1.4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        array[index].toString(),
                        style: TextStyle(
                          fontSize: dynamicWidth(context, .044),
                          color:
                              selectedSize == array[index] ? myWhite : myBlack,
                        ),
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

Widget bottomButton(context, image, price, text, cartQuantity, sku, variantId) {
  return MaterialButton(
    color: myRed,
    height: dynamicHeight(context, .06),
    minWidth: MediaQuery.of(context).size.width,
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
        });
      } else {
        if (text.toString() == cartItems[0]["title"]) {
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
