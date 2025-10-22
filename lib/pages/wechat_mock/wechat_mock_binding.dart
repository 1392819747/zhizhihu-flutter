import 'package:get/get.dart';

import '../../data/app_database.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/moment_repository.dart';
import '../../services/api_settings_service.dart';
import '../../services/chat_service.dart';
import 'wechat_mock_logic.dart';

class WeChatMockBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();
    if (!Get.isRegistered<ApiSettingsService>()) {
      Get.put(ApiSettingsService(database: db), permanent: true);
    }
    if (!Get.isRegistered<ChatRepository>()) {
      Get.put(ChatRepository(db), permanent: true);
    }
    if (!Get.isRegistered<MomentRepository>()) {
      Get.put(MomentRepository(db), permanent: true);
    }
    if (!Get.isRegistered<ChatService>()) {
      Get.put(
        ChatService(
          chatRepository: Get.find<ChatRepository>(),
          apiSettingsService: Get.find<ApiSettingsService>(),
        ),
        permanent: true,
      );
    }
    Get.lazyPut(
      () => WeChatMockLogic(
        apiSettingsService: Get.find<ApiSettingsService>(),
        chatRepository: Get.find<ChatRepository>(),
        chatService: Get.find<ChatService>(),
        momentRepository: Get.find<MomentRepository>(),
      ),
    );
  }
}
