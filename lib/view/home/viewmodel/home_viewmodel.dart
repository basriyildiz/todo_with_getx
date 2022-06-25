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
    hiveManager = Get.find<HiveManager>();
    hiveManager.hiveInits().then((value) {
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
    todos = hiveManager.todoModelCacheManager.getValues();
    update();
  }

  void getCategories() {
    categories = hiveManager.todoCategoryCacheManager.getValues();
    update();
  }
}
