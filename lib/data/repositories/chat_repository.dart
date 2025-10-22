import 'dart:async';
import 'dart:convert';

import 'package:characters/characters.dart';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../../domain/entities/api_entities.dart';
import '../../domain/entities/chat_entities.dart' as chat;
import '../app_database.dart';

class ChatRepository {
  ChatRepository(this._db);

  final AppDatabase _db;

  final _uuid = const Uuid();

  Stream<List<chat.ConversationSummary>> watchConversations() {
    final query = (_db.select(_db.conversations)
          ..orderBy([
            (tbl) => drift.OrderingTerm(
                expression: tbl.isPinned, mode: drift.OrderingMode.desc),
            (tbl) => drift.OrderingTerm(
                expression: tbl.lastMessageTime, mode: drift.OrderingMode.desc),
          ]))
        .watch();
    return query.asyncMap((rows) => _mapSummaries(rows));
  }

  Future<List<chat.ConversationSummary>> loadConversations() async {
    final rows = await (_db.select(_db.conversations)
          ..orderBy([
            (tbl) => drift.OrderingTerm(
                expression: tbl.isPinned, mode: drift.OrderingMode.desc),
            (tbl) => drift.OrderingTerm(
                expression: tbl.lastMessageTime, mode: drift.OrderingMode.desc),
          ]))
        .get();
    return _mapSummaries(rows);
  }

  Future<chat.ConversationSummary> createConversationForCharacter({
    required AiCharacter character,
    String? initialTitle,
  }) async {
    final existing = await (_db.select(_db.conversations)
          ..where((tbl) => tbl.contactId.equals(character.id)))
        .getSingleOrNull();
    if (existing != null) {
      return (await _mapSummaries([existing])).first;
    }
    final conversationId = 'conv-${_uuid.v4()}';
    final title = initialTitle ?? character.name;
    await _db.into(_db.conversations).insert(
          ConversationsCompanion.insert(
            id: conversationId,
            title: drift.Value(title),
            contactId: drift.Value<String?>(character.id),
            providerProfileId: drift.Value<String?>(character.endpointId),
            modelPresetId: drift.Value<String?>(character.presetId),
            lastMessageSnippet: drift.Value(character.greeting),
            lastMessageTime: drift.Value(DateTime.now()),
            memoryPolicyJson: drift.Value(character.memoryPolicy.toStorage()),
          ),
        );
    return chat.ConversationSummary(
      id: conversationId,
      title: title,
      contactId: character.id,
      providerProfileId: character.endpointId,
      modelPresetId: character.presetId,
      lastMessage: character.greeting,
      lastTime: DateTime.now(),
      unreadCount: 0,
      isPinned: false,
      isMuted: false,
      memoryPolicy: character.memoryPolicy,
    );
  }

  Stream<List<chat.MessageModel>> watchMessages(String conversationId) {
    final query = (_db.select(_db.messages)
          ..where((tbl) => tbl.conversationId.equals(conversationId))
          ..orderBy([
            (tbl) => drift.OrderingTerm(
                expression: tbl.createdAt, mode: drift.OrderingMode.asc),
            (tbl) => drift.OrderingTerm(
                expression: tbl.id, mode: drift.OrderingMode.asc),
          ]))
        .watch();
    return query.asyncMap((rows) => _mapMessages(rows));
  }

  Future<List<chat.MessageModel>> loadMessages(String conversationId) async {
    final rows = await (_db.select(_db.messages)
          ..where((tbl) => tbl.conversationId.equals(conversationId))
          ..orderBy([
            (tbl) => drift.OrderingTerm(
                expression: tbl.createdAt, mode: drift.OrderingMode.asc),
            (tbl) => drift.OrderingTerm(
                expression: tbl.id, mode: drift.OrderingMode.asc),
          ]))
        .get();
    return _mapMessages(rows);
  }

