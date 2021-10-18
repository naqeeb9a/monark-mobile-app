import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monark_app/Screens/Home.dart';
import 'package:monark_app/Screens/Welcome.dart';
import 'package:monark_app/config.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: myRed,
    ),
  );
}

class MyApp extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        fontFamily: 'Basic-Commercial-LT-Com-Roman',
        primarySwatch: primaryColor,
      ),
      home: Welcome(),
    );
  }
}
