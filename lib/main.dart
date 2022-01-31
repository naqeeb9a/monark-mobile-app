import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:monark_app/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/bottomNav.dart';

void main() {
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  checkTheme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var temp = pref.getBool("darkThemeCheck");
    if (temp == true) {
      darkTheme = true;
    } else if (temp == false) {
      darkTheme = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkTheme();
    return MaterialApp(
      title: 'Monark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primarySwatch: primaryColor,
        brightness: Brightness.light,
      ),

      home: BottomNav(),
    );
  }
}
