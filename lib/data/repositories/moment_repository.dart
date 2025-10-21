import 'dart:convert';

import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';

import '../../domain/entities/chat_entities.dart' as chat;
import '../app_database.dart';

class MomentRepository {
  MomentRepository(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Stream<List<chat.MomentsEntry>> watchMoments() {
    return (_db.select(_db.moments)
          ..orderBy([
            (tbl) => drift.OrderingTerm(
                  expression: tbl.createdAt,
                  mode: drift.OrderingMode.desc,
                )
          ]))
        .watch()
        .map((rows) => rows.map(_mapRow).toList());
  }

  Future<List<chat.MomentsEntry>> loadMoments() async {
    final rows = await (_db.select(_db.moments)
          ..orderBy([
            (tbl) => drift.OrderingTerm(
                  expression: tbl.createdAt,
                  mode: drift.OrderingMode.desc,
                )
          ]))
        .get();
    return rows.map(_mapRow).toList();
  }

  Future<void> addMoment({
    required String content,
    String? authorId,
    List<Map<String, dynamic>> media = const [],
    String visibility = 'private',
    bool allowComments = true,
  }) async {
    await _db.into(_db.moments).insert(
          MomentsCompanion.insert(
            id: _uuid.v4(),
            authorId: drift.Value(authorId),
            content: content,
            mediaJson: drift.Value(jsonEncode(media)),
            visibility: drift.Value(visibility),
            allowComments: drift.Value(allowComments),
          ),
        );
  }

  Future<void> deleteMoment(String id) async {
    await (_db.delete(_db.moments)..where((tbl) => tbl.id.equals(id))).go();
  }

  chat.MomentsEntry _mapRow(Moment row) {
    return chat.MomentsEntry(
      id: row.id,
      authorId: row.authorId,
      content: row.content,
      media: row.mediaJson.isEmpty
          ? const []
          : List<Map<String, dynamic>>.from(jsonDecode(row.mediaJson) as List),
      visibility: row.visibility,
      allowComments: row.allowComments,
      likeCount: row.likeCount,
      commentCount: row.commentCount,
      createdAt: row.createdAt,
    );
  }
}
