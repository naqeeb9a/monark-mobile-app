import 'package:flutter/material.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';

class WishlistPage extends StatefulWidget {
  final String profileName;

  const WishlistPage({Key? key, required this.profileName}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  getWishList() async {
    Future.delayed(Duration(seconds: 0), () {
      return wishListItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        bgColor: noColor,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      drawerScrimColor: Colors.white54,
      endDrawer: drawer(context),
      body: Center(
        child: Container(
          width: dynamicWidth(context, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: dynamicHeight(context, .18),
                decoration: BoxDecoration(
                  color: noColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        darkTheme == true ? myWhite : myBlack.withOpacity(.4),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: dynamicHeight(context, .012),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: myRed,
                      size: dynamicWidth(context, 0.26),
                    ),
                  ),
                ),
              ),
              heightBox(context, 0.04),
              Text(
                titleCase(widget.profileName) + "'s Wishlist",
                style: TextStyle(
                  fontFamily: "Aeonik",
                  fontWeight: FontWeight.w600,
                  color: darkTheme == true ? myWhite : myBlack,
                  fontSize: dynamicWidth(context, .04),
                ),
              ),
              heightBox(context, 0.04),
              wishListItems.length == 0
                  ? Expanded(
                      child: Center(
                        child: Text(
                          "No items in Wishlist",
                          style: TextStyle(
                            color: darkTheme == true ? myWhite : myBlack,
                            fontSize: dynamicWidth(context, .05),
                          ),
                        ),
                      ),
                    )
                  : wishListGrid(
                      context,
                      () {
                        setState(() {});
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}

wishListGrid(context, refreshScreen) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: dynamicWidth(context, .04),
      ),
      child: GridView.builder(
        itemCount: wishListItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: dynamicWidth(context, .03),
          mainAxisSpacing: dynamicHeight(context, .01),
          crossAxisCount: 2,
          childAspectRatio: 5 / 8.5,
        ),
        itemBuilder: (context, index) {
          return Center(
            child: basicCards(
              context,
              wishListItems[index]["node"]["images"]["edges"],
              wishListItems[index]["node"]["title"],
              variantProduct: wishListItems[index]["node"]["variants"]["edges"],
              sizeOption: wishListItems[index]["node"]["options"][0]["values"],
              description: wishListItems[index]["node"]["description"],
              wishList: wishListItems[index],
              refreshScreen: refreshScreen,
            ),
          );
        },
      ),
    ),
  );
}
