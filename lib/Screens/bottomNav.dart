import 'package:flutter/material.dart';
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

  final MaterialColor primaryColor = const MaterialColor(
    0xffb22f32,
    const <int, Color>{
      50: const Color(0xffb22f32),
      100: const Color(0xffb22f32),
      200: const Color(0xffb22f32),
      300: const Color(0xffb22f32),
      400: const Color(0xffb22f32),
      500: const Color(0xffb22f32),
      600: const Color(0xffb22f32),
      700: const Color(0xffb22f32),
      800: const Color(0xffb22f32),
      900: const Color(0xffb22f32),
    },
  );
  var iconSizes = 0.05;

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
            body: jumpingDots(context),
          )
        : Scaffold(
            body: pageDecider(),
            bottomNavigationBar: SizedBox(
              height: dynamicHeight(context, .056),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
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
                unselectedLabelStyle: TextStyle(
                  fontSize: dynamicWidth(context, 0.026),
                ),
                selectedLabelStyle: TextStyle(
                  fontSize: dynamicWidth(context, 0.026),
                ),
                backgroundColor: myRed,
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: myRed,
                    icon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 0.0,
                        top: dynamicHeight(context, .002),
                      ),
                      child: Image.asset(
                        "assets/icons/homeIcon.png",
                        width: dynamicWidth(context, iconSizes),
                        color: myWhite,
                      ),
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: myRed,
                    icon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 0.0,
                        top: dynamicHeight(context, .002),
                      ),
                      child: Image.asset(
                        "assets/icons/searchIcon.png",
                        width: dynamicWidth(context, iconSizes),
                        color: myWhite,
                      ),
                    ),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: myRed,
                    icon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 0.0,
                        top: dynamicHeight(context, .002),
                      ),
                      child: Image.asset(
                        "assets/icons/categoryIcon.png",
                        width: dynamicWidth(context, iconSizes),
                        color: myWhite,
                      ),
                    ),
                    label: "Categories",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: myRed,
                    icon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 0.0,
                        top: dynamicHeight(context, .002),
                      ),
                      child: Image.asset(
                        "assets/icons/cartIcon.png",
                        width: dynamicWidth(context, iconSizes),
                        color: myWhite,
                      ),
                    ),
                    label: "My Bag",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: myRed,
                    icon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 0.0,
                        top: dynamicHeight(context, .002),
                      ),
                      child: Image.asset(
                        "assets/icons/profileIcon.png",
                        width: dynamicWidth(context, iconSizes),
                        color: myWhite,
                      ),
                    ),
                    label: "Profile",
                  ),
                ],
              ),
            ),
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
        MaterialApp(
            title: 'Monark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Open Sans',
              primarySwatch: primaryColor,
              brightness: Brightness.light,
            ),
            home: Home()),
        MaterialApp(
            title: 'Monark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Open Sans',
              primarySwatch: primaryColor,
              brightness: Brightness.light,
            ),
            home: SearchPage()),
        MaterialApp(
            title: 'Monark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Open Sans',
              primarySwatch: primaryColor,
              brightness: Brightness.light,
            ),
            home: CategoriesPage(
              controller: _pageController,
            )),
        MaterialApp(
            title: 'Monark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Open Sans',
              primarySwatch: primaryColor,
              brightness: Brightness.light,
            ),
            home: Cart(
              controller: _pageController,
            )),
        MaterialApp(
            title: 'Monark',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Open Sans',
              primarySwatch: primaryColor,
              brightness: Brightness.light,
            ),
            home: Profile(
              controller: _pageController,
            ))
      ],
    );
  }
}
