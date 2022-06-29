import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/cache/hive_manager.dart';
import 'package:todo_with_getx/core/constants/todo_colors.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/model/todo_model.dart';
import 'package:todo_with_getx/view/form/view/add_category_dropdown_item.dart';

class TodoFormViewmodel extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeLoading(true);
    hiveManager = Get.find<HiveManager>();
    hiveManager
        .hiveInits()
        .then((value) => getCategories())
        .then((value) => changeLoading(false));
  }

  String? title;
  String? description;
  TodoCategories? category;
  RxBool isLoading = true.obs;
  List<TodoCategories>? categories = <TodoCategories>[].obs;
  List<DropdownMenuItem>? menuItems = <DropdownMenuItem>[].obs;

  TodoCategories? updateDrowdownValue() {
    if ((categories == null || categories!.isEmpty)) {
      category = null;
    } else {
      category = categories?.reversed.toList().first;
    }
    update();
  }

  void changeLoading([bool? loading]) {
    isLoading.value = loading ?? !isLoading.value;
  }

  Future<void> getCategories() async {
    changeLoading(true);
    var manager = await hiveManager.todoCategoryCacheManager;
    categories = manager.getValues()?.reversed.toList();

    changeLoading(false);
  }

  late HiveManager hiveManager;

  Future<void> addTodo() async {
    changeLoading(true);
    var manager = hiveManager.todoModelCacheManager;
    List<TodoModel>? todos = manager.getValues();
    int? todoID;
    if (todos != null && todos.isNotEmpty) {
      if (todos.last.id != null) {
        todoID = todos.last.id;
      }
    }
    todoID = todoID != null ? todoID + 1 : 1;
    debugPrint("id eklendi: $todoID");
    TodoModel model = TodoModel(
      id: todoID,
      title: title,
      description: description,
      dataTime: DateTime.now(),
      todoCategories: category,
      isCompleted: false,
    );
    manager.putItem(todoID.toString(), model);
    changeLoading(false);
    Get.snackbar(
      "${(title ?? "").capitalize} added to TODO's",
      "Category:  ${(category?.categoryName ?? "").capitalize}",
      backgroundColor: ColorConstants.grey,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> addCategory(String? categoryName) async {
    var manager = hiveManager.todoCategoryCacheManager;
    int? currentCategoryId = manager.getValues()?.length;

    int? id = currentCategoryId != null ? currentCategoryId++ : 1;

    TodoCategories model = TodoCategories(
        id: id,
        categoryName: categoryName,
        categoryColorId: id % (ColorConstants.categoryColors.length - 1));

    await manager.putItem(model.id.toString(), model);

    categories?.add(model);

    update();
  }

  getData() {}
}
