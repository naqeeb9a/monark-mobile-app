import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Data/CategoryData.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/config.dart';

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
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Text(
                    "Rs. " + widget.price,
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
                  Text(
                    widget.description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  (widget.array.toString().contains("Default"))
                      ? Container()
                      : Text(
                          "Select Size",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                  (widget.array.toString().contains("Default"))
                      ? Container()
                      : Divider(
                          thickness: 2,
                        ),
                  (widget.array.toString().contains("Default"))
                      ? Container()
                      : sizeOptions(widget.array, context),
                ],
              ),
            ),
            bottomButton(context, widget.image, widget.price, widget.text)
          ],
        ),
      ),
    );
  }
}

Widget sizeOptions(array, context) {
  print(array);
  return Container(
    height: MediaQuery.of(context).size.height * 0.03,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: array.length,
        itemBuilder: (context, index) {
          return CircleAvatar(
            backgroundColor: Color(0xffeeeeee),
            child: Text(
              array[index].toString(),
              style: TextStyle(color: Colors.black),
            ),
          );
        }),
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
        cartItems.add({
          "imageUrl": image,
          "price": price.toString().substring(0, price.length - 3),
          "title": text
        });
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
