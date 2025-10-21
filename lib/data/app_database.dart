import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class ProviderProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text().withDefault(const Constant('openai'))();
  TextColumn get baseUrl => text().withDefault(const Constant(''))();
  TextColumn get defaultModel => text().nullable()();
  TextColumn get generationConfigJson => text().withDefault(const Constant(
      '{"temperature":0.7,"topP":1.0,"topK":0,"maxTokens":1024,"presencePenalty":0.0,"frequencyPenalty":0.0,"stream":true}'))();
  TextColumn get notes => text().withDefault(const Constant(''))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get featuresJson => text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ProviderKeys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get profileId => text().references(ProviderProfiles, #id)();
  TextColumn get label => text()();
  TextColumn get secureKeyRef => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class ModelPresets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get temperature => real().withDefault(const Constant(0.7))();
  RealColumn get topP => real().withDefault(const Constant(1.0))();
  IntColumn get topK => integer().withDefault(const Constant(0))();
  IntColumn get maxTokens => integer().nullable()();
  RealColumn get presencePenalty => real().withDefault(const Constant(0.0))();
  RealColumn get frequencyPenalty => real().withDefault(const Constant(0.0))();
  BoolColumn get stream => boolean().withDefault(const Constant(true))();
  TextColumn get stopSequencesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get metadata => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Contacts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get persona => text().withDefault(const Constant(''))();
  TextColumn get greeting => text().withDefault(const Constant(''))();
  TextColumn get description => text().withDefault(const Constant(''))();
  TextColumn get avatarColor => text().withDefault(const Constant('#07C160'))();
  TextColumn get endpointId =>
      text().nullable().references(ProviderProfiles, #id)();
  TextColumn get presetId => text().nullable().references(ModelPresets, #id)();
  TextColumn get memoryConfigJson => text().withDefault(const Constant(
      '{"autoSummary":true,"tokenWindow":2000,"summaryTarget":600,"minIntervalSeconds":180}'))();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();
  TextColumn get sampleRepliesJson =>
      text().withDefault(const Constant('[]'))();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Conversations extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withDefault(const Constant(''))();
  TextColumn get contactId => text().nullable().references(Contacts, #id)();
  TextColumn get providerProfileId =>
      text().nullable().references(ProviderProfiles, #id)();
  TextColumn get modelPresetId =>
      text().nullable().references(ModelPresets, #id)();
  TextColumn get lastMessageSnippet => text().withDefault(const Constant(''))();
  DateTimeColumn get lastMessageTime => dateTime().nullable()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  BoolColumn get isMuted => boolean().withDefault(const Constant(false))();
  TextColumn get draftText => text().withDefault(const Constant(''))();
  TextColumn get metadata => text().withDefault(const Constant('{}'))();
  TextColumn get memoryPolicyJson => text().withDefault(const Constant(
      '{"autoSummary":true,"tokenWindow":2000,"summaryTarget":500,"minIntervalSeconds":180,"maxSummaries":3}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Participants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get conversationId => text().references(Conversations, #id)();
  TextColumn get contactId => text().references(Contacts, #id)();
  TextColumn get role => text().withDefault(const Constant('member'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get messageIdentifier => text().nullable()();
  TextColumn get conversationId => text().references(Conversations, #id)();
  TextColumn get senderType => text()(); // user / assistant / system
  TextColumn get role => text().withDefault(const Constant('assistant'))();
  TextColumn get content => text()();
  TextColumn get contentSearchTerms => text().nullable()();
  TextColumn get format => text().withDefault(const Constant('text'))();
  TextColumn get status => text().withDefault(const Constant('sent'))();
  IntColumn get tokenCount => integer().nullable()();
  TextColumn get parentIdentifier => text().nullable()();
  IntColumn get variantGroup => integer().nullable()();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
  TextColumn get metadata => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Generations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId => integer().references(Messages, #id)();
  TextColumn get parentIdentifier => text().nullable()();
  IntColumn get variantIndex => integer().withDefault(const Constant(0))();
  TextColumn get content => text()();
  TextColumn get paramsSnapshot => text().withDefault(const Constant('{}'))();
  RealColumn get score => real().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class MemoryEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get scope =>
      text().withDefault(const Constant('global'))(); // global / conversation
  TextColumn get conversationId =>
      text().nullable().references(Conversations, #id)();
  TextColumn get type => text()(); // persona / lore / summary / pin
  TextColumn get content => text()();
  TextColumn get triggers => text().withDefault(const Constant('[]'))();
  RealColumn get weight => real().withDefault(const Constant(1.0))();
  BoolColumn get pinned => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastUsedAt => dateTime().nullable()();
  TextColumn get metadata => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class Attachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get messageId => integer().references(Messages, #id)();
  TextColumn get type => text()(); // image / audio / video / file / card
  TextColumn get path => text()();
  TextColumn get thumbnailPath => text().nullable()();
  TextColumn get mimeType => text().nullable()();
  IntColumn get size => integer().nullable()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  TextColumn get sha256 => text().nullable()();
  TextColumn get extra => text().withDefault(const Constant('{}'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Moments extends Table {
  TextColumn get id => text()();
  TextColumn get authorId => text().nullable().references(Contacts, #id)();
  TextColumn get content => text()();
  TextColumn get mediaJson => text().withDefault(const Constant('[]'))();
  TextColumn get visibility => text().withDefault(const Constant('private'))();
  BoolColumn get allowComments => boolean().withDefault(const Constant(true))();
  IntColumn get likeCount => integer().withDefault(const Constant(0))();
  IntColumn get commentCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class MomentReactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get momentId => text().references(Moments, #id)();
  TextColumn get contactId => text().nullable().references(Contacts, #id)();
  TextColumn get type =>
      text().withDefault(const Constant('like'))(); // like / comment
  TextColumn get content => text().withDefault(const Constant(''))();
  IntColumn get replyToReactionId =>
      integer().nullable().references(MomentReactions, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class AppPreferences extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    ProviderProfiles,
    ProviderKeys,
    ModelPresets,
    Contacts,
    Conversations,
    Participants,
    Messages,
    Generations,
    MemoryEntries,
    Attachments,
    Moments,
    MomentReactions,
    AppPreferences,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._(QueryExecutor executor) : super(executor);

  static final AppDatabase instance = AppDatabase._(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _seedDefaults();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Placeholder for future migrations. Schema v1 -> vX upgrades go here.
        },
      );

  Future<void> _seedDefaults() async {
    final defaultProfileId = 'default-openai';
    final defaultPresetId = 'preset-balanced';
    await into(providerProfiles).insert(
      ProviderProfilesCompanion.insert(
        id: defaultProfileId,
        name: '默认 OpenAI 兼容接口',
        type: const Value('openai'),
        baseUrl: const Value(''),
        defaultModel: const Value('gpt-4o-mini'),
        generationConfigJson: const Value(
          '{"temperature":0.7,"topP":0.95,"topK":0,"maxTokens":1024,"presencePenalty":0.0,"frequencyPenalty":0.0,"stream":true}',
        ),
        notes: const Value('初始化示例，可在「API 设置」中替换为真实网关。'),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    await into(modelPresets).insert(
      ModelPresetsCompanion.insert(
        id: defaultPresetId,
        name: '均衡',
        temperature: const Value(0.7),
        topP: const Value(0.95),
        topK: const Value(0),
        maxTokens: const Value(1024),
        presencePenalty: const Value(0.0),
        frequencyPenalty: const Value(0.0),
        stream: const Value(true),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    await into(contacts).insert(
      ContactsCompanion.insert(
        id: 'default-assistant',
        name: '知知狐',
        persona: const Value('一名亲切耐心的智能伙伴，擅长中文对话与知识梳理。'),
        greeting: const Value('你好呀，我是知知狐 AI 助手，今天想聊些什么？'),
        description: const Value('默认的 AI 伙伴，可在通讯录中修改或导入 TavernCard。'),
        avatarColor: const Value('#07C160'),
        endpointId: Value(defaultProfileId),
        presetId: Value(defaultPresetId),
        memoryConfigJson: const Value(
          '{"autoSummary":true,"tokenWindow":2000,"summaryTarget":600,"minIntervalSeconds":180}',
        ),
      ),
      mode: InsertMode.insertOrIgnore,
    );

    await into(conversations).insert(
      ConversationsCompanion.insert(
        id: 'conversation-default-assistant',
        title: const Value('知知狐'),
        contactId: Value('default-assistant'),
        providerProfileId: Value(defaultProfileId),
        modelPresetId: Value(defaultPresetId),
        lastMessageSnippet: const Value('你好呀，我是知知狐 AI 助手，今天想聊些什么？'),
        lastMessageTime: Value(DateTime.now()),
        memoryPolicyJson: const Value(
          '{"autoSummary":true,"tokenWindow":2000,"summaryTarget":500,"minIntervalSeconds":180,"maxSummaries":3}',
        ),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final dbFolder = Directory(p.join(dir.path, 'data'));
    if (!dbFolder.existsSync()) {
      dbFolder.createSync(recursive: true);
    }
    final file = File(p.join(dbFolder.path, 'wechat_ai.db'));
    return NativeDatabase.createInBackground(file);
  });
}