  Future<chat.MessageModel> insertMessage({
    required String conversationId,
    required chat.SenderType sender,
    required String role,
    required String content,
    chat.MessageStatus status = chat.MessageStatus.sent,
    String format = 'text',
    String? identifier,
    String? parentIdentifier,
    int? variantGroup,
    Map<String, dynamic>? metadata,
    int? tokenCount,
  }) async {
    final messageId = await _db.into(_db.messages).insert(
          MessagesCompanion.insert(
            conversationId: conversationId,
            senderType: chat.senderTypeToStorage(sender),
            role: drift.Value(role),
            content: content,
            contentSearchTerms: drift.Value(_tokenizeContent(content)),
            format: drift.Value(format),
            status: drift.Value(chat.messageStatusToStorage(status)),
            parentIdentifier: drift.Value(parentIdentifier),
            messageIdentifier: drift.Value(identifier),
            variantGroup: drift.Value(variantGroup),
            metadata:
                drift.Value(metadata == null ? null : jsonEncode(metadata)),
            tokenCount: drift.Value(tokenCount),
          ),
        );
    final inserted = await (_db.select(_db.messages)
          ..where((tbl) => tbl.id.equals(messageId)))
        .getSingle();
    final mapped = (await _mapMessages([inserted])).first;
    await _updateConversationPreview(conversationId, mapped);
    return mapped;
  }

