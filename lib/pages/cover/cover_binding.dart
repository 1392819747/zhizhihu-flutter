import 'package:get/get.dart';

import 'cover_logic.dart';

class CoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoverLogic>(() => CoverLogic());
  }
}
