import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:monark_app/Screens/Orders.dart';

var imageArray = [
  {
    "title": "Women",
    "imageUrl":
        "https://img.freepik.com/free-photo/pretty-young-stylish-sexy-woman-pink-luxury-dress-summer-fashion-trend-chic-style-sunglasses-blue-studio-background-shopping-holding-paper-bags-talking-mobile-phone-shopaholic_285396-2957.jpg?size=626&ext=jpg"
  },
  {
    "title": "Men",
    "imageUrl":
        "https://lh3.googleusercontent.com/proxy/v6RSB_inzDEP7c0aW24epTTjNupkgFoZAYPtVJUDUrdfOvV1JHNE99R3vUYcr3-NO4jbtMewijbLQ4Z29TBCarqX7unswcPNEShUSXmYGWNluvOZoMnFCA"
  },
  {
    "title": "Kids",
    "imageUrl": "https://images.indianexpress.com/2019/10/girl-fashion.jpg"
  },
  {
    "title": "Adults",
    "imageUrl":
        "https://i.pinimg.com/550x/8e/22/d2/8e22d29cef155013a9e877730ba156c2.jpg"
  }
];
var featuredArray = [
  {
    "title": "Women T-Shirt",
    "price": r"$55",
    "imageUrl":
        "https://img.freepik.com/free-photo/smiling-student-woman-with-backpack-camera-going-vacation_149155-4472.jpg?size=626&ext=jpg"
  },
  {
    "title": "Man T-Shirt",
    "price": r"$67",
    "imageUrl":
        "https://i.pinimg.com/originals/4a/91/a6/4a91a6b4f09c7df99a6352db06f7a701.jpg"
  },
  {
    "title": "Kids T-Shirt",
    "price": r"$34",
    "imageUrl":
        "https://i.pinimg.com/originals/43/31/e4/4331e42e7bf7a458855018e5e070446d.jpg"
  },
];
var bestSell = [
  {
    "title": "Women T-Shirt",
    "price": r"$24",
    "imageUrl":
        "https://i.pinimg.com/originals/4a/91/a6/4a91a6b4f09c7df99a6352db06f7a701.jpg"
  },
  {
    "title": "Man T-Shirt",
    "price": r"$44",
    "imageUrl":
        "https://i.pinimg.com/originals/43/31/e4/4331e42e7bf7a458855018e5e070446d.jpg"
  },
  {
    "title": "Kids T-Shirt",
    "price": r"$98",
    "imageUrl":
        "https://www.textiletoday.com.bd/wp-content/uploads/2018/03/Kids_wear.jpg"
  },
];
var cartItems = [].obs;
var addressList = [].obs;
int group = 0;
bool obscureText = true;
List drawerItemList = [
  {"icon": Icons.person_outline, "text": "Profile", "screen": Orders()},
  {"icon": Icons.shopping_cart_outlined, "text": "Orders", "screen": Orders()},
  {"icon": Icons.notifications, "text": "Notifications", "screen": Orders()},
  {"icon": Icons.help, "text": "Help", "screen": Orders()},
  {"icon": Icons.star, "text": "Rate Us", "screen": Orders()},
  {"icon": Icons.question_answer, "text": "About Us", "screen": Orders()}
];
