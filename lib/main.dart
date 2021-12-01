import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:monark_app/Screens/Welcome.dart';

void main() {
  runApp(
    Phoenix(
      child: MyApp(),
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
      title: 'Monark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Aeonik',
        primarySwatch: primaryColor,
        brightness: Brightness.light,
      ),
      home: Welcome(),
    );
  }
}
