import 'dart:convert';

import 'package:collection/collection.dart';

import 'api_entities.dart';

enum SenderType { user, assistant, system }

SenderType senderTypeFromStorage(String value) {
  switch (value) {
    case 'user':
      return SenderType.user;
    case 'system':
      return SenderType.system;
    case 'assistant':
    default:
      return SenderType.assistant;
  }
}

String senderTypeToStorage(SenderType type) {
  switch (type) {
    case SenderType.user:
      return 'user';
    case SenderType.system:
      return 'system';
    case SenderType.assistant:
      return 'assistant';
  }
}

enum MessageStatus { pending, streaming, sent, failed }

MessageStatus messageStatusFromStorage(String value) {
  switch (value) {
    case 'pending':
      return MessageStatus.pending;
    case 'streaming':
      return MessageStatus.streaming;
    case 'failed':
      return MessageStatus.failed;
    case 'sent':
    default:
      return MessageStatus.sent;
  }
}

String messageStatusToStorage(MessageStatus status) {
  switch (status) {
    case MessageStatus.pending:
      return 'pending';
    case MessageStatus.streaming:
      return 'streaming';
    case MessageStatus.failed:
      return 'failed';
    case MessageStatus.sent:
      return 'sent';
  }
}

class ConversationSummary {
  const ConversationSummary({
    required this.id,
    required this.title,
    required this.contactId,
    required this.providerProfileId,
    required this.modelPresetId,
    required this.lastMessage,
    required this.lastTime,
    required this.unreadCount,
    required this.isPinned,
    required this.isMuted,
    required this.memoryPolicy,
  });

  final String id;
  final String title;
  final String? contactId;
  final String? providerProfileId;
  final String? modelPresetId;
  final String lastMessage;
  final DateTime? lastTime;
  final int unreadCount;
  final bool isPinned;
  final bool isMuted;
  final MemoryPolicy memoryPolicy;
}

class MessageModel {
  const MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderType,
    required this.role,
    required this.content,
    required this.format,
    required this.status,
    required this.createdAt,
    this.identifier,
    this.parentIdentifier,
    this.variantGroup,
    this.metadata,
    this.tokenCount,
    this.generations = const [],
  });

  final int id;
  final String conversationId;
  final SenderType senderType;
  final String role;
  final String content;
  final String format;
  final MessageStatus status;
  final DateTime createdAt;
  final String? identifier;
  final String? parentIdentifier;
  final int? variantGroup;
  final Map<String, dynamic>? metadata;
  final int? tokenCount;
  final List<GenerationCandidate> generations;

  MessageModel copyWith({
    SenderType? senderType,
    String? role,
    String? content,
    String? format,
    MessageStatus? status,
    DateTime? createdAt,
    String? identifier,
    String? parentIdentifier,
    int? variantGroup,
    Map<String, dynamic>? metadata,
    int? tokenCount,
    List<GenerationCandidate>? generations,
  }) =>
      MessageModel(
        id: id,
        conversationId: conversationId,
        senderType: senderType ?? this.senderType,
        role: role ?? this.role,
        content: content ?? this.content,
        format: format ?? this.format,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        identifier: identifier ?? this.identifier,
        parentIdentifier: parentIdentifier ?? this.parentIdentifier,
        variantGroup: variantGroup ?? this.variantGroup,
        metadata: metadata ?? this.metadata,
        tokenCount: tokenCount ?? this.tokenCount,
        generations: generations ?? this.generations,
      );
}

class GenerationCandidate {
  const GenerationCandidate({
    required this.id,
    required this.messageId,
    required this.variantIndex,
    required this.content,
    required this.paramsSnapshot,
    required this.createdAt,
    this.parentIdentifier,
    this.score,
  });

  final int id;
  final int messageId;
  final int variantIndex;
  final String content;
  final Map<String, dynamic> paramsSnapshot;
  final DateTime createdAt;
  final String? parentIdentifier;
  final double? score;
}

enum MemoryEntryType { persona, lore, summary, pin }

MemoryEntryType memoryEntryTypeFromStorage(String value) {
  return MemoryEntryType.values.firstWhere(
    (e) => e.name == value,
    orElse: () => MemoryEntryType.persona,
  );
}

class MemoryEntry {
  const MemoryEntry({
    required this.id,
    required this.type,
    required this.content,
    required this.weight,
    required this.createdAt,
    this.scope = 'global',
    this.conversationId,
    this.triggers = const [],
    this.pinned = false,
    this.lastUsedAt,
    this.metadata = const {},
  });

  final int id;
  final MemoryEntryType type;
  final String content;
  final double weight;
  final DateTime createdAt;
  final String scope;
  final String? conversationId;
  final List<String> triggers;
  final bool pinned;
  final DateTime? lastUsedAt;
  final Map<String, dynamic> metadata;
}

class MomentsEntry {
  const MomentsEntry({
    required this.id,
    required this.content,
    required this.media,
    required this.visibility,
    required this.createdAt,
    this.authorId,
    this.allowComments = true,
    this.likeCount = 0,
    this.commentCount = 0,
  });

  final String id;
  final String? authorId;
  final String content;
  final List<Map<String, dynamic>> media;
  final String visibility;
  final bool allowComments;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
}

extension MessageModelX on MessageModel {
  Map<String, dynamic> metadataOrEmpty() => metadata ?? const {};
}

extension GenerationCandidateX on GenerationCandidate {
  static Map<String, dynamic> parseParams(String json) => json.isEmpty ? {} : jsonDecode(json) as Map<String, dynamic>;
}

extension MemoryEntryX on MemoryEntry {
  static Map<String, dynamic> parseMetadata(String json) => json.isEmpty ? {} : jsonDecode(json) as Map<String, dynamic>;
}
