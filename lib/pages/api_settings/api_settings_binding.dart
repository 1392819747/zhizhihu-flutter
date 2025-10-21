import 'package:get/get.dart';

import '../../data/app_database.dart';
import '../../services/api_settings_service.dart';
import 'api_settings_logic.dart';

class ApiSettingsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiSettingsService>()) {
      final db = Get.find<AppDatabase>();
      Get.put(ApiSettingsService(database: db), permanent: true);
    }
    Get.lazyPut(ApiSettingsLogic.new);
  }
}
