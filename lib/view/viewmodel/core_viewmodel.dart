import 'package:get/get.dart';

import '../../core/cache/hive_manager.dart';
import '../../model/todo_categories_model.dart';
import '../../model/todo_model.dart';

class CoreViewmodel extends GetxController {
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
  List<TodoCategories>? categories = <TodoCategories>[].obs;

  void changeLoading([bool? loading]) {
    isLoading.value = loading ?? !isLoading.value;
  }

  void getTodos() {
    var manager = hiveManager.todoModelCacheManager;
    todos = manager.getValues();

    update();
  }

  removeTodo(int? todoID) {
    var manager = hiveManager.todoModelCacheManager;
    manager.removeItem(todoID.toString());
  }

  List<TodoModel>? getTodosByCategory(categoryId) {
    var manager = hiveManager.todoModelCacheManager;
    return manager.getValuesByCategory(categoryId);
  }

  List<TodoCategories>? getCategories() {
    var manager = hiveManager.todoCategoryCacheManager;
    return manager.getValues();
  }

  void updateTodos() {
    var manager = hiveManager.todoModelCacheManager;

    if (todos != null || todos!.isNotEmpty) {
      manager
          .clearAllThenInit()
          .then((value) async => await manager.putItems(todos!));
      print("updated");
    }
    update();
  }
}
