import 'package:get/get.dart';
import 'package:todo_with_getx/core/cache/locale_cache.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/model/todo_model.dart';

class HiveManager extends GetxController {
  @override
  void onInit() {
    super.onInit();
    hiveInits();
  }

  Future<void> hiveInits() async {
    todoCategoryCacheManager = TodoCategoryCacheManager();
    await todoCategoryCacheManager.init();
    todoModelCacheManager = TodoCacheManager();
    await todoModelCacheManager.init();
  }

  late ICacheManager<TodoModel> todoModelCacheManager;

  late ICacheManager<TodoCategories> todoCategoryCacheManager;

  Future<void> clearAllHiveDatabae() async {
    await todoModelCacheManager.clearAll();
    await todoCategoryCacheManager.clearAll();
  }
}
