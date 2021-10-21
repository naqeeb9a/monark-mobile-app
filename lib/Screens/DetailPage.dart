import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/SeeFullImage.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/media_query.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String price;
  final String text;
  final dynamic array;
  final dynamic description;

  const DetailPage({
    Key? key,
    required this.image,
    this.description,
    this.array,
    required this.price,
    required this.text,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context, cartCheck: true, icon: Icons.shopping_bag_outlined),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeFullImage(
                                        imageUrl: widget.image,
                                      )));
                        },
                        child: Hero(
                          tag: 1,
                          child: CachedNetworkImage(
                              imageUrl: widget.image,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 4,
                              placeholder: (context, string) {
                                return Image.asset(
                                  "assets/loader.gif",
                                  scale: 7,
                                );
                              }),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: dynamicHeight(context, 0.03),
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  (widget.price.contains("fetching"))
                      ? Text(
                          widget.price,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      : Text(
                          "Rs. " +
                              double.parse(widget.price).toInt().toString(),
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                  Divider(
                    thickness: 2,
                    endIndent: 50,
                    indent: 50,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  Html(
                    data: widget.description,
                    style: {
                      'p': Style(
                        maxLines: 4,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  (widget.array.toString().contains("Default") ||
                          widget.array == "")
                      ? Container()
                      : Text(
                          "Select Size",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                  (widget.array.toString().contains("Default") ||
                          widget.array == "")
                      ? Container()
                      : Divider(
                          thickness: 2,
                        ),
                  (widget.array.toString().contains("Default") ||
                          widget.array == "")
                      ? Container()
                      : sizeOptions(widget.array, context),
                ],
              ),
            ),
            bottomButton(context, widget.image,
                double.parse(widget.price).toInt().toString(), widget.text)
          ],
        ),
      ),
    );
  }
}

Widget sizeOptions(array, context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.08,
    child: Center(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: array.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dynamicWidth(context, .02),
            ),
            child: CircleAvatar(
              backgroundColor: myBlack,
              child: Text(
                array[index].toString(),
                style: TextStyle(color: myGrey),
              ),
            ),
          );
        },
      ),
    ),
  );
}

PreferredSizeWidget bar2(context, {cartCheck = false, icon = Icons.clear_all}) {
  return AppBar(
    leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_sharp)),
    iconTheme: IconThemeData(color: myBlack),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      (cartCheck == true)
          ? IconButton(
              onPressed: () {
                if (icon == Icons.shopping_bag_outlined) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                } else {
                  cartItems.clear();
                }
              },
              icon: (icon == Icons.shopping_bag_outlined)
                  ? Obx(() {
                      return Badge(
                          badgeContent: Text(
                            cartItems.length.toString(),
                            style: TextStyle(color: myWhite),
                          ),
                          child: Icon(Icons.shopping_bag_outlined));
                    })
                  : Icon(icon))
          : Container()
    ],
  );
}

Widget bottomButton(context, image, price, text) {
  return Positioned(
    bottom: 0,
    child: MaterialButton(
      color: myRed,
      height: MediaQuery.of(context).size.height / 14,
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
