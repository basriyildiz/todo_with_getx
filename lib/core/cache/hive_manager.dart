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
    _todoCategoryCacheManager = TodoCategoryCacheManager();
    await _todoCategoryCacheManager.init();
    _todoModelCacheManager = TodoCacheManager();
    await _todoModelCacheManager.init();
  }

  late TodoCacheManager _todoModelCacheManager;

  late TodoCategoryCacheManager _todoCategoryCacheManager;

  TodoCacheManager get todoModelCacheManager {
    
    return _todoModelCacheManager;
  }

  TodoCategoryCacheManager get todoCategoryCacheManager {
    return _todoCategoryCacheManager;
  }

  Future<void> clearAllHiveDatabae() async {
    await _todoModelCacheManager.clearAll();
    await _todoCategoryCacheManager.clearAll();
  }
}
