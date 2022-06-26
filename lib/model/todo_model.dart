import 'package:hive/hive.dart';
import 'package:todo_with_getx/core/constants/hive_constant.dart';
import 'package:todo_with_getx/model/todo_categories_model.dart';

import '../core/enum/todo_enum.dart';
part 'todo_model.g.dart';

@HiveType(typeId: HiveConstants.todoModel)
class TodoModel {
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime? dataTime;
  @HiveField(4)
  TodoCategories? todoCategories;
  @HiveField(5)
  bool? isCompleted;
  @HiveField(6)
  int? id;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dataTime,
    required this.todoCategories,
    required this.isCompleted,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dataTime,
    TodoCategories? todoCategories,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dataTime: dataTime ?? this.dataTime,
      todoCategories: todoCategories ?? this.todoCategories,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
