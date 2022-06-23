import '../enum/todo_enum.dart';

class TodoModel {
  final String? title;
  final String? description;
  final DateTime? dataTime;
  final TodoCategories? todoCategories;
  final bool isCompleted;

  TodoModel({
    required this.title,
    required this.description,
    required this.dataTime,
    required this.todoCategories,
    required this.isCompleted,
  });
}
