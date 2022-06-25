import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';

import '../viewmodel/todo_form_viewmodel.dart';

DropdownMenuItem<String> buildCategoryAddDropDownMenuItem(
    TodoFormViewmodel controller, BuildContext context) {
  final alertFormKey = GlobalKey<FormState>();
  return DropdownMenuItem(
      enabled: false,
      value: "action",
      child: TextButton.icon(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (c) {
                  var dialogContext = c;
                  return StatefulBuilder(builder: (context, setState) {
                    return Dialog(
                      child: SizedBox(
                        height: 200,
                        child: _buildCategoryAddForm(
                          alertFormKey,
                          context,
                          controller,
                        ),
                      ),
                    );
                  });
                });
          },
          icon: Icon(Icons.add_rounded),
          label: Text("Add")));
}

Form _buildCategoryAddForm(GlobalKey<FormState> alertFormKey, BuildContext c,
    TodoFormViewmodel controller) {
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
                    ? await controller.addCategory(newValue)
                    : null;
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
