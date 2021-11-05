import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class DetailPage extends StatefulWidget {
  final dynamic image;
  final dynamic price;
  final String text;
  final dynamic array;
  final dynamic description;
  final dynamic sku;

  const DetailPage({
    Key? key,
    required this.image,
    this.description,
    this.array,
    required this.price,
    required this.text,
    required this.sku,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _expanded = false;
  String selectedSize = "";
  int priceIndex = 0, skuIndex = 0;
  var quantity = 1.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedSize = widget.array[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey,
      appBar: bar2(context, cartCheck: true, icon: Icons.shopping_bag_outlined),
      body: Container(
        height: dynamicHeight(context, 1),
        width: dynamicWidth(context, 1),
        child: Stack(
          children: [
            Container(
              height: dynamicHeight(context, .81),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: dynamicHeight(context, 0.016),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            dynamicWidth(context, .02),
                          ),
                          child: Hero(
                            tag: 1,
                            child: homeSlider(
                              context,
                              dynamicHeight(context, .36),
                              widget.image.length,
                              .6,
                              widget.image,
                              true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, 0.02),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: dynamicWidth(context, .06),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, 0.02),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Text(
                        "SKU : " +
                            widget.sku[skuIndex]["node"]["sku"].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: dynamicWidth(context, .04),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, 0.02),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Text(
                        "Rs. " +
                            double.parse(
                                    widget.price[priceIndex]["node"]["price"])
                                .toInt()
                                .toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: dynamicWidth(context, .044),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Divider(
                        thickness: 2,
                        height: dynamicHeight(context, .04),
                      ),
                    ),
                    (widget.array.toString().contains("Default") ||
                            widget.array == "")
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, .04),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Select Size",
                                  style: TextStyle(
                                    fontSize: dynamicWidth(context, .05),
                                    fontWeight: FontWeight.w600,
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
                                        fontSize: dynamicWidth(context, .04),
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
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, .04),
                            ),
                            child: Divider(
                              thickness: 2,
                              height: dynamicHeight(context, .03),
                            ),
                          ),
                    (widget.array.toString().contains("Default") ||
                            widget.array == "")
                        ? Container()
                        : sizeOptions(context, widget.array),
                    (widget.array.toString().contains("Default") ||
                            widget.array == "")
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dynamicWidth(context, .04),
                            ),
                            child: Divider(
                              thickness: 2,
                              endIndent: dynamicWidth(context, .1),
                              indent: dynamicWidth(context, .1),
                              height: dynamicHeight(context, .03),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Text(
                        "Select Quantity",
                        style: TextStyle(
                          fontSize: dynamicWidth(context, .05),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Divider(
                        thickness: 2,
                        height: dynamicHeight(context, .02),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dynamicHeight(context, .01),
                      ),
                      child: Center(
                        child: Container(
                          width: dynamicWidth(context, .4),
                          color: myWhite,
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
                                  width: dynamicWidth(context, .12),
                                  height: dynamicWidth(context, .12),
                                  color: myBlack,
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      size: dynamicWidth(context, .06),
                                      color: myWhite,
                                    ),
                                  ),
                                ),
                              ),
                              Obx(() {
                                return Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                    fontSize: dynamicWidth(context, .06),
                                  ),
                                );
                              }),
                              InkWell(
                                onTap: () {
                                  quantity++;
                                },
                                child: Container(
                                  width: dynamicWidth(context, .12),
                                  height: dynamicWidth(context, .12),
                                  color: myBlack,
                                  child: Icon(
                                    Icons.add,
                                    size: dynamicWidth(context, .06),
                                    color: myWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dynamicWidth(context, .04),
                      ),
                      child: Divider(
                        thickness: 2,
                        height: dynamicHeight(context, .02),
                      ),
                    ),
                    ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.zero,
                      animationDuration: Duration(milliseconds: 600),
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              title: Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: dynamicWidth(context, .05),
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            );
                          },
                          body: ListTile(
                            title: Text(widget.description),
                          ),
                          isExpanded: _expanded,
                          canTapOnHeader: true,
                          backgroundColor: myGrey,
                        ),
                      ],
                      elevation: 0.0,
                      expansionCallback: (panelIndex, isExpanded) {
                        _expanded = !_expanded;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
            bottomButton(
              context,
              widget.image[0]["node"]["src"],
              double.parse(widget.price[priceIndex]["node"]["price"])
                  .toInt()
                  .toString(),
              widget.text,
              quantity,
            )
          ],
        ),
      ),
    );
  }

  Widget sizeOptions(context, array, {function}) {
    return Container(
      height: dynamicHeight(context, .06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    priceIndex = index;
                    skuIndex = index;
                  });
                  print(selectedSize);
                  print(priceIndex);
                  print(skuIndex);
                },
                child: Ink(
                  child: CircleAvatar(
                    backgroundColor:
                        selectedSize == array[index] ? myRed : myBlack,
                    child: Text(
                      array[index].toString(),
                      style: TextStyle(color: myGrey),
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

Widget bottomButton(context, image, price, text, cartQuantity) {
  return Positioned(
    bottom: 0,
    child: MaterialButton(
      color: myRed,
      height: dynamicHeight(context, .062),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        if (cartItems.length == 0) {
          cartItems.add({
            "imageUrl": image,
            "price": price,
            "title": text,
            "quantity": cartQuantity,
            "total": int.parse(price.toString()) *
                int.parse(cartQuantity.toString()),
          });
        } else {
          if (text.toString() == cartItems[0]["title"]) {
            print(cartItems[0]["quantity"]);
            print(cartQuantity);
            cartItems[0]["quantity"] =
                int.parse(cartItems[0]["quantity"].toString()) +
                    int.parse(cartQuantity.toString());
            cartItems[0]["total"] =
                int.parse(cartItems[0]["price"].toString()) +
                    (int.parse(price.toString()) *
                        int.parse(cartQuantity.toString()));
          } else {
            cartItems.add({
              "imageUrl": image,
              "price": price,
              "title": text,
              "quantity": cartQuantity,
              "total": int.parse(price.toString()) *
                  int.parse(cartQuantity.toString()),
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
      child: Row(
        children: [
          Icon(
            Icons.add_shopping_cart_sharp,
            color: myWhite,
            size: dynamicWidth(context, .08),
          ),
          SizedBox(
            width: dynamicWidth(context, .04),
          ),
          Text(
            "Add to Cart",
            style: TextStyle(
              color: myWhite,
              fontSize: dynamicWidth(context, .05),
            ),
          ),
        ],
      ),
    ),
  );
}
