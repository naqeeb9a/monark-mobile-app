import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Search.dart';
import 'package:monark_app/Screens/SeeAll.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/app_bar.dart';
import 'package:monark_app/widgets/media_query.dart';

class WishlistPage extends StatelessWidget {
  final String profileName;
  const WishlistPage({Key? key, required this.profileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: bar(context,
          menuIcon: true, leadingIcon: true, bgColor: Colors.transparent),
      body: Container(
        width: dynamicWidth(context, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: dynamicWidth(context, 0.17),
              backgroundColor: myWhite,
              child: Icon(
                Icons.favorite,
                color: myRed,
                size: dynamicWidth(context, 0.2),
              ),
            ),
            heightBox(context, 0.04),
            Text(profileName + "'s Wishlist"),
            heightBox(context, 0.04),
            detailGrid(getSearchResults("polo"), context, false,
                expandedCheck: true)
          ],
        ),
      ),
    );
  }
}
