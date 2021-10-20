import 'package:flutter/material.dart';

dynamicWidth(BuildContext context, dynamic size) {
  return MediaQuery.of(context).size.width * size;
}

dynamicHeight(BuildContext context, dynamic size) {
  return MediaQuery.of(context).size.height * size;
}
