import 'package:get/get.dart';
import 'package:todo_with_getx/model/todo_model.dart';

import '../../../core/enum/todo_enum.dart';

class HomeViewModel extends GetxController {
  List<TodoModel> todos = [];
}
