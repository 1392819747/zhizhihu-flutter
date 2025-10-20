import 'package:get/get.dart';

import '../../services/api_settings_service.dart';
import 'api_settings_logic.dart';

class ApiSettingsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiSettingsService>()) {
      Get.put(ApiSettingsService(), permanent: true);
    }
    Get.lazyPut(() => ApiSettingsLogic());
  }
}
