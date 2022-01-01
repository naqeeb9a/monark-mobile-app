import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

const myWhite = Colors.white;
const myGrey = Color(0xfff0f0f0);
const myBlack = Color(0xff373737);
const darkThemeBlack = Color(0xff282828);
const myRed = Color(0xffB01F24);
const titleRed = Color(0xfff54337);
const stockGreen = Color(0xff25a799);
const noColor = Colors.transparent;
var globalContextHome;
var globalContextSearch;
var globalContextCategories;
var globalContextMyBag;
var globalContextProfile;

var cartItems = [].obs;
var wishListItems = [];
dynamic addressList = [];
dynamic guestAddressList = [];
var group = 0.obs;
bool obscureText = true;

var sizeColor = myBlack;
var globalAccessToken = "";
var checkOutEmail = "";
var id = "";
bool darkTheme = false;
dynamic sortFilterCheck = "";
dynamic sizeFilterCheck = "";

dynamic lowerPriceFilter = 0.0;
dynamic upperPriceFilter = 1000.0;
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
