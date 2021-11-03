import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
                      height: dynamicHeight(context, 0.01),
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
                          child: InkWell(
                            onTap: () {
                              imageAlert(
                                context,
                                widget.image[0]["node"]["src"].toString(),
                                false,
                              );
                            },
                            child: Hero(
                              tag: 1,
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.image[0]["node"]["src"].toString(),
                                fit: BoxFit.cover,
                                height: dynamicHeight(context, .36),
                                placeholder: (context, string) {
                                  return Image.asset(
                                    "assets/loader.gif",
                                    scale: 7,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: dynamicHeight(context, 0.04),
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
              widget.image,
              double.parse(widget.price[priceIndex]["node"]["price"])
                  .toInt()
                  .toString(),
              widget.text,
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

Widget bottomButton(context, image, price, text) {
  return Positioned(
    bottom: 0,
    child: MaterialButton(
      color: myRed,
      height: dynamicHeight(context, .062),
      minWidth: MediaQuery.of(context).size.width,
      onPressed: () {
        cartItems.add({"imageUrl": image, "price": price, "title": text});
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
            size: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "Add to Cart",
            style: TextStyle(color: myWhite),
          ),
        ],
      ),
    ),
  );
}
