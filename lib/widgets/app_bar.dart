import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:monark_app/Screens/Cart.dart';

import '../config.dart';
import 'media_query.dart';

PreferredSizeWidget bar(context, check) {
  return PreferredSize(
    preferredSize: Size.fromHeight(
      dynamicHeight(context, .06),
    ),
    child: AppBar(
      title: Image.asset(
        "assets/monark landscape.jpg",
        width: dynamicWidth(context, .4),
      ),
      centerTitle: true,
      iconTheme: IconThemeData(
        color: myBlack,
      ),
      backgroundColor: myWhite,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(),
              ),
            );
          },
          icon: Obx(
            () {
              return Badge(
                badgeContent: Text(
                  cartItems.length.toString(),
                  style: TextStyle(
                    color: myWhite,
                  ),
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                ),
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            check == true ? Icons.search_outlined : Icons.filter_list,
          ),
        )
      ],
    ),
  );
}

PreferredSizeWidget bar2(context,
    {cartCheck = false, icon = Icons.clear_all, color = myBlack}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: color,
    ),
    title: Image.asset(
      "assets/monark landscape.jpg",
      width: dynamicWidth(context, .4),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      cartCheck == true
          ? IconButton(
              onPressed: () {
                if (icon == Icons.shopping_bag_outlined) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(),
                    ),
                  );
                } else {
                  cartItems.clear();
                }
              },
              icon: icon == Icons.shopping_bag_outlined
                  ? Obx(
                      () {
                        return Badge(
                          badgeContent: Text(
                            cartItems.length.toString(),
                            style: TextStyle(color: myWhite),
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                          ),
                        );
                      },
                    )
                  : Icon(icon),
            )
          : Container()
    ],
  );
}
