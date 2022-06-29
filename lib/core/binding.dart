import 'package:get/get.dart';
import 'package:todo_with_getx/view/home/viewmodel/card_animation.dart';

import '../view/home/viewmodel/home_viewmodel.dart';
import 'cache/hive_manager.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HiveManager());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CardStatusAnimation());

    
    /*  Get.lazyPut(() => HiveManager());
  Get.put(() => HiveManager()); */
  }
}
