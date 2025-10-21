import 'package:get/get.dart';

import '../../data/app_database.dart';
import '../../data/repositories/api_settings_repository.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/contact_repository.dart';
import '../../services/api_settings_service.dart';
import 'desktop_logic.dart';

class DesktopBinding extends Bindings {
  @override
  void dependencies() {
    final db = Get.find<AppDatabase>();
    if (!Get.isRegistered<ApiSettingsService>()) {
      Get.put(
        ApiSettingsService(
          database: db,
          apiRepository: ApiSettingsRepository(database: db),
          contactRepository: ContactRepository(db),
          chatRepository: ChatRepository(db),
        ),
        permanent: true,
      );
    }
    Get.lazyPut(DesktopLogic.new);
  }
}
