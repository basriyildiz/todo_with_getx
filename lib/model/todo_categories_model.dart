import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_with_getx/core/constants/hive_constant.dart';
part 'todo_categories_model.g.dart';

@HiveType(typeId: HiveConstants.categoryModel)
class TodoCategories {
  @HiveField(1)
  final int? id;
  @HiveField(2)
  String? categoryName;
  @HiveField(3)
  int? categoryColorId;

  TodoCategories({
    required this.id,
    required this.categoryName,
    required this.categoryColorId,
  });

  TodoCategories copyWith({
    String? categoryName,
    int? categoryColorId,
  }) {
    return TodoCategories(
      id: id,
      categoryName: categoryName ?? this.categoryName,
      categoryColorId: categoryColorId ?? this.categoryColorId,
    );
  }
}
