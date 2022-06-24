import 'package:hive/hive.dart';
import 'package:todo_with_getx/core/constants/hive_constant.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';

import '../core/enum/todo_enum.dart';
part 'todo_model.g.dart';

@HiveType(typeId: HiveConstants.todoModel)
class TodoModel {
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final DateTime? dataTime;
  @HiveField(4)
  final TodoCategories? todoCategories;
  @HiveField(5)
  final bool isCompleted;

  TodoModel({
    required this.title,
    required this.description,
    required this.dataTime,
    required this.todoCategories,
    required this.isCompleted,
  });
}
