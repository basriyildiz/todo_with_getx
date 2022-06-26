import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/view/home/viewmodel/home_viewmodel.dart';

import '../viewmodel/todo_form_viewmodel.dart';

DropdownMenuItem<String> buildCategoryAddDropDownMenuItem(
    TodoFormViewmodel? controller, BuildContext context) {
  final alertFormKey = GlobalKey<FormState>();
  return DropdownMenuItem(
      enabled: false,
      value: "action",
      child: TextButton.icon(
          onPressed: () async {
            Get.back();
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  BuildContext dialogContext = context;
                  return Dialog(
                    child: SizedBox(
                      height: 200,
                      child: _buildCategoryAddForm(
                        alertFormKey,
                        dialogContext,
                        controller,
                      ),
                    ),
                  );
                }).then((value) {
              Get.snackbar(
                  "Category Added",
                  "${controller?.category?.categoryName ?? ""} added to categories");
              /*      Get.showSnackbar(
                GetSnackBar(
                  snackPosition: SnackPosition.TOP,
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.black,
                  title: "Category Added",
                  messageText: Text(
                    controller?.category?.categoryName ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ); */
            });
          },
          icon: Icon(Icons.add_rounded),
          label: Text("Add")));
}

Form _buildCategoryAddForm(GlobalKey<FormState> alertFormKey, BuildContext c,
    TodoFormViewmodel? controller) {
  controller ??= Get.find<TodoFormViewmodel>();
  return Form(
      key: alertFormKey,
      child: Padding(
        padding: c.allLowPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Add Category",
              style: c.textTheme.headline6,
            ),
            TextFormField(
              onSaved: (String? newValue) async {
                newValue != null
                    ? await controller?.addCategory(newValue)
                    : null;
                controller?.updateDrowdownValue();
                Get.back();

                // Get.back();
              },
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (alertFormKey.currentState != null) {
                    if (alertFormKey.currentState?.validate() == true) {
                      alertFormKey.currentState?.save();
                    }
                  }
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ));
}
