import 'package:flutter/cupertino.dart';
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

  @override
  Widget build(BuildContext context) {
    return (_loading == true)
        ? Scaffold(
            body: jumpingDots(context),
          )
        : CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              backgroundColor: myRed,
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/icons/homeIcon.png",
                    ),
                    color: myWhite,
                    size: dynamicWidth(context, .06),
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Home",
                    style: TextStyle(
                      color: myWhite,
                      fontSize: dynamicWidth(context, .025),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/searchIcon.png",
                    width: dynamicWidth(context, .06),
                    color: myWhite,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Search",
                    style: TextStyle(
                      color: myWhite,
                      fontSize: dynamicWidth(context, .025),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/categoryIcon.png",
                    width: dynamicWidth(context, .06),
                    color: myWhite,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Categories",
                    style: TextStyle(
                      color: myWhite,
                      fontSize: dynamicWidth(context, .025),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/cartIcon.png",
                    width: dynamicWidth(context, .06),
                    color: myWhite,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "My Bag",
                    style: TextStyle(
                      color: myWhite,
                      fontSize: dynamicWidth(context, .025),
                    ),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/profileIcon.png",
                    width: dynamicWidth(context, .06),
                    color: myWhite,
                  ),
                  // ignore: deprecated_member_use
                  title: Text(
                    "Profile",
                    style: TextStyle(
                      color: myWhite,
                      fontSize: dynamicWidth(context, .025),
                    ),
                  ),
                ),
              ],
            ),
            tabBuilder: (context, index) {
              switch (index) {
                case 0:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: Home());
                    },
                  );
                case 1:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: SearchPage());
                    },
                  );
                case 2:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: CategoriesPage());
                    },
                  );
                case 3:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: Cart());
                    },
                  );
                case 4:
                  return CupertinoTabView(
                    builder: (context) {
                      return CupertinoPageScaffold(child: Profile());
                    },
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
            });
  }
}
