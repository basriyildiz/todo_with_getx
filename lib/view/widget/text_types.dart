import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';

Padding buildHeader(String title, BuildContext context,
    [EdgeInsetsGeometry? padding, TextStyle? textStyle]) {
  return Padding(
    padding:
        padding ?? context.horizontalMediumPadding + context.verticalLowPadding,
    child: Text(
      title.toUpperCase(),
      style: textStyle ?? context.textTheme.headline5,
    ),
  );
}
