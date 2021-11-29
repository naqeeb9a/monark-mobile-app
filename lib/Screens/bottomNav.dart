import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/Search.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPage = 0;
  var accessToken;
  var customerInfo;
  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      body: Container(
        child: Center(
          child: _getPage(currentPage, accessToken),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        iconSize: dynamicWidth(context, .07),
        selectedColor: myWhite,
        strokeColor: myWhite,
        unSelectedColor: myGrey,
        backgroundColor: myRed,
        items: [
          CustomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/homeIcon.png",
              width: dynamicWidth(context, .06),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                color: myWhite,
                fontSize: dynamicWidth(context, .034),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/searchIcon.png",
              width: dynamicWidth(context, .06),
            ),
            title: Text(
              "Search",
              style: TextStyle(
                color: myWhite,
                fontSize: dynamicWidth(context, .034),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/categoryIcon.png",
              width: dynamicWidth(context, .06),
            ),
            title: Text(
              "Categories",
              style: TextStyle(
                color: myWhite,
                fontSize: dynamicWidth(context, .034),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/cartIcon.png",
              width: dynamicWidth(context, .06),
            ),
            title: Text(
              "My Bag",
              style: TextStyle(
                color: myWhite,
                fontSize: dynamicWidth(context, .034),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Image.asset(
              "assets/icons/profileIcon.png",
              width: dynamicWidth(context, .06),
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                color: myWhite,
                fontSize: dynamicWidth(context, .034),
              ),
            ),
          ),
        ],
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }

  getToken() async {
    SharedPreferences saveUser = await SharedPreferences.getInstance();
    accessToken = saveUser.getString("loginInfo").toString();

    if (accessToken == "guest") {
      customerInfo = "guest";
    } else {
      customerInfo = await getUserData(accessToken);
    }
    return saveUser.getString("loginInfo").toString();
  }

  _getPage(int page, accessToken) {
    switch (page) {
      case 0:
        return Home(accessToken: accessToken);
      case 1:
        return SearchPage();
      case 2:
        return CategoriesPage();
      case 3:
        return const Cart();
      case 4:
        return Profile(
          customerInfo: customerInfo,
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text(
              ('TabBar Index Error'),
            ),
          ],
        );
    }
  }
}
