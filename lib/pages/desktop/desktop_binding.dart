import 'package:get/get.dart';

import 'desktop_logic.dart';

class DesktopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DesktopLogic());
  }
}
