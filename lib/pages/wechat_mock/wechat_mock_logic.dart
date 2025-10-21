import 'package:get/get.dart';

import '../../services/api_settings_service.dart';

class ChatPreview {
  ChatPreview({required this.lastMessage, required this.lastTime});

  final String lastMessage;
  final DateTime lastTime;
}

class WeChatConversation {
  WeChatConversation({
    required this.character,
    required this.endpoint,
    required this.preview,
    required this.persona,
    required this.worldInfos,
  });

  final AiCharacter character;
  final ApiEndpoint endpoint;
  final ChatPreview preview;
  final UserPersona? persona;
  final List<WorldInfoEntry> worldInfos;

  GenerationConfig get generationConfig => endpoint.generationConfig;
}

class WeChatMockLogic extends GetxController {
  final ApiSettingsService _service = Get.find<ApiSettingsService>();

  ApiSettingsService get service => _service;

  final conversations = <WeChatConversation>[].obs;
  final previewHistory = <String, ChatPreview>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _rebuildConversations();
    ever(_service.characters, (_) => _rebuildConversations());
    ever(_service.endpoints, (_) => _rebuildConversations());
    ever(_service.persona, (_) => _rebuildConversations());
    ever(_service.worldInfos, (_) => _rebuildConversations());
  }

  void _rebuildConversations() {
    if (_service.endpoints.isEmpty) {
      conversations.clear();
      return;
    }
    final endpointMap = {for (final ep in _service.endpoints) ep.id: ep};
    final persona = _service.persona.value;
    final lore = _service.worldInfos.where((element) => element.enabled).toList();
    final list = _service.characters.map((character) {
      final endpoint = endpointMap[character.endpointId] ?? _service.selectedEndpoint ?? _service.endpoints.first;
      final preview = previewHistory[character.id] ??
          ChatPreview(lastMessage: character.greeting, lastTime: DateTime.now().subtract(const Duration(minutes: 5)));
      return WeChatConversation(
        character: character,
        endpoint: endpoint,
        preview: preview,
        persona: persona,
        worldInfos: lore,
      );
    }).toList();
    list.sort((a, b) => b.preview.lastTime.compareTo(a.preview.lastTime));
    conversations.assignAll(list);
  }

  void updatePreview(String characterId, ChatPreview preview) {
    previewHistory[characterId] = preview;
    _rebuildConversations();
  }

  AiCharacter? get defaultCharacter => _service.selectedCharacter ??
      (_service.characters.isNotEmpty ? _service.characters.first : null);

  ApiEndpoint? endpointForCharacter(AiCharacter character) => _service.ensureEndpointForCharacter(character);
}
