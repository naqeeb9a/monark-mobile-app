import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monark_app/Screens/Cart.dart';
import 'package:monark_app/Screens/Categories.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/Profile.dart';
import 'package:monark_app/Screens/Search.dart';
import 'package:monark_app/utils/config.dart';
import 'package:monark_app/widgets/home_widgets.dart';
import 'package:monark_app/widgets/media_query.dart';
import 'package:monark_app/widgets/shopify_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = true;
    });
    checkLoginStatus(context, () async {
      SharedPreferences saveUser = await SharedPreferences.getInstance();
      setState(() {
        globalAccessToken = saveUser.getString("loginInfo")!;

        _loading = false;
      });
    });
  }

  var iconSizes = 0.05;

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
            body: jumpingDots(context),
          )
        : Scaffold(
            body: pageDecider(),
            bottomNavigationBar: BottomNavigationBar(
              enableFeedback: true,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                if (currentPage == index && currentPage == 0) {
                  Navigator.popUntil(
                      globalContextHome, (route) => route.isFirst);
                } else if (currentPage == index && currentPage == 1) {
                  Navigator.popUntil(
                      globalContextSearch, (route) => route.isFirst);
                } else if (currentPage == index && currentPage == 2) {
                  Navigator.popUntil(
                      globalContextCategories, (route) => route.isFirst);
                } else if (currentPage == index && currentPage == 3) {
                  Navigator.popUntil(
                      globalContextMyBag, (route) => route.isFirst);
                } else if (currentPage == index && currentPage == 4) {
                  Navigator.popUntil(
                      globalContextProfile, (route) => route.isFirst);
                } else {}
                setState(() {
                  currentPage = index;
                  _pageController.animateToPage(currentPage,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeInOut);
                });
              },
              currentIndex: currentPage,
              showUnselectedLabels: true,
              selectedItemColor: myWhite,
              unselectedItemColor: myWhite,
              unselectedLabelStyle:
                  TextStyle(fontSize: dynamicWidth(context, 0.026)),
              selectedLabelStyle:
                  TextStyle(fontSize: dynamicWidth(context, 0.026)),
              backgroundColor: myRed,
              items: [
                bottomItemModel("assets/icons/homeIcon.png", "Home"),
                bottomItemModel("assets/icons/searchIcon.png", "Search"),
                bottomItemModel("assets/icons/categoryIcon.png", "Categories"),
                bottomItemModel("assets/icons/cartIcon.png", "My Bag",
                    check: true),
                bottomItemModel("assets/icons/profileIcon.png", "Profile")
              ],
            ),
          );
  }

  bottomItemModel(icon, text, {check = false}) {
    return BottomNavigationBarItem(
      backgroundColor: myRed,
      icon: (check == true)
          ? Obx(() {
              return Badge(
                badgeColor: myWhite,
                badgeContent: Text(
                  cartItems.length.toString(),
                  style: TextStyle(fontSize: dynamicWidth(context, 0.02)),
                ),
                showBadge: cartItems.length == 0 ? false : true,
                child: Image.asset(
                  icon,
                  width: dynamicWidth(context, iconSizes),
                  color: myWhite,
                ),
              );
            })
          : Image.asset(
              icon,
              width: dynamicWidth(context, iconSizes),
              color: myWhite,
            ),
      label: text,
    );
  }

  pageDecider() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      children: [
        pageModel(Home()),
        pageModel(SearchPage()),
        pageModel(CategoriesPage(
          controller: _pageController,
        )),
        pageModel(Cart(
          controller: _pageController,
        )),
        pageModel(Profile(
          controller: _pageController,
        ))
      ],
    );
  }

  pageModel(page) {
    return MaterialApp(
        title: 'Monark',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Open Sans',
          primarySwatch: primaryColor,
          brightness: Brightness.light,
        ),
        home: page);
  }
}
