import 'dart:async';

import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../data/repositories/api_settings_repository.dart';
import '../data/repositories/chat_repository.dart';
import '../domain/entities/api_entities.dart';
import '../domain/entities/chat_entities.dart' as chat;
import 'api_settings_service.dart';
import 'llm_client.dart';

class ChatService extends GetxService {
  ChatService({
    required ChatRepository chatRepository,
    required ApiSettingsService apiSettingsService,
    ApiSettingsRepository? apiRepository,
    LlmClient? llmClient,
  })  : _chatRepository = chatRepository,
        _apiSettingsService = apiSettingsService,
        _apiRepository = apiRepository,
        _llmClient = llmClient ?? LlmClient();

  final ChatRepository _chatRepository;
  final ApiSettingsService _apiSettingsService;
  ApiSettingsRepository? _apiRepository;
  final LlmClient _llmClient;

  ApiSettingsRepository get _repository =>
      _apiRepository ??= ApiSettingsRepository(database: Get.find());

  Future<chat.ConversationSummary> ensureConversationForCharacter(
      AiCharacter character) async {
    final summaries = await _chatRepository.loadConversations();
    final existing = summaries
        .firstWhereOrNull((element) => element.contactId == character.id);
    if (existing != null) {
      return existing;
    }
    return _chatRepository.createConversationForCharacter(character: character);
  }

