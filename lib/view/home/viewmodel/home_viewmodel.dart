import 'package:get/get.dart';
import 'package:todo_with_getx/core/cache/hive_manager.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/model/todo_model.dart';

import '../../../core/enum/todo_enum.dart';

class HomeViewModel extends GetxController {
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

    if (todos != null || todos!.isNotEmpty) {
      manager.clearAllThenInit().then((value) => manager.putItems(todos!));
      print("çall");
    }
    update();
  }
}
