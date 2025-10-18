import 'package:get/get.dart';

import 'weather_logic.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherLogic());
  }
}
