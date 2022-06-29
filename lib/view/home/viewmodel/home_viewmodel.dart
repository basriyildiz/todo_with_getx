import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:todo_with_getx/core/cache/hive_manager.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/model/todo_model.dart';
import 'package:todo_with_getx/view/auth/login/view/login_view.dart';

import '../../../core/enum/todo_enum.dart';
import '../../../model/login_model.dart';

class HomeViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeLoading(true);
    hiveManager = Get.find<HiveManager>();
    hiveManager.hiveInits().then((value) async {
      getCategories();
      getTodos();
      changeLoading(false);
    });
  }

  var isLoading = true.obs;
  late HiveManager hiveManager;
  List<TodoModel>? todos = <TodoModel>[].obs;
  List<TodoModel>? categoryTodos = <TodoModel>[].obs;
  List<TodoCategories>? categories = <TodoCategories>[].obs;
  double? value = .0;

  void changeLoading([bool? loading]) {
    isLoading.value = loading ?? !isLoading.value;
  }

  String? getUsername() {
    List<LoginModel>? users = hiveManager.loginModelCacheManager.getValues();
    if (users != null) {
      if (users.isNotEmpty) {
        return users.last.userName;
      } else {
        Get.to(LoginView());
      }
    }
  }

  void getTodos() {
    var manager = hiveManager.todoModelCacheManager;
    todos = manager.getValues();

    update();
  }

  Future<void> removeTodo(int? todoID) async {
    var manager = hiveManager.todoModelCacheManager;

    print("todoID: $todoID");
    await manager.removeItem(todoID.toString());

    todos?.removeWhere((element) => element.id == todoID);
    categoryTodos?.removeWhere((element) => element.id == todoID);
    update();
  }

  List<TodoModel>? getTodosByCategory(categoryId) {
    var manager = hiveManager.todoModelCacheManager;
    return manager.getValuesByCategory(categoryId);
  }

  void getCategories() {
    var manager = hiveManager.todoCategoryCacheManager;
    categories = manager.getValues();

    update();
  }

  void updateTodos() {
    var manager = hiveManager.todoModelCacheManager;

    if (todos != null) {
      if (todos!.isNotEmpty) {
        manager
            .clearAllThenInit()
            .then((value) async => await manager.putItems(todos!));
      }
    }
    update();
  }
}
