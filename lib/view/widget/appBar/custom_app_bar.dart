import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    leading: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu_rounded),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.search_rounded),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_rounded),
      ),
    ],
  );
}
