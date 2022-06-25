import 'package:get/get.dart';

import 'cache/hive_manager.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(HiveManager());
    /*  Get.lazyPut(() => HiveManager());
  Get.put(() => HiveManager()); */
  }
}
