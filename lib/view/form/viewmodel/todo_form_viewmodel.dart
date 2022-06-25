import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/cache/hive_manager.dart';
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

  changeLoading([bool? loading]) {
    isLoading.value = loading ?? !isLoading.value;
  }

  getCategories() {
    changeLoading(true);
    categories = hiveManager.todoCategoryCacheManager
        .getValues(); //categories?.addAll();

    changeLoading(false);
  }

  late HiveManager hiveManager;

  Future<void> addTodo() async {
    changeLoading(true);
    TodoModel model = TodoModel(
      title: title,
      description: description,
      dataTime: DateTime.now(),
      todoCategories: category,
      isCompleted: false,
    );

    await hiveManager.todoModelCacheManager.addItem(model);
    changeLoading(false);
  }

  Future<void> addCategory(String? categoryName) async {
    int? currentCategoryId =
        hiveManager.todoCategoryCacheManager.getValues()?.length;

    TodoCategories model = TodoCategories(
        currentCategoryId != null ? currentCategoryId++ : 1, categoryName);
    print(model.categoryName);
    await hiveManager.todoCategoryCacheManager
        .putItem(model.id.toString(), model);

    categories?.add(model);

    update();
  }

  getData() {
    List<TodoCategories>? todoModels =
        hiveManager.todoCategoryCacheManager.getValues();
    for (var i = 0; i < ((todoModels?.length) ?? 0).toInt(); i++) {
      print(todoModels?[i].categoryName);
    }
  }
}
