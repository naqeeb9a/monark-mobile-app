import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Search.dart';
import 'package:monark_app/Screens/SeeAll.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: darkTheme == true ? darkThemeBlack : myWhite,
      appBar: bar(
        context,
        bgColor: Colors.transparent,
        menuIcon: true,
        leadingIcon: true,
        function: () {
          _scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      endDrawer: drawer(context),
      body: Container(
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
                  color: darkTheme == true ? myWhite : myBlack.withOpacity(.4),
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
                fontWeight: FontWeight.w600,
                color: darkTheme == true ? myWhite : myBlack,
                fontSize: dynamicWidth(context, .04),
              ),
            ),
            heightBox(context, 0.04),
            detailGrid(
              getSearchResults("polo"),
              context,
              false,
              expandedCheck: true,
            )
          ],
        ),
      ),
    );
  }
}
