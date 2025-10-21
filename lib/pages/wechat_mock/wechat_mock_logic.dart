import 'dart:async';

import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/moment_repository.dart';
import '../../domain/entities/api_entities.dart';
import '../../domain/entities/chat_entities.dart' as chat;
import '../../services/api_settings_service.dart';
import '../../services/chat_service.dart';

class ConversationTile {
  ConversationTile({
    required this.summary,
    required this.character,
  });

  final chat.ConversationSummary summary;
  final AiCharacter? character;
}

class MomentTile {
  MomentTile({
    required this.entry,
    required AiCharacter? author,
  }) : author = author;

  final chat.MomentsEntry entry;
  final AiCharacter? author;
}

class WeChatMockLogic extends GetxController {
  WeChatMockLogic({
    required ApiSettingsService apiSettingsService,
    required ChatRepository chatRepository,
    required ChatService chatService,
    required MomentRepository momentRepository,
  })  : _apiSettingsService = apiSettingsService,
        _chatRepository = chatRepository,
        _chatService = chatService,
        _momentRepository = momentRepository;

  final ApiSettingsService _apiSettingsService;
  final ChatRepository _chatRepository;
  final ChatService _chatService;
  final MomentRepository _momentRepository;

  ApiSettingsService get apiSettings => _apiSettingsService;

  final currentTab = 0.obs;
  final conversations = <ConversationTile>[].obs;
  final contacts = <AiCharacter>[].obs;
  final moments = <MomentTile>[].obs;
  final persona = Rxn<UserPersona>();
  final worldInfos = <WorldInfoEntry>[].obs;

  StreamSubscription<List<chat.ConversationSummary>>? _conversationSub;
  StreamSubscription<List<AiCharacter>>? _contactSub;
  StreamSubscription<List<chat.MomentsEntry>>? _momentSub;

  @override
  void onInit() {
    super.onInit();
    persona.value = _apiSettingsService.persona.value;
    worldInfos.assignAll(_apiSettingsService.worldInfos);

    ever<UserPersona?>(
        _apiSettingsService.persona, (value) => persona.value = value);
    ever<List<WorldInfoEntry>>(
        _apiSettingsService.worldInfos, (value) => worldInfos.assignAll(value));

    contacts.assignAll(_apiSettingsService.characters);
    _contactSub = _apiSettingsService.characters.listen((list) {
      contacts.assignAll(list);
      _rebuildConversations(lastSnapshot: conversations);
      _rebuildMoments(lastSnapshot: moments);
    });

    _conversationSub = _chatRepository.watchConversations().listen((list) {
      _rebuildConversations(latest: list);
    });

    _momentSub = _momentRepository.watchMoments().listen((entries) {
      _rebuildMoments(latest: entries);
    });
  }

  void switchTab(int index) => currentTab.value = index;

  Future<ConversationTile> ensureConversation(AiCharacter character) async {
    final summary =
        await _chatService.ensureConversationForCharacter(character);
    return ConversationTile(summary: summary, character: character);
  }

  Future<void> createMoment(String content,
      {String visibility = 'private'}) async {
    await _momentRepository.addMoment(
      content: content,
      authorId: _apiSettingsService.selectedCharacterId.value,
      visibility: visibility,
    );
  }

  Future<void> deleteMoment(String id) async {
    await _momentRepository.deleteMoment(id);
  }

  Future<void> toggleConversationPin(String conversationId, bool value) {
    return _chatRepository.toggleConversationPin(conversationId, value);
  }

  Future<void> deleteConversation(String conversationId) {
    return _chatRepository.deleteConversation(conversationId);
  }

  void _rebuildConversations(
      {List<chat.ConversationSummary>? latest,
      List<ConversationTile>? lastSnapshot}) {
    final summaries = latest ?? conversations.map((e) => e.summary).toList();
    final charactersById = {for (final c in contacts) c.id: c};
    final tiles = summaries
        .map(
          (summary) => ConversationTile(
            summary: summary,
            character: summary.contactId != null
                ? charactersById[summary.contactId]
                : null,
          ),
        )
        .toList();
    conversations.assignAll(tiles);
  }

  void _rebuildMoments(
      {List<chat.MomentsEntry>? latest, List<MomentTile>? lastSnapshot}) {
    final entries = latest ?? moments.map((e) => e.entry).toList();
    final charactersById = {for (final c in contacts) c.id: c};
    final tiles = entries
        .map(
          (entry) => MomentTile(
            entry: entry,
            author:
                entry.authorId != null ? charactersById[entry.authorId] : null,
          ),
        )
        .toList();
    moments.assignAll(tiles);
  }

  @override
  void onClose() {
    _conversationSub?.cancel();
    _contactSub?.cancel();
    _momentSub?.cancel();
    super.onClose();
  }
}
