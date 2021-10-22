import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Address.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/config.dart';
import 'package:monark_app/widgets/app_bar.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar2(context, cartCheck: true),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              rowText("Cart", context),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return Text("Total items : " + cartItems.length.toString());
              }),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return Flexible(
                    child: (cartItems.length == 0)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/emptyCart.png"),
                              SizedBox(
                                height: 20,
                              ),
                              Text("No Items in Cart")
                            ],
                          )
                        : cartList());
              }),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              )
            ]),
          ),
          bottomButton1(context, "Continue", () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddressPage()));
          })
        ],
      ),
    );
  }
}

Widget cartList({ordersPage = false}) {
  return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return cartCard(index, context, orders: ordersPage);
      });
}

Widget cartCard(index, context, {orders}) {
  var quantity = 1.obs;
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(color: myWhite, boxShadow: [
      BoxShadow(
          color: Color(0xFFeeeeee),
          spreadRadius: 6,
          blurRadius: 4,
          offset: Offset(2, 2))
    ]),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: cartItems[index]["imageUrl"],
            height: MediaQuery.of(context).size.height / 9,
            width: MediaQuery.of(context).size.width / 4,
            fit: BoxFit.cover,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cartItems[index]["title"],
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  cartItems[index]["price"],
                  style: TextStyle(color: myRed),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  padding: EdgeInsets.all(10),
                  color: (orders == true) ? Colors.blue : Color(0xFFeeeeee),
                  child: (orders == true)
                      ? Center(
                          child: Text(
                            "Order Again",
                            style: TextStyle(
                                color: myWhite,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (quantity > 1) {
                                  quantity--;
                                }
                              },
                              child: Icon(
                                Icons.remove,
                                size: 15,
                              ),
                            ),
                            Obx(() {
                              return Text(quantity.toString());
                            }),
                            InkWell(
                              onTap: () {
                                quantity++;
                              },
                              child: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                )
              ],
            ),
          ),
          (orders == true)
              ? Container()
              : Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        cartItems.remove(cartItems[index]);
                      },
                      child: Icon(Icons.close)))
        ],
      ),
    ),
  );
}

Widget bottomButton1(context, text, page) {
  return Positioned(
    bottom: 20,
    child: MaterialButton(
      color: myRed,
      height: MediaQuery.of(context).size.height * 0.06,
      minWidth: MediaQuery.of(context).size.width / 1.3,
      onPressed: page,
      child: Text(
        text,
        style: TextStyle(color: myWhite),
      ),
    ),
  );
}