  Future<void> updateMessageStatus({
    required int messageId,
    chat.MessageStatus? status,
    String? content,
    Map<String, dynamic>? metadata,
    int? tokenCount,
  }) async {
    await (_db.update(_db.messages)..where((tbl) => tbl.id.equals(messageId)))
        .write(
      MessagesCompanion(
        status: status == null
            ? const drift.Value.absent()
            : drift.Value(chat.messageStatusToStorage(status)),
        content:
            content == null ? const drift.Value.absent() : drift.Value(content),
        contentSearchTerms: content == null
            ? const drift.Value.absent()
            : drift.Value(_tokenizeContent(content)),
        metadata: metadata == null
            ? const drift.Value.absent()
            : drift.Value(jsonEncode(metadata)),
        tokenCount: tokenCount == null
            ? const drift.Value.absent()
            : drift.Value(tokenCount),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
    if (content != null) {
      final row = await (_db.select(_db.messages)
            ..where((tbl) => tbl.id.equals(messageId)))
          .getSingleOrNull();
      if (row != null) {
        final mapped = (await _mapMessages([row])).first;
        await _updateConversationPreview(row.conversationId, mapped);
      }
    }
  }

  Future<void> insertGeneration({
    required int messageId,
    required int variantIndex,
    required String content,
    Map<String, dynamic> params = const {},
    double? score,
    String? parentIdentifier,
  }) async {
    await _db.into(_db.generations).insert(
          GenerationsCompanion.insert(
            messageId: messageId,
            variantIndex: drift.Value(variantIndex),
            content: content,
            paramsSnapshot: drift.Value(jsonEncode(params)),
            score: drift.Value(score),
            parentIdentifier: drift.Value(parentIdentifier),
          ),
        );
  }

  Future<void> replaceMessageWithGeneration({
    required int messageId,
    required chat.GenerationCandidate candidate,
  }) async {
    await updateMessageStatus(
      messageId: messageId,
      content: candidate.content,
      metadata: {
        'params': candidate.paramsSnapshot,
        'selected_variant': candidate.variantIndex,
      },
    );
  }

  Future<void> toggleConversationPin(String conversationId, bool value) async {
    await (_db.update(_db.conversations)
          ..where((tbl) => tbl.id.equals(conversationId)))
        .write(
      ConversationsCompanion(
        isPinned: drift.Value(value),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<void> markConversationRead(String conversationId) async {
    await (_db.update(_db.conversations)
          ..where((tbl) => tbl.id.equals(conversationId)))
        .write(
      ConversationsCompanion(
        unreadCount: const drift.Value(0),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<List<chat.MessageModel>> searchMessages({
    required String query,
    String? conversationId,
    int limit = 50,
  }) async {
    final tokens = _tokenizeQuery(query);
    if (tokens.isEmpty) return const [];

    final buffer = StringBuffer();
    final variables = <drift.Variable>[];
    buffer.write('SELECT messages.* FROM messages ');
    if (conversationId != null) {
      buffer.write('WHERE conversation_id = ? AND ');
      variables.add(drift.Variable(conversationId));
    } else {
      buffer.write('WHERE ');
    }
    final likeClauses = <String>[];
    for (final token in tokens) {
      likeClauses.add('content_search_terms LIKE ?');
      variables.add(drift.Variable('%$token%'));
    }
    buffer.write(likeClauses.join(' AND '));
    buffer.write(' ORDER BY created_at DESC LIMIT ?');
    variables.add(drift.Variable(limit));

    final rows = await _db.customSelect(
      buffer.toString(),
      variables: variables,
      readsFrom: {_db.messages},
    ).get();

    final mappedRows = rows
        .map(
          (r) => Message(
            id: r.read<int>('id'),
            messageIdentifier: r.readNullable<String>('message_identifier'),
            conversationId: r.read<String>('conversation_id'),
            senderType: r.read<String>('sender_type'),
            role: r.read<String>('role'),
            content: r.read<String>('content'),
            contentSearchTerms: r.readNullable<String>('content_search_terms'),
            format: r.read<String>('format'),
            status: r.read<String>('status'),
            parentIdentifier: r.readNullable<String>('parent_identifier'),
            variantGroup: r.readNullable<int>('variant_group'),
            isVisible: r.read<bool>('is_visible'),
            metadata: r.readNullable<String>('metadata'),
            tokenCount: r.readNullable<int>('token_count'),
            createdAt: r.read<DateTime>('created_at'),
            updatedAt: r.readNullable<DateTime>('updated_at'),
          ),
        )
        .toList();
    return _mapMessages(mappedRows);
  }

  Future<List<chat.MemoryEntry>> loadMemoryEntries(
      String? conversationId) async {
    final query = _db.select(_db.memoryEntries);
    if (conversationId != null) {
      query.where((tbl) =>
          tbl.conversationId.equals(conversationId) |
          tbl.scope.equals('global'));
    } else {
      query.where((tbl) => tbl.scope.equals('global'));
    }
    query.orderBy([
      (tbl) => drift.OrderingTerm(
          expression: tbl.createdAt, mode: drift.OrderingMode.desc)
    ]);
    final rows = await query.get();
    return rows.map(_mapMemory).toList();
  }

  Future<void> saveMemoryEntry(chat.MemoryEntry entry) async {
    await _db.into(_db.memoryEntries).insertOnConflictUpdate(
          MemoryEntriesCompanion(
            id: drift.Value(entry.id),
            scope: drift.Value(entry.scope),
            conversationId: drift.Value(entry.conversationId),
            type: drift.Value(entry.type.name),
            content: drift.Value(entry.content),
            triggers: drift.Value(jsonEncode(entry.triggers)),
            weight: drift.Value(entry.weight),
            pinned: drift.Value(entry.pinned),
            lastUsedAt: drift.Value(entry.lastUsedAt),
            metadata: drift.Value(jsonEncode(entry.metadata)),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );
  }

  Future<int> insertMemoryEntry({
    required chat.MemoryEntryType type,
    required String content,
    String scope = 'global',
    String? conversationId,
    List<String> triggers = const [],
    double weight = 1.0,
    bool pinned = false,
    Map<String, dynamic> metadata = const {},
  }) async {
    final id = await _db.into(_db.memoryEntries).insert(
          MemoryEntriesCompanion.insert(
            scope: drift.Value(scope),
            conversationId: drift.Value(conversationId),
            type: type.name,
            content: content,
            triggers: drift.Value(jsonEncode(triggers)),
            weight: drift.Value(weight),
            pinned: drift.Value(pinned),
            metadata: drift.Value(jsonEncode(metadata)),
          ),
        );
    return id;
  }

  Future<void> deleteMemoryEntry(int id) async {
    await (_db.delete(_db.memoryEntries)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<void> deleteConversation(String conversationId) async {
    await (_db.delete(_db.generations)
          ..where((tbl) => tbl.messageId.isInQuery(_db.selectOnly(_db.messages)
            ..addColumns([_db.messages.id])
            ..where(_db.messages.conversationId.equals(conversationId)))))
        .go();
    await (_db.delete(_db.attachments)
          ..where((tbl) => tbl.messageId.isInQuery(_db.selectOnly(_db.messages)
            ..addColumns([_db.messages.id])
            ..where(_db.messages.conversationId.equals(conversationId)))))
        .go();
    await (_db.delete(_db.messages)
          ..where((tbl) => tbl.conversationId.equals(conversationId)))
        .go();
    await (_db.delete(_db.conversations)
          ..where((tbl) => tbl.id.equals(conversationId)))
        .go();
  }

  Future<void> _updateConversationPreview(
      String conversationId, chat.MessageModel message) async {
    await (_db.update(_db.conversations)
          ..where((tbl) => tbl.id.equals(conversationId)))
        .write(
      ConversationsCompanion(
        lastMessageSnippet: drift.Value(message.content),
        lastMessageTime: drift.Value(message.createdAt),
        updatedAt: drift.Value(DateTime.now()),
      ),
    );
  }

  Future<List<chat.ConversationSummary>> _mapSummaries(
      List<Conversation> rows) async {
    return rows
        .map(
          (row) => chat.ConversationSummary(
            id: row.id,
            title: row.title,
            contactId: row.contactId,
            providerProfileId: row.providerProfileId,
            modelPresetId: row.modelPresetId,
            lastMessage: row.lastMessageSnippet,
            lastTime: row.lastMessageTime,
            unreadCount: row.unreadCount,
            isPinned: row.isPinned,
            isMuted: row.isMuted,
            memoryPolicy: MemoryPolicy.fromStorage(row.memoryPolicyJson),
          ),
        )
        .toList();
  }

  Future<List<chat.MessageModel>> _mapMessages(List<Message> rows) async {
    if (rows.isEmpty) return const [];
    final messageIds = rows.map((e) => e.id).toList();
    final generationsRows = await (_db.select(_db.generations)
          ..where((tbl) => tbl.messageId.isIn(messageIds))
          ..orderBy(
              [(tbl) => drift.OrderingTerm(expression: tbl.variantIndex)]))
        .get();
    final groupedGenerations = groupBy(
      generationsRows,
      (Generation row) => row.messageId,
    );
    return rows
        .map(
          (row) => chat.MessageModel(
            id: row.id,
            conversationId: row.conversationId,
            senderType: chat.senderTypeFromStorage(row.senderType),
            role: row.role,
            content: row.content,
            format: row.format,
            status: chat.messageStatusFromStorage(row.status),
            createdAt: row.createdAt,
            identifier: row.messageIdentifier,
            parentIdentifier: row.parentIdentifier,
            variantGroup: row.variantGroup,
            metadata: row.metadata == null || row.metadata!.isEmpty
                ? null
                : jsonDecode(row.metadata!) as Map<String, dynamic>,
            tokenCount: row.tokenCount,
            generations: (groupedGenerations[row.id] ?? const [])
                .map(
                  (g) => chat.GenerationCandidate(
                    id: g.id,
                    messageId: g.messageId,
                    variantIndex: g.variantIndex,
                    content: g.content,
                    paramsSnapshot: g.paramsSnapshot.isEmpty
                        ? const {}
                        : jsonDecode(g.paramsSnapshot) as Map<String, dynamic>,
                    createdAt: g.createdAt,
                    parentIdentifier: g.parentIdentifier,
                    score: g.score,
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  chat.MemoryEntry _mapMemory(MemoryEntry row) {
    return chat.MemoryEntry(
      id: row.id,
      scope: row.scope,
      conversationId: row.conversationId,
      type: chat.memoryEntryTypeFromStorage(row.type),
      content: row.content,
      triggers: List<String>.from(jsonDecode(row.triggers) as List),
      weight: row.weight,
      pinned: row.pinned,
      lastUsedAt: row.lastUsedAt,
      metadata: row.metadata.isEmpty
          ? const {}
          : jsonDecode(row.metadata) as Map<String, dynamic>,
      createdAt: row.createdAt,
    );
  }

  String _tokenizeContent(String text) {
    final buffer = <String>{};
    final charactersList = text.characters.toList();
    for (var i = 0; i < charactersList.length; i++) {
      final current = charactersList[i].trim();
      if (current.isEmpty) continue;
      buffer.add(current.toLowerCase());
      if (i + 1 < charactersList.length) {
        final next = charactersList[i + 1].trim();
        if (next.isNotEmpty) {
          buffer.add((current + next).toLowerCase());
        }
      }
    }
    final wordMatches = RegExp(r'[\w\-]+', unicode: true).allMatches(text);
    for (final match in wordMatches) {
      buffer.add(match.group(0)!.toLowerCase());
    }
    return buffer.join(' ');
  }

  List<String> _tokenizeQuery(String query) {
    final set = <String>{};
    final charactersList = query.characters.toList();
    for (final char in charactersList) {
      final trimmed = char.trim().toLowerCase();
      if (trimmed.isNotEmpty) {
        set.add(trimmed);
      }
    }
    final matches = RegExp(r'[\w\-]+', unicode: true).allMatches(query);
    for (final match in matches) {
      set.add(match.group(0)!.toLowerCase());
    }
    return set.toList();
  }
}
