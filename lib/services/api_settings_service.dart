import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:uuid/uuid.dart';

import '../data/app_database.dart';
import '../data/models/api_provider.dart';
import '../data/repositories/api_settings_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../data/repositories/contact_repository.dart';
import '../domain/entities/api_entities.dart';

class ApiSettingsService extends GetxService {
  ApiSettingsService({
    required AppDatabase database,
    ApiSettingsRepository? apiRepository,
    ContactRepository? contactRepository,
    ChatRepository? chatRepository,
  })  : _db = database,
        _apiRepository =
            apiRepository ?? ApiSettingsRepository(database: database),
        _contactRepository = contactRepository ?? ContactRepository(database),
        _chatRepository = chatRepository ?? ChatRepository(database);

  final AppDatabase _db;
  final ApiSettingsRepository _apiRepository;
  final ContactRepository _contactRepository;
  final ChatRepository _chatRepository;

  final endpoints = <ApiEndpoint>[].obs;
  final characters = <AiCharacter>[].obs;
  final persona = Rxn<UserPersona>();
  final worldInfos = <WorldInfoEntry>[].obs;
  final selectedEndpointId = ''.obs;
  final selectedCharacterId = ''.obs;

  StreamSubscription<List<ApiEndpoint>>? _endpointSub;
  StreamSubscription<List<AiCharacter>>? _characterSub;

