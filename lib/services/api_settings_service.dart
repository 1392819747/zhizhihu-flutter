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
    default:
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
  });

  final String id;
  final String name;
  final ApiProviderType type;
  final String baseUrl;
  final String apiKey;
  final String model;
  final String notes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': apiProviderTypeToString(type),
        'baseUrl': baseUrl,
        'apiKey': apiKey,
        'model': model,
        'notes': notes,
      };

  factory ApiEndpoint.fromJson(Map<String, dynamic> json) => ApiEndpoint(
        id: json['id'] as String,
        name: json['name'] as String,
        type: apiProviderTypeFromString(json['type'] as String? ?? 'openai'),
        baseUrl: json['baseUrl'] as String? ?? '',
        apiKey: json['apiKey'] as String? ?? '',
        model: json['model'] as String? ?? '',
        notes: json['notes'] as String? ?? '',
      );

  ApiEndpoint copyWith({
    String? id,
    String? name,
    ApiProviderType? type,
    String? baseUrl,
    String? apiKey,
    String? model,
    String? notes,
  }) =>
      ApiEndpoint(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        baseUrl: baseUrl ?? this.baseUrl,
        apiKey: apiKey ?? this.apiKey,
        model: model ?? this.model,
        notes: notes ?? this.notes,
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

  final endpoints = <ApiEndpoint>[].obs;
  final characters = <AiCharacter>[].obs;
  final selectedEndpointId = ''.obs;
  final selectedCharacterId = ''.obs;

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
  }

  Future<void> _persistCharacters() async {
    final jsonStr = jsonEncode(characters.map((e) => e.toJson()).toList());
    await SpUtil().putString(_charactersKey, jsonStr);
  }

  ApiEndpoint? get selectedEndpoint => getEndpointById(selectedEndpointId.value);

  AiCharacter? get selectedCharacter =>
      characters.firstWhereOrNull((element) => element.id == selectedCharacterId.value);

  ApiEndpoint ensureEndpointForCharacter(AiCharacter character) {
    final endpoint = getEndpointById(character.endpointId);
    return endpoint ?? selectedEndpoint ?? endpoints.first;
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
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
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
      ),
      ApiEndpoint(
        id: generateEndpointId(),
        name: 'Gemini 官方',
        type: ApiProviderType.gemini,
        baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
        apiKey: '',
        model: 'gemini-1.5-flash',
        notes: '需要 Google API Key。',
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
}
