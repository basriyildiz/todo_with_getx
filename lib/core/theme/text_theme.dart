import 'package:flutter/material.dart';

import '../constants/todo_colors.dart';

TextTheme buildTextTheme() {
  return const TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 32,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.bold,
      color: ColorConstants.grey,
      fontSize: 18,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.bold,
      color: ColorConstants.grey,
      fontSize: 14,
    ),
    bodyText1: TextStyle(
      fontWeight: FontWeight.bold,
      color: ColorConstants.grey,
      fontSize: 14,
    ),
  );
}
