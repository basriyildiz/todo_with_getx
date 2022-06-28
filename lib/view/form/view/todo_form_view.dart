import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_with_getx/core/constants/todo_colors.dart';
import 'package:todo_with_getx/core/enum/todo_enum.dart';
import 'package:todo_with_getx/core/extension/padding_extension.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/view/form/view/add_category_dropdown_item.dart';
import 'package:todo_with_getx/view/form/viewmodel/todo_form_viewmodel.dart';
import 'package:todo_with_getx/view/home/view/home_view.dart';
import 'package:todo_with_getx/view/home/viewmodel/home_viewmodel.dart';

class TodoFormView extends StatelessWidget {
  TodoFormView({Key? key, required this.page}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final title = "Title";
  final description = "Description";
  final saved = "Save Data";
  final appBarTitle = "Add Todo";

  final Widget page;
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
            leading: IconButton(
                onPressed: () {
                  Get.to(() => page);
                },
                icon: const Icon(Icons.arrow_back_ios)),
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
      value: controller.category,
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
        return buildCategoryAddDropDownMenuItem(c, context);
      }
    });
  }

  SizedBox _buildSaveButton(TodoFormViewmodel controller) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState != null) {
            if (_formKey.currentState?.validate() == true) {
              _formKey.currentState?.save();
              await controller.addTodo();
              _formKey.currentState?.reset();
            }
          }
        },
        child: Text(saved),
      ),
    );
  }

  changed(value) {}
}
