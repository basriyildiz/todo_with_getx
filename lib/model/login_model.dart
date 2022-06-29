import 'package:hive/hive.dart';
import 'package:todo_with_getx/core/constants/hive_constant.dart';
part 'login_model.g.dart';
@HiveType(typeId: HiveConstants.userModel)
class LoginModel {
  @HiveField(1)
  String? userName;

  LoginModel(this.userName);
}
