import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/models/api_provider.dart';

class GenerationConfig {
  const GenerationConfig({
    this.temperature = 0.7,
    this.topP = 1.0,
    this.topK = 0,
    this.maxTokens = 1024,
    this.presencePenalty = 0.0,
    this.frequencyPenalty = 0.0,
    this.stream = true,
    this.stopSequences = const [],
  });

  final double temperature;
  final double topP;
  final int topK;
  final int maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;
  final bool stream;
  final List<String> stopSequences;

  GenerationConfig copyWith({
    double? temperature,
    double? topP,
    int? topK,
    int? maxTokens,
    double? presencePenalty,
    double? frequencyPenalty,
    bool? stream,
    List<String>? stopSequences,
  }) =>
      GenerationConfig(
        temperature: temperature ?? this.temperature,
        topP: topP ?? this.topP,
        topK: topK ?? this.topK,
        maxTokens: maxTokens ?? this.maxTokens,
        presencePenalty: presencePenalty ?? this.presencePenalty,
        frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
        stream: stream ?? this.stream,
        stopSequences: stopSequences ?? this.stopSequences,
      );

  Map<String, dynamic> toJson() => {
        'temperature': temperature,
        'topP': topP,
        'topK': topK,
        'maxTokens': maxTokens,
        'presencePenalty': presencePenalty,
        'frequencyPenalty': frequencyPenalty,
        'stream': stream,
        'stopSequences': stopSequences,
      };

  String toStorage() => jsonEncode(toJson());

  factory GenerationConfig.fromJson(Map<String, dynamic> json) => GenerationConfig(
        temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
        topP: (json['topP'] as num?)?.toDouble() ?? 1.0,
        topK: (json['topK'] as num?)?.toInt() ?? 0,
        maxTokens: (json['maxTokens'] as num?)?.toInt() ?? 1024,
        presencePenalty: (json['presencePenalty'] as num?)?.toDouble() ?? 0.0,
        frequencyPenalty: (json['frequencyPenalty'] as num?)?.toDouble() ?? 0.0,
        stream: json['stream'] as bool? ?? true,
        stopSequences: (json['stopSequences'] as List?)?.map((e) => e.toString()).toList() ?? const [],
      );

  factory GenerationConfig.fromStorage(String storage) {
    if (storage.isEmpty) return const GenerationConfig();
    return GenerationConfig.fromJson(jsonDecode(storage) as Map<String, dynamic>);
  }
}

class ApiEndpoint {
  const ApiEndpoint({
    required this.id,
    required this.name,
    required this.type,
    required this.baseUrl,
    required this.model,
    required this.keyLabel,
    this.notes = '',
    this.enabledFunctions = const [],
    this.generationConfig = const GenerationConfig(),
    this.isEnabled = true,
    this.priority = 0,
  });

  final String id;
  final String name;
  final ApiProviderType type;
  final String baseUrl;
  final String model;
  final String keyLabel;
  final String notes;
  final List<String> enabledFunctions;
  final GenerationConfig generationConfig;
  final bool isEnabled;
  final int priority;

  ApiEndpoint copyWith({
    String? id,
    String? name,
    ApiProviderType? type,
    String? baseUrl,
    String? model,
    String? keyLabel,
    String? notes,
    List<String>? enabledFunctions,
    GenerationConfig? generationConfig,
    bool? isEnabled,
    int? priority,
  }) =>
      ApiEndpoint(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        baseUrl: baseUrl ?? this.baseUrl,
        model: model ?? this.model,
        keyLabel: keyLabel ?? this.keyLabel,
        notes: notes ?? this.notes,
        enabledFunctions: enabledFunctions ?? this.enabledFunctions,
        generationConfig: generationConfig ?? this.generationConfig,
        isEnabled: isEnabled ?? this.isEnabled,
        priority: priority ?? this.priority,
      );
}

class MemoryPolicy {
  const MemoryPolicy({
    this.autoSummary = true,
    this.tokenWindow = 2000,
    this.summaryTarget = 500,
    this.minIntervalSeconds = 180,
    this.maxSummaries = 3,
  });

  final bool autoSummary;
  final int tokenWindow;
  final int summaryTarget;
  final int minIntervalSeconds;
  final int maxSummaries;

  MemoryPolicy copyWith({
    bool? autoSummary,
    int? tokenWindow,
    int? summaryTarget,
    int? minIntervalSeconds,
    int? maxSummaries,
  }) =>
      MemoryPolicy(
        autoSummary: autoSummary ?? this.autoSummary,
        tokenWindow: tokenWindow ?? this.tokenWindow,
        summaryTarget: summaryTarget ?? this.summaryTarget,
        minIntervalSeconds: minIntervalSeconds ?? this.minIntervalSeconds,
        maxSummaries: maxSummaries ?? this.maxSummaries,
      );

  Map<String, dynamic> toJson() => {
        'autoSummary': autoSummary,
        'tokenWindow': tokenWindow,
        'summaryTarget': summaryTarget,
        'minIntervalSeconds': minIntervalSeconds,
        'maxSummaries': maxSummaries,
      };

  String toStorage() => jsonEncode(toJson());

  factory MemoryPolicy.fromJson(Map<String, dynamic> json) => MemoryPolicy(
        autoSummary: json['autoSummary'] as bool? ?? true,
        tokenWindow: (json['tokenWindow'] as num?)?.toInt() ?? 2000,
        summaryTarget: (json['summaryTarget'] as num?)?.toInt() ?? 500,
        minIntervalSeconds: (json['minIntervalSeconds'] as num?)?.toInt() ?? 180,
        maxSummaries: (json['maxSummaries'] as num?)?.toInt() ?? 3,
      );

  factory MemoryPolicy.fromStorage(String storage) {
    if (storage.isEmpty) return const MemoryPolicy();
    return MemoryPolicy.fromJson(jsonDecode(storage) as Map<String, dynamic>);
  }
}

class AiCharacter {
  const AiCharacter({
    required this.id,
    required this.name,
    required this.persona,
    required this.greeting,
    required this.endpointId,
    required this.avatarColorHex,
    this.description = '',
    this.presetId,
    this.sampleReplies = const [],
    this.tags = const [],
    this.memoryPolicy = const MemoryPolicy(),
  });

  final String id;
  final String name;
  final String persona;
  final String greeting;
  final String endpointId;
  final String avatarColorHex;
  final String description;
  final String? presetId;
  final List<String> sampleReplies;
  final List<String> tags;
  final MemoryPolicy memoryPolicy;

  Color get avatarColor =>
      Color(int.parse(avatarColorHex.substring(1), radix: 16) + 0xFF000000);

  AiCharacter copyWith({
    String? id,
    String? name,
    String? persona,
    String? greeting,
    String? endpointId,
    String? avatarColorHex,
    String? description,
    String? presetId,
    List<String>? sampleReplies,
    List<String>? tags,
    MemoryPolicy? memoryPolicy,
  }) =>
      AiCharacter(
        id: id ?? this.id,
        name: name ?? this.name,
        persona: persona ?? this.persona,
        greeting: greeting ?? this.greeting,
        endpointId: endpointId ?? this.endpointId,
        avatarColorHex: avatarColorHex ?? this.avatarColorHex,
        description: description ?? this.description,
        presetId: presetId ?? this.presetId,
        sampleReplies: sampleReplies ?? this.sampleReplies,
        tags: tags ?? this.tags,
        memoryPolicy: memoryPolicy ?? this.memoryPolicy,
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'keywords': keywords,
        'priority': priority,
        'enabled': enabled,
      };
}
