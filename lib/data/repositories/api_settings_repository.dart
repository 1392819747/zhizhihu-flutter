import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/api_entities.dart';
import '../../data/models/api_provider.dart';
import '../app_database.dart';

class ApiSettingsRepository {
  ApiSettingsRepository({
    required AppDatabase database,
    FlutterSecureStorage? secureStorage,
  })  : _db = database,
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final AppDatabase _db;
  final FlutterSecureStorage _secureStorage;

  static const _selectedEndpointPref = 'selected_endpoint';
  static const _selectedCharacterPref = 'selected_character';
  static const _userPersonaPref = 'user_persona';
  static const _worldInfoPref = 'world_infos';

  Stream<List<ApiEndpoint>> watchEndpoints() async* {
    final controller = StreamController<List<ApiEndpoint>>();
    late StreamSubscription sub;
    Future<void> emit() async {
      controller.add(await loadEndpoints());
    }

    sub = (_db.select(_db.providerProfiles)).watch().listen((_) => emit());
    controller.onCancel = () => sub.cancel();
    await emit();
    yield* controller.stream;
  }

  Future<List<ApiEndpoint>> loadEndpoints() async {
    final profiles = await _db.select(_db.providerProfiles).get();
    final keys = await _db.select(_db.providerKeys).get();
    final keyMap = <String, ProviderKey>{};
    for (final key in keys) {
      keyMap[key.profileId] = key;
    }
    profiles.sort((a, b) => a.priority.compareTo(b.priority));
    return profiles
        .map(
          (row) => ApiEndpoint(
            id: row.id,
            name: row.name,
            type: apiProviderTypeFromStorage(row.type),
            baseUrl: row.baseUrl,
            model: row.defaultModel ?? '',
            keyLabel: keyMap[row.id]?.label ?? '',
            notes: row.notes,
            enabledFunctions:
                List<String>.from(jsonDecode(row.featuresJson) as List),
            generationConfig:
                GenerationConfig.fromStorage(row.generationConfigJson),
            isEnabled: row.isEnabled,
            priority: row.priority,
          ),
        )
        .toList();
  }

  Future<ApiEndpoint?> getEndpointById(String id) async {
    final row = await (_db.select(_db.providerProfiles)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    final keyRow = await (_db.select(_db.providerKeys)
          ..where((tbl) => tbl.profileId.equals(id)))
        .getSingleOrNull();
    return ApiEndpoint(
      id: row.id,
      name: row.name,
      type: apiProviderTypeFromStorage(row.type),
      baseUrl: row.baseUrl,
      model: row.defaultModel ?? '',
      keyLabel: keyRow?.label ?? '',
      notes: row.notes,
      enabledFunctions: List<String>.from(jsonDecode(row.featuresJson) as List),
      generationConfig: GenerationConfig.fromStorage(row.generationConfigJson),
      isEnabled: row.isEnabled,
      priority: row.priority,
    );
  }

  Future<void> upsertEndpoint(ApiEndpoint endpoint, {String? apiKey}) async {
    await _db.into(_db.providerProfiles).insertOnConflictUpdate(
          ProviderProfilesCompanion(
            id: Value(endpoint.id),
            name: Value(endpoint.name),
            type: Value(endpoint.type.storageValue),
            baseUrl: Value(endpoint.baseUrl),
            defaultModel: Value(endpoint.model),
            notes: Value(endpoint.notes),
            isEnabled: Value(endpoint.isEnabled),
            priority: Value(endpoint.priority),
            featuresJson: Value(jsonEncode(endpoint.enabledFunctions)),
            generationConfigJson: Value(endpoint.generationConfig.toStorage()),
            updatedAt: Value(DateTime.now()),
          ),
        );

    final keyRef = _secureKeyRef(endpoint.id);
    if (apiKey != null && apiKey.isNotEmpty) {
      await _secureStorage.write(key: keyRef, value: apiKey);
    }
    final existingKey = await (_db.select(_db.providerKeys)
          ..where((tbl) => tbl.profileId.equals(endpoint.id)))
        .getSingleOrNull();
    if (existingKey == null) {
      await _db.into(_db.providerKeys).insert(
            ProviderKeysCompanion.insert(
              profileId: endpoint.id,
              label: endpoint.keyLabel,
              secureKeyRef: keyRef,
            ),
          );
    } else if (existingKey.label != endpoint.keyLabel) {
      await (_db.update(_db.providerKeys)
            ..where((tbl) => tbl.id.equals(existingKey.id)))
          .write(
        ProviderKeysCompanion(
          label: Value(endpoint.keyLabel),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<void> deleteEndpoint(String id) async {
    await (_db.delete(_db.providerProfiles)..where((tbl) => tbl.id.equals(id)))
        .go();
    await (_db.delete(_db.providerKeys)
          ..where((tbl) => tbl.profileId.equals(id)))
        .go();
    await _secureStorage.delete(key: _secureKeyRef(id));
    final selected = await getSelectedEndpointId();
    if (selected == id) {
      final remaining = await loadEndpoints();
      await setSelectedEndpointId(
          remaining.isNotEmpty ? remaining.first.id : '');
    }
  }

  Future<String?> readEndpointKey(String id) async {
    return _secureStorage.read(key: _secureKeyRef(id));
  }

  String _secureKeyRef(String id) => 'provider:$id';

  Future<void> setSelectedEndpointId(String id) async {
    await _setPreference(_selectedEndpointPref, id);
  }

  Future<String?> getSelectedEndpointId() async {
    return _getPreference(_selectedEndpointPref);
  }

  Stream<String?> watchSelectedEndpointId() {
    return _db
        .customSelect('SELECT value FROM app_preferences WHERE key = ?',
            variables: [Variable(_selectedEndpointPref)],
            readsFrom: {_db.appPreferences})
        .watch()
        .map((rows) =>
            rows.isNotEmpty ? rows.first.data['value'] as String? : null);
  }

  Future<void> setSelectedCharacterId(String id) async {
    await _setPreference(_selectedCharacterPref, id);
  }

  Future<String?> getSelectedCharacterId() =>
      _getPreference(_selectedCharacterPref);

  Future<void> saveUserPersona(UserPersona persona) async {
    await _setPreference(_userPersonaPref, jsonEncode(persona.toJson()));
  }

  Future<String?> loadUserPersonaRaw() => _getPreference(_userPersonaPref);

  Future<void> saveWorldInfos(List<WorldInfoEntry> entries) async {
    await _setPreference(
        _worldInfoPref, jsonEncode(entries.map((e) => e.toJson()).toList()));
  }

  Future<String?> loadWorldInfosRaw() => _getPreference(_worldInfoPref);

  Future<void> _setPreference(String key, String value) async {
    await _db.into(_db.appPreferences).insertOnConflictUpdate(
          AppPreferencesCompanion(
            key: Value(key),
            value: Value(value),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  Future<String?> _getPreference(String key) async {
    final row = await (_db.select(_db.appPreferences)
          ..where((tbl) => tbl.key.equals(key)))
        .getSingleOrNull();
    return row?.value;
  }
}
