import 'package:get/get.dart';

import 'cache/hive_manager.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HiveManager());
  }
}
