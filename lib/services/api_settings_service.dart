import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openim_common/openim_common.dart';
import 'package:uuid/uuid.dart';

/// 支持的 API 提供方类型。
enum ApiProviderType { openai, gemini }

ApiProviderType apiProviderTypeFromString(String value) {
  switch (value) {
    case 'gemini':
      return ApiProviderType.gemini;
    case 'openai':
    default:
      return ApiProviderType.openai;
  }
}

String apiProviderTypeToString(ApiProviderType type) {
  switch (type) {
    case ApiProviderType.gemini:
      return 'gemini';
    case ApiProviderType.openai:
      return 'openai';
  }
}

class ApiEndpoint {
  const ApiEndpoint({
    required this.id,
    required this.name,
    required this.type,
    required this.baseUrl,
    required this.apiKey,
    required this.model,
    this.notes = '',
    this.enabledFunctions = const [],
    this.generationConfig = const GenerationConfig(),
  });

  final String id;
  final String name;
  final ApiProviderType type;
  final String baseUrl;
  final String apiKey;
  final String model;
  final String notes;
  final List<String> enabledFunctions;
  final GenerationConfig generationConfig;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': apiProviderTypeToString(type),
        'baseUrl': baseUrl,
        'apiKey': apiKey,
        'model': model,
        'notes': notes,
        'enabledFunctions': enabledFunctions,
        'generationConfig': generationConfig.toJson(),
      };

  factory ApiEndpoint.fromJson(Map<String, dynamic> json) => ApiEndpoint(
        id: json['id'] as String,
        name: json['name'] as String,
        type: apiProviderTypeFromString(json['type'] as String? ?? 'openai'),
        baseUrl: json['baseUrl'] as String? ?? '',
        apiKey: json['apiKey'] as String? ?? '',
        model: json['model'] as String? ?? '',
        notes: json['notes'] as String? ?? '',
        enabledFunctions: (json['enabledFunctions'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
        generationConfig: GenerationConfig.fromJson(
          Map<String, dynamic>.from(
            (json['generationConfig'] as Map?) ?? const {},
          ),
        ),
      );

  ApiEndpoint copyWith({
    String? id,
    String? name,
    ApiProviderType? type,
    String? baseUrl,
    String? apiKey,
    String? model,
    String? notes,
    List<String>? enabledFunctions,
    GenerationConfig? generationConfig,
  }) =>
      ApiEndpoint(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        baseUrl: baseUrl ?? this.baseUrl,
        apiKey: apiKey ?? this.apiKey,
        model: model ?? this.model,
        notes: notes ?? this.notes,
        enabledFunctions: enabledFunctions ?? this.enabledFunctions,
        generationConfig: generationConfig ?? this.generationConfig,
      );
}

class AiCharacter {
  const AiCharacter({
    required this.id,
    required this.name,
    required this.persona,
    required this.greeting,
    required this.endpointId,
    required this.avatarColorHex,
    required this.sampleReplies,
  });

  final String id;
  final String name;
  final String persona;
  final String greeting;
  final String endpointId;
  final String avatarColorHex;
  final List<String> sampleReplies;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'persona': persona,
        'greeting': greeting,
        'endpointId': endpointId,
        'avatarColorHex': avatarColorHex,
        'sampleReplies': sampleReplies,
      };

  factory AiCharacter.fromJson(Map<String, dynamic> json) => AiCharacter(
        id: json['id'] as String,
        name: json['name'] as String? ?? '',
        persona: json['persona'] as String? ?? '',
        greeting: json['greeting'] as String? ?? '',
        endpointId: json['endpointId'] as String? ?? '',
        avatarColorHex: json['avatarColorHex'] as String? ?? '#07C160',
        sampleReplies: (json['sampleReplies'] as List?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
      );

  AiCharacter copyWith({
    String? id,
    String? name,
    String? persona,
    String? greeting,
    String? endpointId,
    String? avatarColorHex,
    List<String>? sampleReplies,
  }) =>
      AiCharacter(
        id: id ?? this.id,
        name: name ?? this.name,
        persona: persona ?? this.persona,
        greeting: greeting ?? this.greeting,
        endpointId: endpointId ?? this.endpointId,
        avatarColorHex: avatarColorHex ?? this.avatarColorHex,
        sampleReplies: sampleReplies ?? this.sampleReplies,
      );

  Color get avatarColor => Color(int.parse(avatarColorHex.substring(1), radix: 16) + 0xFF000000);
}

class ApiSettingsService extends GetxService {
  static const _endpointsKey = 'api_settings.endpoints';
  static const _charactersKey = 'api_settings.characters';
  static const _selectedEndpointKey = 'api_settings.selected_endpoint';
  static const _selectedCharacterKey = 'api_settings.selected_character';
  static const _personaKey = 'api_settings.user_persona';
  static const _worldInfoKey = 'api_settings.world_info';

  final endpoints = <ApiEndpoint>[].obs;
  final characters = <AiCharacter>[].obs;
  final selectedEndpointId = ''.obs;
  final selectedCharacterId = ''.obs;
  final persona = Rxn<UserPersona>();
  final worldInfos = <WorldInfoEntry>[].obs;

  ApiSettingsService() {
    _loadState();
  }

  void _loadState() {
    try {
      final endpointsJson = SpUtil().getString(_endpointsKey, defValue: '') ?? '';
      if (endpointsJson.isNotEmpty) {
        final list = (jsonDecode(endpointsJson) as List)
            .map((e) => ApiEndpoint.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
        endpoints.assignAll(list);
      }
    } catch (e) {
      Logger.print('加载 API 配置失败: $e', onlyConsole: true);
      endpoints.clear();
    }

    try {
      final charsJson = SpUtil().getString(_charactersKey, defValue: '') ?? '';
      if (charsJson.isNotEmpty) {
        final list = (jsonDecode(charsJson) as List)
            .map((e) => AiCharacter.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
        characters.assignAll(list);
      }
    } catch (e) {
      Logger.print('加载 AI 角色失败: $e', onlyConsole: true);
      characters.clear();
    }

    try {
      final personaJson = SpUtil().getString(_personaKey, defValue: '') ?? '';
      if (personaJson.isNotEmpty) {
        persona.value = UserPersona.fromJson(
          Map<String, dynamic>.from(jsonDecode(personaJson) as Map),
        );
      }
    } catch (e) {
      Logger.print('加载用户个性失败: $e', onlyConsole: true);
      persona.value = null;
    }

    try {
      final worldJson = SpUtil().getString(_worldInfoKey, defValue: '') ?? '';
      if (worldJson.isNotEmpty) {
        final list = (jsonDecode(worldJson) as List)
            .map((e) => WorldInfoEntry.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
        worldInfos.assignAll(list);
      }
    } catch (e) {
      Logger.print('加载世界信息失败: $e', onlyConsole: true);
      worldInfos.clear();
    }

    selectedEndpointId.value =
        SpUtil().getString(_selectedEndpointKey, defValue: endpoints.isNotEmpty ? endpoints.first.id : '') ?? '';
    if (selectedEndpointId.value.isEmpty && endpoints.isNotEmpty) {
      selectedEndpointId.value = endpoints.first.id;
    }

    selectedCharacterId.value =
        SpUtil().getString(_selectedCharacterKey, defValue: characters.isNotEmpty ? characters.first.id : '') ?? '';
    if (selectedCharacterId.value.isEmpty && characters.isNotEmpty) {
      selectedCharacterId.value = characters.first.id;
    }

    if (endpoints.isEmpty) {
      final defaults = _buildDefaultEndpoints();
      endpoints.assignAll(defaults);
      selectedEndpointId.value = defaults.first.id;
      _persistEndpoints();
    }

    if (characters.isEmpty) {
      final defaults = _buildDefaultCharacters();
      characters.assignAll(defaults);
      selectedCharacterId.value = defaults.first.id;
      _persistCharacters();
    }

    if (persona.value == null) {
      persona.value = _buildDefaultPersona();
      _persistPersona();
    }
  }

  Future<void> addOrUpdateEndpoint(ApiEndpoint endpoint) async {
    final index = endpoints.indexWhere((element) => element.id == endpoint.id);
    if (index >= 0) {
      endpoints[index] = endpoint;
    } else {
      endpoints.add(endpoint);
    }
    endpoints.refresh();
    await _persistEndpoints();
    if (selectedEndpointId.value.isEmpty) {
      setSelectedEndpoint(endpoint.id);
    }
  }

  Future<void> deleteEndpoint(String id) async {
    endpoints.removeWhere((element) => element.id == id);
    await _persistEndpoints();
    if (selectedEndpointId.value == id) {
      if (endpoints.isNotEmpty) {
        setSelectedEndpoint(endpoints.first.id);
      } else {
        selectedEndpointId.value = '';
        await SpUtil().remove(_selectedEndpointKey);
      }
    }
    // 清理引用该 endpoint 的角色
    final updated = characters.map((c) => c.endpointId == id ? c.copyWith(endpointId: '') : c).toList();
    characters.assignAll(updated);
    await _persistCharacters();
  }

  Future<void> setSelectedEndpoint(String id) async {
    selectedEndpointId.value = id;
    await SpUtil().putString(_selectedEndpointKey, id);
  }

  ApiEndpoint? getEndpointById(String id) {
    return endpoints.firstWhereOrNull((element) => element.id == id);
  }

  Future<void> addOrUpdateCharacter(AiCharacter character) async {
    final index = characters.indexWhere((element) => element.id == character.id);
    if (index >= 0) {
      characters[index] = character;
    } else {
      characters.add(character);
    }
    characters.refresh();
    await _persistCharacters();
    if (selectedCharacterId.value.isEmpty) {
      setSelectedCharacter(character.id);
    }
  }

  Future<void> deleteCharacter(String id) async {
    characters.removeWhere((element) => element.id == id);
    await _persistCharacters();
    if (selectedCharacterId.value == id) {
      if (characters.isNotEmpty) {
        setSelectedCharacter(characters.first.id);
      } else {
        selectedCharacterId.value = '';
        await SpUtil().remove(_selectedCharacterKey);
      }
    }
  }

  Future<void> setSelectedCharacter(String id) async {
    selectedCharacterId.value = id;
    await SpUtil().putString(_selectedCharacterKey, id);
  }

  Future<void> _persistEndpoints() async {
    final jsonStr = jsonEncode(endpoints.map((e) => e.toJson()).toList());
    await SpUtil().putString(_endpointsKey, jsonStr);
    endpoints.refresh();
  }

  Future<void> _persistCharacters() async {
    final jsonStr = jsonEncode(characters.map((e) => e.toJson()).toList());
    await SpUtil().putString(_charactersKey, jsonStr);
    characters.refresh();
  }

  Future<void> _persistPersona() async {
    final value = persona.value;
    if (value == null) {
      await SpUtil().remove(_personaKey);
    } else {
      await SpUtil().putString(_personaKey, jsonEncode(value.toJson()));
    }
  }

  Future<void> _persistWorldInfos() async {
    final jsonStr = jsonEncode(worldInfos.map((e) => e.toJson()).toList());
    await SpUtil().putString(_worldInfoKey, jsonStr);
    worldInfos.refresh();
  }

  ApiEndpoint? get selectedEndpoint => getEndpointById(selectedEndpointId.value);

  AiCharacter? get selectedCharacter =>
      characters.firstWhereOrNull((element) => element.id == selectedCharacterId.value);

  ApiEndpoint ensureEndpointForCharacter(AiCharacter character) {
    final endpoint = getEndpointById(character.endpointId);
    return endpoint ?? selectedEndpoint ?? endpoints.first;
  }

  Future<void> updateGenerationConfig({
    required ApiEndpoint endpoint,
    required GenerationConfig config,
  }) async {
    final updated = endpoint.copyWith(generationConfig: config);
    await addOrUpdateEndpoint(updated);
  }

  Future<void> setEnabledFunctions({
    required ApiEndpoint endpoint,
    required List<String> functions,
  }) async {
    final updated = endpoint.copyWith(enabledFunctions: functions);
    await addOrUpdateEndpoint(updated);
  }

  Future<void> setPersona(UserPersona? value) async {
    persona.value = value;
    await _persistPersona();
  }

  Future<void> addOrUpdateWorldInfo(WorldInfoEntry entry) async {
    final index = worldInfos.indexWhere((element) => element.id == entry.id);
    if (index >= 0) {
      worldInfos[index] = entry;
    } else {
      worldInfos.add(entry);
    }
    await _persistWorldInfos();
  }

  Future<void> deleteWorldInfo(String id) async {
    worldInfos.removeWhere((element) => element.id == id);
    await _persistWorldInfos();
  }

  Future<void> reorderWorldInfos(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = worldInfos.removeAt(oldIndex);
    worldInfos.insert(newIndex, item);
    await _persistWorldInfos();
  }

  String generateEndpointId() => const Uuid().v4();

  String generateCharacterId() => const Uuid().v4();

  String randomAvatarColorHex() {
    final rand = Random();
    final colors = [
      const Color(0xFF07C160),
      const Color(0xFF5856D6),
      const Color(0xFFFF9500),
      const Color(0xFF34C759),
      const Color(0xFFFF3B30),
      const Color(0xFF5AC8FA),
    ];
    final color = colors[rand.nextInt(colors.length)];
    final argb = color.toARGB32();
    return '#${argb.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  List<ApiEndpoint> _buildDefaultEndpoints() {
    return [
      ApiEndpoint(
        id: generateEndpointId(),
        name: 'OpenAI 兼容',
        type: ApiProviderType.openai,
        baseUrl: 'https://api.openai.com/v1',
        apiKey: '',
        model: 'gpt-4o-mini',
        notes: '示例配置，填写自己的 API Key 后即可使用。',
        enabledFunctions: const ['chat', 'vision'],
        generationConfig: const GenerationConfig(),
      ),
      ApiEndpoint(
        id: generateEndpointId(),
        name: 'Gemini 官方',
        type: ApiProviderType.gemini,
        baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
        apiKey: '',
        model: 'gemini-1.5-flash',
        notes: '需要 Google API Key。',
        enabledFunctions: const ['chat', 'image'],
        generationConfig: const GenerationConfig(temperature: 0.8, topP: 0.95, maxTokens: 2048),
      ),
    ];
  }

  List<AiCharacter> _buildDefaultCharacters() {
    final endpointId = endpoints.isNotEmpty ? endpoints.first.id : generateEndpointId();
    return [
      AiCharacter(
        id: generateCharacterId(),
        name: '阿狸导师',
        persona: '温柔且富有洞察力的对话导师，擅长总结与引导。',
        greeting: '嗨，我是阿狸。准备好开启下一段对话了吗？',
        endpointId: endpointId,
        avatarColorHex: randomAvatarColorHex(),
        sampleReplies: const [
          '这听起来很棒，我们可以再深入一点。',
          '让我先总结一下目前的重点。',
          '如果换一个角度思考，你会怎么做？',
        ],
      ),
    ];
  }

  UserPersona _buildDefaultPersona() => const UserPersona(
        id: 'persona-default',
        displayName: '我',
        description: '喜欢探索新点子、保持好奇心的产品经理。',
        goals: '与 AI 合作快速原型设计、整理灵感、维持温暖的对话氛围。',
        style: '语气亲切，偶尔自嘲，关注他人情绪。',
      );
}

class GenerationConfig {
  const GenerationConfig({
    this.temperature = 0.7,
    this.topP = 1.0,
    this.topK = 40,
    this.maxTokens = 1024,
    this.presencePenalty = 0.0,
    this.frequencyPenalty = 0.0,
    this.stream = false,
  });

  final double temperature;
  final double topP;
  final int topK;
  final int maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;
  final bool stream;

  GenerationConfig copyWith({
    double? temperature,
    double? topP,
    int? topK,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    bool? stream,
  }) =>
      GenerationConfig(
        temperature: temperature ?? this.temperature,
        topP: topP ?? this.topP,
        topK: topK ?? this.topK,
        maxTokens: maxTokens ?? this.maxTokens,
        presencePenalty: presencePenalty ?? this.presencePenalty,
        frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
        stream: stream ?? this.stream,
      );

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'topP': topP,
        'topK': topK,
        'maxTokens': maxTokens,
        'presencePenalty': presencePenalty,
        'frequencyPenalty': frequencyPenalty,
        'stream': stream,
      };

  factory GenerationConfig.fromJson(Map<String, dynamic> json) => GenerationConfig(
        temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
        topP: (json['topP'] as num?)?.toDouble() ?? 1.0,
        topK: (json['topK'] as num?)?.toInt() ?? 40,
        maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 1024,
        presencePenalty: (json['presencePenalty'] as num?)?.toDouble() ?? 0.0,
        frequencyPenalty: (json['frequencyPenalty'] as num?)?.toDouble() ?? 0.0,
        stream: json['stream'] as bool? ?? false,
      );
}

class UserPersona {
  const UserPersona({
    required this.id,
    required this.displayName,
    required this.description,
    required this.goals,
    this.style = '',
  });

  final String id;
  final String displayName;
  final String description;
  final String goals;
  final String style;

  UserPersona copyWith({
    String? id,
    String? displayName,
    String? description,
    String? goals,
    String? style,
  }) =>
      UserPersona(
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        description: description ?? this.description,
        goals: goals ?? this.goals,
        style: style ?? this.style,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'description': description,
        'goals': goals,
        'style': style,
      };

  factory UserPersona.fromJson(Map<String, dynamic> json) => UserPersona(
        id: json['id'] as String,
        displayName: json['displayName'] as String? ?? '我',
        description: json['description'] as String? ?? '',
        goals: json['goals'] as String? ?? '',
        style: json['style'] as String? ?? '',
      );
}

class WorldInfoEntry {
  const WorldInfoEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.keywords,
    this.priority = 0,
    this.enabled = true,
  });

  final String id;
  final String title;
  final String content;
  final List<String> keywords;
  final int priority;
  final bool enabled;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'keywords': keywords,
        'priority': priority,
        'enabled': enabled,
      };

  factory WorldInfoEntry.fromJson(Map<String, dynamic> json) => WorldInfoEntry(
        id: json['id'] as String,
        title: json['title'] as String? ?? '',
        content: json['content'] as String? ?? '',
        keywords: (json['keywords'] as List?)?.map((e) => e.toString()).toList() ?? const [],
        priority: (json['priority'] as num?)?.toInt() ?? 0,
        enabled: json['enabled'] as bool? ?? true,
      );

  WorldInfoEntry copyWith({
    String? id,
    String? title,
    String? content,
    List<String>? keywords,
    int? priority,
    bool? enabled,
  }) =>
      WorldInfoEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        keywords: keywords ?? this.keywords,
        priority: priority ?? this.priority,
        enabled: enabled ?? this.enabled,
      );
}