  Future<void> sendMessage({
    required chat.ConversationSummary conversation,
    required AiCharacter character,
    required String content,
  }) async {
    if (content.trim().isEmpty) return;
    final userMessage = await _chatRepository.insertMessage(
      conversationId: conversation.id,
      sender: chat.SenderType.user,
      role: 'user',
      content: content,
      status: chat.MessageStatus.sent,
    );

    final placeholder = await _chatRepository.insertMessage(
      conversationId: conversation.id,
      sender: chat.SenderType.assistant,
      role: 'assistant',
      content: '…',
      status: chat.MessageStatus.pending,
      metadata: {'state': 'generating'},
    );

    try {
      final endpoint = _apiSettingsService.endpoints.firstWhereOrNull((e) =>
              e.id ==
              (conversation.providerProfileId ?? character.endpointId)) ??
          _apiSettingsService.selectedEndpoint;
      if (endpoint == null) {
        throw Exception('未找到可用的接口配置');
      }
      final apiKey = await _repository.readEndpointKey(endpoint.id);
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('请在 API 设置中填写接口密钥');
      }

      final messages = await _composeMessages(
          conversationId: conversation.id,
          character: character,
          latestUserMessage: userMessage);
      final reply = await _llmClient.createChatCompletion(
        endpoint: endpoint,
        apiKey: apiKey,
        messages: messages,
      );

      await _chatRepository.updateMessageStatus(
        messageId: placeholder.id,
        status: chat.MessageStatus.sent,
        content: reply.trim().isEmpty ? '（AI 未返回内容）' : reply.trim(),
        metadata: {'state': 'completed'},
      );

      await _maybeSummarize(conversation);
    } catch (e) {
      await _chatRepository.updateMessageStatus(
        messageId: placeholder.id,
        status: chat.MessageStatus.failed,
        content: '生成失败：$e',
        metadata: {'state': 'failed'},
      );
      rethrow;
    }
  }

  Future<void> regenerateLastAssistant({
    required chat.ConversationSummary conversation,
    required AiCharacter character,
  }) async {
    final messages = await _chatRepository.loadMessages(conversation.id);
    if (messages.isEmpty) return;
    final lastUser =
        messages.lastWhereOrNull((m) => m.senderType == chat.SenderType.user);
    final lastAssistant = messages
        .lastWhereOrNull((m) => m.senderType == chat.SenderType.assistant);
    if (lastUser == null || lastAssistant == null) return;

    await _chatRepository.updateMessageStatus(
      messageId: lastAssistant.id,
      status: chat.MessageStatus.pending,
      metadata: {'state': 'regenerating'},
    );

    try {
      final endpoint = _apiSettingsService.endpoints.firstWhereOrNull((e) =>
              e.id ==
              (conversation.providerProfileId ?? character.endpointId)) ??
          _apiSettingsService.selectedEndpoint;
      if (endpoint == null) {
        throw Exception('未找到可用的接口配置');
      }
      final apiKey = await _repository.readEndpointKey(endpoint.id);
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('请在 API 设置中填写接口密钥');
      }

      final contextMessages = await _composeMessages(
        conversationId: conversation.id,
        character: character,
        latestUserMessage: lastUser,
        excludeAssistantMessageId: lastAssistant.id,
      );
      final reply = await _llmClient.createChatCompletion(
        endpoint: endpoint,
        apiKey: apiKey,
        messages: contextMessages,
      );

      await _chatRepository.updateMessageStatus(
        messageId: lastAssistant.id,
        status: chat.MessageStatus.sent,
        content: reply.trim().isEmpty ? '（AI 未返回内容）' : reply.trim(),
        metadata: {'state': 'completed', 'regenerated': true},
      );

      await _chatRepository.insertGeneration(
        messageId: lastAssistant.id,
        variantIndex: (lastAssistant.generations.length) + 1,
        content: reply,
        params: {'regenerated': true},
      );

      await _maybeSummarize(conversation);
    } catch (e) {
      await _chatRepository.updateMessageStatus(
        messageId: lastAssistant.id,
        status: chat.MessageStatus.failed,
        metadata: {'state': 'failed', 'error': e.toString()},
      );
      rethrow;
    }
  }

  Future<List<Map<String, String>>> _composeMessages({
    required String conversationId,
    required AiCharacter character,
    required chat.MessageModel latestUserMessage,
    int maxHistory = 16,
    int? excludeAssistantMessageId,
  }) async {
    final messages = await _chatRepository.loadMessages(conversationId);
    final persona = _apiSettingsService.persona.value;
    final worldInfos = _apiSettingsService.worldInfos
        .where((element) => element.enabled)
        .toList();

    final systemBuffer = StringBuffer();
    systemBuffer.writeln('你是 ${character.name}。');
    if (character.persona.isNotEmpty) {
      systemBuffer.writeln('角色设定：${character.persona}');
    }
    if (persona != null) {
      systemBuffer.writeln('用户画像：${persona.description}');
      if (persona.goals.isNotEmpty) {
        systemBuffer.writeln('用户目标：${persona.goals}');
      }
      if (persona.style.isNotEmpty) {
        systemBuffer.writeln('请以 ${persona.style} 的语气回应用户。');
      }
    }
    if (character.description.isNotEmpty) {
      systemBuffer.writeln('补充说明：${character.description}');
    }
    if (worldInfos.isNotEmpty) {
      systemBuffer.writeln('世界信息：');
      for (final info in worldInfos) {
        systemBuffer.writeln('- ${info.title}：${info.content}');
      }
    }

    final limited = messages
        .where((m) =>
            excludeAssistantMessageId == null ||
            m.id != excludeAssistantMessageId)
        .where((m) => m.senderType != chat.SenderType.system)
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    final recent = limited.length > maxHistory
        ? limited.sublist(limited.length - maxHistory)
        : limited;
    final result = <Map<String, String>>[
      {'role': 'system', 'content': systemBuffer.toString()},
    ];

    for (final msg in recent) {
      result.add({'role': msg.role, 'content': msg.content});
    }

    if (!recent.contains(latestUserMessage)) {
      result.add({
        'role': latestUserMessage.role,
        'content': latestUserMessage.content
      });
    }

    return result;
  }

  Future<void> _maybeSummarize(chat.ConversationSummary conversation) async {
    final policy = conversation.memoryPolicy;
    if (!policy.autoSummary) return;
    final messages = await _chatRepository.loadMessages(conversation.id);
    if (messages.length < 12) return;

    final summaries = await _chatRepository.loadMemoryEntries(conversation.id);
    final recentSummary = summaries
        .firstWhereOrNull((e) => e.type == chat.MemoryEntryType.summary);
    if (recentSummary != null &&
        recentSummary.createdAt.isAfter(DateTime.now()
            .subtract(Duration(seconds: policy.minIntervalSeconds)))) {
      return;
    }

    final buffer = StringBuffer('最近对话概览：\n');
    final slice = messages.length > 10
        ? messages.sublist(messages.length - 10)
        : messages;
    for (final msg in slice) {
      final speaker = msg.senderType == chat.SenderType.user ? '用户' : 'AI';
      buffer.writeln('$speaker: ${msg.content}');
    }
    final summaryText = buffer.toString();

    await _chatRepository.insertMemoryEntry(
      type: chat.MemoryEntryType.summary,
      content: summaryText.length > policy.summaryTarget
          ? summaryText.substring(0, policy.summaryTarget)
          : summaryText,
      conversationId: conversation.id,
      metadata: {'auto': true, 'created_at': DateTime.now().toIso8601String()},
    );
  }
}
