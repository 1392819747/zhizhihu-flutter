import 'dart:convert';

import 'package:drift/drift.dart' as drift;

import '../../domain/entities/api_entities.dart';
import '../app_database.dart';

class ContactRepository {
  ContactRepository(this._db);

  final AppDatabase _db;

  Stream<List<AiCharacter>> watchCharacters() {
    final query = _db.select(_db.contacts)
      ..orderBy([(tbl) => drift.OrderingTerm(expression: tbl.createdAt)]);
    return query.watch().map((rows) => rows.map(_mapRow).toList());
  }

  Future<List<AiCharacter>> loadCharacters() async {
    final rows = await (_db.select(_db.contacts)
          ..orderBy([(tbl) => drift.OrderingTerm(expression: tbl.createdAt)]))
        .get();
    return rows.map(_mapRow).toList();
  }

  Future<AiCharacter?> getCharacter(String id) async {
    final row = await (_db.select(_db.contacts)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row == null ? null : _mapRow(row);
  }

  Future<void> upsertCharacter(AiCharacter character) async {
    await _db.into(_db.contacts).insertOnConflictUpdate(
          ContactsCompanion(
            id: drift.Value(character.id),
            name: drift.Value(character.name),
            persona: drift.Value(character.persona),
            greeting: drift.Value(character.greeting),
            description: drift.Value(character.description),
            avatarColor: drift.Value(character.avatarColorHex),
            endpointId: drift.Value(character.endpointId),
            presetId: drift.Value(character.presetId),
            tagsJson: drift.Value(jsonEncode(character.tags)),
            sampleRepliesJson: drift.Value(jsonEncode(character.sampleReplies)),
            memoryConfigJson: drift.Value(character.memoryPolicy.toStorage()),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );
  }

  Future<void> deleteCharacter(String id) async {
    await (_db.delete(_db.contacts)..where((tbl) => tbl.id.equals(id))).go();
  }

  AiCharacter _mapRow(Contact row) {
    return AiCharacter(
      id: row.id,
      name: row.name,
      persona: row.persona,
      greeting: row.greeting,
      description: row.description,
      endpointId: row.endpointId ?? '',
      avatarColorHex: row.avatarColor,
      presetId: row.presetId,
      sampleReplies: List<String>.from(jsonDecode(row.sampleRepliesJson) as List),
      tags: List<String>.from(jsonDecode(row.tagsJson) as List),
      memoryPolicy: MemoryPolicy.fromStorage(row.memoryConfigJson),
    );
  }
}
