import 'package:get/get.dart';

import '../../../core/cache/hive_manager.dart';
import '../../../model/todo_model.dart';

class CategoryViewmodel extends GetxController {
  CategoryViewmodel(this.todoID);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeLoading(true);
    hiveManager = Get.find<HiveManager>();
    hiveManager.hiveInits().then((value) async {
      getTodosByCategory(todoID);

      changeLoading(false);
    });
  }

  final int? todoID;
  var isLoading = true.obs;
  late HiveManager hiveManager;
  List<TodoModel>? todos = <TodoModel>[].obs;

  void changeLoading([bool? loading]) {
    isLoading.value = loading ?? !isLoading.value;
  }

  void getTodosByCategory(categoryId) {
    var manager = hiveManager.todoModelCacheManager;
    todos = manager.getValuesByCategory(categoryId);
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
