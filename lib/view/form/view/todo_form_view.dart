import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_with_getx/core/constants/todo_colors.dart';
import 'package:todo_with_getx/core/enum/todo_enum.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/view/form/viewmodel/todo_form_viewmodel.dart';

class TodoFormView extends StatelessWidget {
  TodoFormView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final title = "Title";
  final description = "Description";
  final saved = "Save Data";
  final appBarTitle = "Add Todo";
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoFormViewmodel>(
      init: TodoFormViewmodel(),
      builder: (TodoFormViewmodel controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(appBarTitle),
            centerTitle: true,
          ),
          body: SizedBox(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: context.allNormalPadding,
                child: Obx(() {
                  return Column(
                    children: [
                      const SizedBox(height: 12),
                      _buildStringTextFormField(
                          controller, title, true, context),
                      const SizedBox(height: 12),
                      _buildStringTextFormField(
                          controller, description, false, context),
                      const SizedBox(height: 12),
                      controller.isLoading.value
                          ? Shimmer.fromColors(
                              enabled: controller.isLoading.value,
                              baseColor: Colors.white,
                              highlightColor: Colors.grey.shade100,
                              child:
                                  _buildDropdownFormField(controller, context),
                            )
                          : _buildDropdownFormField(controller, context),
                      const Spacer(),
                      _buildSaveButton(controller),
                    ],
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }

  TextFormField _buildStringTextFormField(TodoFormViewmodel controller,
      String hint, bool isTitle, BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hint),
      enableSuggestions: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onSaved: (String? value) {
        isTitle
            ? titleOnSaved(value, controller)
            : descriptionOnSaved(value, controller);
      },
    );
  }

  titleOnSaved(String? value, TodoFormViewmodel controller) =>
      controller.title = value;
  descriptionOnSaved(String? value, TodoFormViewmodel controller) =>
      controller.description = value;

  DropdownButtonFormField _buildDropdownFormField(
      TodoFormViewmodel controller, BuildContext context) {
    _dropdownMenuItemGenerator(controller, context);
    return DropdownButtonFormField(
      onSaved: (value) => controller.category = value,
      value: (controller.categories == null || controller.categories!.isEmpty)
          ? null
          : controller.categories?.first,
      items: controller.menuItems,
      onChanged: changed,
    );
  }

  void _dropdownMenuItemGenerator(TodoFormViewmodel c, BuildContext context) {
    c.menuItems = List.generate((c.categories?.length ?? 0) + 1, (index) {
      if (index < (c.categories?.length ?? 0)) {
        var e = c.categories?[index];
        return DropdownMenuItem(value: e, child: Text(e?.categoryName ?? ""));
      } else {
        return _buildCategoryAddDropDownMenuItem(c, context);
      }
    });
  }

  DropdownMenuItem<String> _buildCategoryAddDropDownMenuItem(
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
                  _dropdownMenuItemGenerator(controller, c);
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

  SizedBox _buildSaveButton(TodoFormViewmodel controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState != null) {
            if (_formKey.currentState?.validate() == true) {
              _formKey.currentState?.save();
            }
            controller.addTodo();
          }
        },
        child: Text(saved),
      ),
    );
  }

  changed(value) {}
}
