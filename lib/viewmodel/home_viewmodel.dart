import 'package:get/get.dart';
import 'package:todo_with_getx/enum/todo_enum.dart';
import 'package:todo_with_getx/model/todo_model.dart';

class HomeViewModel extends GetxController {
  List<TodoModel> todos = [];
  TodoModel model = TodoModel(
      title: "T",
      description: "asdasd",
      dataTime: DateTime.now(),
      todoCategories: TodoCategories.cleaning,
      isCompleted: false);
}
