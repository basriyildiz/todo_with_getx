import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_with_getx/core/constants/hive_constant.dart';
part 'todo_categories_model.g.dart';
@HiveType(typeId: HiveConstants.categoryModel)
class TodoCategories {
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String? categoryName;

  TodoCategories(this.id, this.categoryName);
}
