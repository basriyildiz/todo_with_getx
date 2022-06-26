import 'package:flutter/material.dart';
import 'package:todo_with_getx/core/theme/text_theme.dart';

import '../constants/todo_colors.dart';

ThemeData buildThemeData() {
  return ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.pink),
    appBarTheme: _buildAppBar(),
    cardTheme: _buildCardTheme(),
    textTheme: buildTextTheme(),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.white70,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorConstants.pink),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
        shape: CircleBorder(),
        fillColor:
            MaterialStateProperty.resolveWith((states) => getColor(states))),
    primaryColor: ColorConstants.grey,
    scaffoldBackgroundColor: ColorConstants.lightBlue,
  );
}

AppBarTheme _buildAppBar() {
  return const AppBarTheme(
    actionsIconTheme: IconThemeData(color: ColorConstants.grey),
    iconTheme: IconThemeData(color: ColorConstants.grey),
    color: Colors.transparent,
    elevation: 0,
  );
}

CardTheme _buildCardTheme() {
  return CardTheme(
    color: ColorConstants.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 8,
    shadowColor: ColorConstants.primaryColor,
  );
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.red;
}
