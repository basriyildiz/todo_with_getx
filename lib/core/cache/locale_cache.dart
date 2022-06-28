import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_with_getx/core/constants/hive_constant.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';
import 'package:todo_with_getx/model/todo_model.dart';

abstract class ICacheManager<T> {
  final String key;
  Box<T>? _box;

  ICacheManager(this.key);

  Future<void> init() async {
    registerAdapters();
    if (!(_box?.isOpen ?? false)) {
      print(key);
      _box = await Hive.openBox<T>(key);
    }
  }

  Future<void> addItems(List<T> items);
  Future<void> addItem(T item);
  Future<void> putItem(String key, T item);
  Future<void> putItems(List<T> items);
  T? getItem(String itemKey);
  List<T>? getValues();
  void registerAdapters();

  Future<void> removeItem(String itemKey) async {
    await _box?.delete(itemKey);
  }

  Future<void> clearAll() async {
    await _box?.clear();
  }

  Future<void> clearAllThenInit() async {
    await clearAll().then((v) => init());
  }
}

class TodoCacheManager extends ICacheManager<TodoModel> {
  TodoCacheManager() : super(HiveConstants.todoModel.toString());

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.todoModel)) {
      Hive.registerAdapter(TodoModelAdapter());
    }
  }

  @override
  Future<void> addItems(List<TodoModel> items) async {
    await _box?.addAll(items);
  }

  @override
  Future<void> addItem(TodoModel item) async {
    await _box?.add(item);
  }

  @override
  Future<void> putItem(String key, TodoModel item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> putItems(List<TodoModel> items) async {
    await _box?.putAll(items.asMap());
  }

  @override
  TodoModel? getItem(String key) {
    return _box?.get(key);
  }

  @override
  List<TodoModel>? getValues() {
    print(_box?.keys);
    return _box?.values.toList();
  }

  List<TodoModel>? getValuesByCategory(int? categoryId) {
    return _box?.values
        .toList()
        .where((TodoModel element) => element.todoCategories?.id == categoryId)
        .toList();
  }
}

class TodoCategoryCacheManager extends ICacheManager<TodoCategories> {
  TodoCategoryCacheManager() : super(HiveConstants.categoryModel.toString());

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.categoryModel)) {
      Hive.registerAdapter(TodoCategoriesAdapter());
    }
  }

  @override
  Future<void> addItems(List<TodoCategories> items) async {
    await _box?.addAll(items);
  }

  @override
  Future<void> addItem(TodoCategories item) async {
    await _box?.add(item);
  }

  @override
  Future<void> putItem(String key, TodoCategories item) async {
    await _box?.put(key, item);
  }

  @override
  Future<void> putItems(List<TodoCategories> items) async {
    await _box?.putAll(items.asMap());
  }

  @override
  TodoCategories? getItem(String key) {
    return _box?.get(key);
  }

  @override
  List<TodoCategories>? getValues() {
    return _box?.values.toList();
  }
}
