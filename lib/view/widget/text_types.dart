import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';

Padding buildHeader(String title, BuildContext context) {
  return Padding(
    padding: context.horizontalMediumPadding + context.verticalLowPadding,
    child: Text(
      title.toUpperCase(),
      style: context.textTheme.headline5,
    ),
  );
}
