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

var cartItems = [].obs;
var wishListItems = [];
var addressList = [];
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
dynamic upperPriceFilter = 0.0;
