import 'package:get/get.dart';

import '../../services/api_settings_service.dart';
import 'wechat_mock_logic.dart';

class WeChatMockBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ApiSettingsService>()) {
      Get.put(ApiSettingsService(), permanent: true);
    }
    Get.lazyPut(() => WeChatMockLogic());
  }
}
