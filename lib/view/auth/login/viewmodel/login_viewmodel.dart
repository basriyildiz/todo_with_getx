import 'package:get/get.dart';
import 'package:todo_with_getx/core/cache/hive_manager.dart';
import 'package:todo_with_getx/core/cache/locale_cache.dart';
import 'package:todo_with_getx/view/home/view/home_view.dart';

import '../../../../model/login_model.dart';

class LoginViewmodel extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changeLoading(true);
    hiveManager = Get.find<HiveManager>();
    hiveManager.hiveInits().then((value) => managerLoginScreen());
  }

  void managerLoginScreen() {
    if (checkUserLogged() == true) {
      Get.to(HomeView());
    }

    changeLoading(false);
  }

  late HiveManager hiveManager;
  var isLoading = true.obs;

  void changeLoading([bool? loading]) {
    isLoading.value = loading ?? !isLoading.value;
  }

  Future<void> addUser(String? userName) async {
    var model = LoginModel(userName);
    await hiveManager.loginModelCacheManager.addItem(model);
    managerLoginScreen();
  }

  LoginModel? getUser() {
    List<LoginModel>? users = hiveManager.loginModelCacheManager.getValues();
    print(users);
    if (users != null) {
      if (users.isNotEmpty) {
        return users.last;
      }
    }
    return null;
  }

  bool checkUserLogged() {
    if (getUser() == null) {
      return false;
    } else {
      return true;
    }
  }
}