  final _uuid = const Uuid();
  final _rand = Random();

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }

  Future<void> _initialize() async {
    await _ensureDefaults();
    await _loadInitialState();
    _listenForUpdates();
  }

  Future<void> _ensureDefaults() async {
    final endpointCount = await _db
        .select(_db.providerProfiles)
        .get()
        .then((value) => value.length);
    List<ApiEndpoint>? seededEndpoints;
    if (endpointCount == 0) {
      final defaults = _buildDefaultEndpoints();
      for (final endpoint in defaults) {
        await _apiRepository.upsertEndpoint(endpoint);
      }
      await _apiRepository.setSelectedEndpointId(defaults.first.id);
      seededEndpoints = defaults;
    }

    final contactCount =
        await _db.select(_db.contacts).get().then((value) => value.length);
    if (contactCount == 0) {
      final selectedEndpoint = await _apiRepository.getSelectedEndpointId();
      final availableEndpoints =
          seededEndpoints ?? await _apiRepository.loadEndpoints();
      final fallbackEndpoint = _resolveSelection(
        preferred: selectedEndpoint,
        available: availableEndpoints.map((e) => e.id).toList(),
      );
      final defaultCharacter = _buildDefaultCharacter(fallbackEndpoint);
      await _contactRepository.upsertCharacter(defaultCharacter);
      await _apiRepository.setSelectedCharacterId(defaultCharacter.id);
    }

    final personaRaw = await _apiRepository.loadUserPersonaRaw();
    if (personaRaw == null || personaRaw.isEmpty) {
      await _apiRepository.saveUserPersona(_defaultPersona());
    }
    final worldRaw = await _apiRepository.loadWorldInfosRaw();
    if (worldRaw == null || worldRaw.isEmpty) {
      await _apiRepository.saveWorldInfos(_defaultWorldInfos());
    }
  }

  Future<void> _loadInitialState() async {
    final endpointList = await _apiRepository.loadEndpoints();
    endpoints.assignAll(endpointList);
    final selectedEndpoint = await _apiRepository.getSelectedEndpointId();
    selectedEndpointId.value = _resolveSelection(
      preferred: selectedEndpoint,
      available: endpointList.map((e) => e.id).toList(),
    );
    if (selectedEndpointId.value.isNotEmpty) {
      await _apiRepository.setSelectedEndpointId(selectedEndpointId.value);
    }

    final characterList = await _contactRepository.loadCharacters();
    characters.assignAll(characterList);
    final selectedCharacter = await _apiRepository.getSelectedCharacterId();
    selectedCharacterId.value = _resolveSelection(
      preferred: selectedCharacter,
      available: characterList.map((e) => e.id).toList(),
    );
    if (selectedCharacterId.value.isNotEmpty) {
      await _apiRepository.setSelectedCharacterId(selectedCharacterId.value);
    }

    final personaRaw = await _apiRepository.loadUserPersonaRaw();
    if (personaRaw != null && personaRaw.isNotEmpty) {
      persona.value = _parsePersona(personaRaw);
    } else {
      persona.value = _defaultPersona();
    }

    final worldRaw = await _apiRepository.loadWorldInfosRaw();
    if (worldRaw != null && worldRaw.isNotEmpty) {
      worldInfos.assignAll(_parseWorldInfos(worldRaw));
    } else {
      worldInfos.assignAll(_defaultWorldInfos());
    }
  }

  void _listenForUpdates() {
    _endpointSub = _apiRepository.watchEndpoints().listen((list) async {
      endpoints.assignAll(list);
      final resolved = _resolveSelection(
        preferred: selectedEndpointId.value,
        available: list.map((e) => e.id).toList(),
      );
      if (resolved != selectedEndpointId.value) {
        selectedEndpointId.value = resolved;
        await _apiRepository.setSelectedEndpointId(resolved);
      }
    });

    _characterSub = _contactRepository.watchCharacters().listen((list) async {
      characters.assignAll(list);
      final resolved = _resolveSelection(
        preferred: selectedCharacterId.value,
        available: list.map((e) => e.id).toList(),
      );
      if (resolved != selectedCharacterId.value) {
        selectedCharacterId.value = resolved;
        await _apiRepository.setSelectedCharacterId(resolved);
      }
    });
  }

  String _resolveSelection(
      {required String? preferred, required List<String> available}) {
    if (preferred != null &&
        preferred.isNotEmpty &&
        available.contains(preferred)) {
      return preferred;
    }
    if (available.isNotEmpty) {
      return available.first;
    }
    return '';
  }

  ApiEndpoint? get selectedEndpoint => endpoints
      .firstWhereOrNull((element) => element.id == selectedEndpointId.value);

  AiCharacter? get selectedCharacter => characters
      .firstWhereOrNull((element) => element.id == selectedCharacterId.value);

  ApiEndpoint? endpointForCharacter(AiCharacter character) {
    final byId =
        endpoints.firstWhereOrNull((endpoint) => endpoint.id == character.endpointId);
    return byId ?? selectedEndpoint;
  }

  Future<void> addOrUpdateEndpoint(ApiEndpoint endpoint,
      {String? apiKey}) async {
    await _apiRepository.upsertEndpoint(endpoint, apiKey: apiKey);
    if (selectedEndpointId.value.isEmpty) {
      selectedEndpointId.value = endpoint.id;
      await _apiRepository.setSelectedEndpointId(endpoint.id);
    }
  }

  Future<void> updateGenerationConfig(
      {required ApiEndpoint endpoint, required GenerationConfig config}) async {
    await addOrUpdateEndpoint(endpoint.copyWith(generationConfig: config));
  }

  Future<void> setEnabledFunctions(
      {required ApiEndpoint endpoint, required List<String> functions}) async {
    await addOrUpdateEndpoint(endpoint.copyWith(enabledFunctions: functions));
  }

  Future<void> deleteEndpoint(String id) async {
    await _apiRepository.deleteEndpoint(id);
    final remaining = endpoints.where((element) => element.id != id).toList();
    final resolved = _resolveSelection(
      preferred: selectedEndpointId.value,
      available: remaining.map((e) => e.id).toList(),
    );
    selectedEndpointId.value = resolved;
    await _apiRepository.setSelectedEndpointId(resolved);
  }

  Future<String?> readEndpointKey(String id) =>
      _apiRepository.readEndpointKey(id);

  Future<void> setSelectedEndpoint(String id) async {
    selectedEndpointId.value = id;
    await _apiRepository.setSelectedEndpointId(id);
  }

  Future<void> addOrUpdateCharacter(AiCharacter character) async {
    await _contactRepository.upsertCharacter(character);
    if (selectedCharacterId.value.isEmpty) {
      selectedCharacterId.value = character.id;
      await _apiRepository.setSelectedCharacterId(character.id);
    }
  }

  Future<void> deleteCharacter(String id) async {
    final conversation = await (_db.select(_db.conversations)
          ..where((tbl) => tbl.contactId.equals(id)))
        .getSingleOrNull();
    if (conversation != null) {
      await _chatRepository.deleteConversation(conversation.id);
    }
    await _contactRepository.deleteCharacter(id);
    final remaining = characters.where((element) => element.id != id).toList();
    final resolved = _resolveSelection(
      preferred: selectedCharacterId.value,
      available: remaining.map((e) => e.id).toList(),
    );
    selectedCharacterId.value = resolved;
    await _apiRepository.setSelectedCharacterId(resolved);
  }

  Future<void> setSelectedCharacter(String id) async {
    selectedCharacterId.value = id;
    await _apiRepository.setSelectedCharacterId(id);
  }

  Future<void> setPersona(UserPersona? value) async {
    persona.value = value;
    if (value != null) {
      await _apiRepository.saveUserPersona(value);
    } else {
      await _apiRepository.saveUserPersona(_defaultPersona());
    }
  }

  Future<void> addOrUpdateWorldInfo(WorldInfoEntry entry) async {
    final list = [...worldInfos];
    final index = list.indexWhere((element) => element.id == entry.id);
    if (index >= 0) {
      list[index] = entry;
    } else {
      list.add(entry);
    }
    worldInfos.assignAll(list);
    await _apiRepository.saveWorldInfos(list);
  }

  Future<void> deleteWorldInfo(String id) async {
    final list = worldInfos.where((element) => element.id != id).toList();
    worldInfos.assignAll(list);
    await _apiRepository.saveWorldInfos(list);
  }

  Future<void> reorderWorldInfos(int oldIndex, int newIndex) async {
    final list = [...worldInfos];
    if (newIndex > oldIndex) newIndex -= 1;
    final entry = list.removeAt(oldIndex);
    list.insert(newIndex, entry);
    worldInfos.assignAll(list);
    await _apiRepository.saveWorldInfos(list);
  }

  String generateEndpointId() => _uuid.v4();

  String generateCharacterId() => _uuid.v4();

  String randomAvatarColorHex() {
    const palette = [
      0xFF07C160,
      0xFF5856D6,
      0xFFFF9500,
      0xFF34C759,
      0xFFFF3B30,
      0xFF5AC8FA,
    ];
    final value = palette[_rand.nextInt(palette.length)];
    return '#${value.toRadixString(16).substring(2).padLeft(6, '0')}';
  }

  List<ApiEndpoint> _buildDefaultEndpoints() {
    return [
      ApiEndpoint(
        id: generateEndpointId(),
        name: 'OpenAI 兼容',
        type: ApiProviderType.openai,
        baseUrl: 'https://api.openai.com/v1',
        model: 'gpt-4o-mini',
        keyLabel: 'OPENAI_KEY',
        notes: '示例配置，填写自己的 API Key 后即可使用。',
        enabledFunctions: const ['chat', 'vision'],
        generationConfig: const GenerationConfig(),
      ),
      ApiEndpoint(
        id: generateEndpointId(),
        name: 'Gemini 官方',
        type: ApiProviderType.gemini,
        baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
        model: 'gemini-1.5-flash',
        keyLabel: 'GEMINI_KEY',
        notes: '需要 Google API Key。',
        enabledFunctions: const ['chat', 'image'],
        generationConfig: const GenerationConfig(
            temperature: 0.8, topP: 0.95, maxTokens: 2048),
      ),
    ];
  }

  AiCharacter _buildDefaultCharacter(String endpointId) {
    return AiCharacter(
      id: generateCharacterId(),
      name: '知知狐',
      persona: '亲切耐心的智能伙伴，擅长中文对话与知识梳理。',
      greeting: '你好，我是知知狐，随时准备陪你聊聊。',
      endpointId: endpointId,
      avatarColorHex: randomAvatarColorHex(),
      sampleReplies: const [
        '这个问题我们可以从三个角度拆解。',
        '我记下来了，接下来要不要继续延展？',
        '好的，我会保持温柔的语气陪你聊。',
      ],
    );
  }

  UserPersona _defaultPersona() => const UserPersona(
        id: 'persona-default',
        displayName: '我',
        description: '保持好奇心、善于总结的创作者。',
        goals: '与 AI 合作头脑风暴、整理灵感、维持温暖的对话氛围。',
        style: '语气亲切，偶尔自嘲，关注情绪。',
      );

  List<WorldInfoEntry> _defaultWorldInfos() => [
        WorldInfoEntry(
          id: 'world-default-1',
          title: '聊天守则',
          content: '保持礼貌、尊重隐私、积极倾听，如有敏感或危险指向请及时提醒用户。',
          keywords: const ['守则', '安全', '提醒'],
          priority: 10,
          enabled: true,
        ),
      ];

  UserPersona _parsePersona(String storage) {
    final json = jsonDecode(storage) as Map<String, dynamic>;
    return UserPersona(
      id: json['id'] as String? ?? 'persona-default',
      displayName: json['displayName'] as String? ?? '我',
      description: json['description'] as String? ?? '',
      goals: json['goals'] as String? ?? '',
      style: json['style'] as String? ?? '',
    );
  }

  List<WorldInfoEntry> _parseWorldInfos(String storage) {
    final list = (jsonDecode(storage) as List)
        .map((e) => WorldInfoEntry(
              id: (e as Map)['id'] as String,
              title: e['title'] as String? ?? '',
              content: e['content'] as String? ?? '',
              keywords: (e['keywords'] as List?)
                      ?.map((item) => item.toString())
                      .toList() ??
                  const [],
              priority: (e['priority'] as num?)?.toInt() ?? 0,
              enabled: e['enabled'] as bool? ?? true,
            ))
        .toList();
    list.sort((a, b) => b.priority.compareTo(a.priority));
    return list;
  }

  @override
  void onClose() {
    _endpointSub?.cancel();
    _characterSub?.cancel();
    super.onClose();
  }
}
