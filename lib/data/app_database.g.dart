// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProviderProfilesTable extends ProviderProfiles
    with TableInfo<$ProviderProfilesTable, ProviderProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProviderProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('openai'));
  static const VerificationMeta _baseUrlMeta =
      const VerificationMeta('baseUrl');
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
      'base_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _defaultModelMeta =
      const VerificationMeta('defaultModel');
  @override
  late final GeneratedColumn<String> defaultModel = GeneratedColumn<String>(
      'default_model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _generationConfigJsonMeta =
      const VerificationMeta('generationConfigJson');
  @override
  late final GeneratedColumn<String> generationConfigJson = GeneratedColumn<
          String>('generation_config_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(
          '{"temperature":0.7,"topP":1.0,"topK":0,"maxTokens":1024,"presencePenalty":0.0,"frequencyPenalty":0.0,"stream":true}'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _featuresJsonMeta =
      const VerificationMeta('featuresJson');
  @override
  late final GeneratedColumn<String> featuresJson = GeneratedColumn<String>(
      'features_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        type,
        baseUrl,
        defaultModel,
        generationConfigJson,
        notes,
        isEnabled,
        priority,
        featuresJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'provider_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<ProviderProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('base_url')) {
      context.handle(_baseUrlMeta,
          baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta));
    }
    if (data.containsKey('default_model')) {
      context.handle(
          _defaultModelMeta,
          defaultModel.isAcceptableOrUnknown(
              data['default_model']!, _defaultModelMeta));
    }
    if (data.containsKey('generation_config_json')) {
      context.handle(
          _generationConfigJsonMeta,
          generationConfigJson.isAcceptableOrUnknown(
              data['generation_config_json']!, _generationConfigJsonMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('features_json')) {
      context.handle(
          _featuresJsonMeta,
          featuresJson.isAcceptableOrUnknown(
              data['features_json']!, _featuresJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProviderProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProviderProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      baseUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}base_url'])!,
      defaultModel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}default_model']),
      generationConfigJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}generation_config_json'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes'])!,
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      featuresJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}features_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ProviderProfilesTable createAlias(String alias) {
    return $ProviderProfilesTable(attachedDatabase, alias);
  }
}

class ProviderProfile extends DataClass implements Insertable<ProviderProfile> {
  final String id;
  final String name;
  final String type;
  final String baseUrl;
  final String? defaultModel;
  final String generationConfigJson;
  final String notes;
  final bool isEnabled;
  final int priority;
  final String featuresJson;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ProviderProfile(
      {required this.id,
      required this.name,
      required this.type,
      required this.baseUrl,
      this.defaultModel,
      required this.generationConfigJson,
      required this.notes,
      required this.isEnabled,
      required this.priority,
      required this.featuresJson,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['base_url'] = Variable<String>(baseUrl);
    if (!nullToAbsent || defaultModel != null) {
      map['default_model'] = Variable<String>(defaultModel);
    }
    map['generation_config_json'] = Variable<String>(generationConfigJson);
    map['notes'] = Variable<String>(notes);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['priority'] = Variable<int>(priority);
    map['features_json'] = Variable<String>(featuresJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProviderProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProviderProfilesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      baseUrl: Value(baseUrl),
      defaultModel: defaultModel == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultModel),
      generationConfigJson: Value(generationConfigJson),
      notes: Value(notes),
      isEnabled: Value(isEnabled),
      priority: Value(priority),
      featuresJson: Value(featuresJson),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ProviderProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProviderProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      defaultModel: serializer.fromJson<String?>(json['defaultModel']),
      generationConfigJson:
          serializer.fromJson<String>(json['generationConfigJson']),
      notes: serializer.fromJson<String>(json['notes']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      priority: serializer.fromJson<int>(json['priority']),
      featuresJson: serializer.fromJson<String>(json['featuresJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'defaultModel': serializer.toJson<String?>(defaultModel),
      'generationConfigJson': serializer.toJson<String>(generationConfigJson),
      'notes': serializer.toJson<String>(notes),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'priority': serializer.toJson<int>(priority),
      'featuresJson': serializer.toJson<String>(featuresJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ProviderProfile copyWith(
          {String? id,
          String? name,
          String? type,
          String? baseUrl,
          Value<String?> defaultModel = const Value.absent(),
          String? generationConfigJson,
          String? notes,
          bool? isEnabled,
          int? priority,
          String? featuresJson,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ProviderProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        baseUrl: baseUrl ?? this.baseUrl,
        defaultModel:
            defaultModel.present ? defaultModel.value : this.defaultModel,
        generationConfigJson: generationConfigJson ?? this.generationConfigJson,
        notes: notes ?? this.notes,
        isEnabled: isEnabled ?? this.isEnabled,
        priority: priority ?? this.priority,
        featuresJson: featuresJson ?? this.featuresJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ProviderProfile copyWithCompanion(ProviderProfilesCompanion data) {
    return ProviderProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      defaultModel: data.defaultModel.present
          ? data.defaultModel.value
          : this.defaultModel,
      generationConfigJson: data.generationConfigJson.present
          ? data.generationConfigJson.value
          : this.generationConfigJson,
      notes: data.notes.present ? data.notes.value : this.notes,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      priority: data.priority.present ? data.priority.value : this.priority,
      featuresJson: data.featuresJson.present
          ? data.featuresJson.value
          : this.featuresJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProviderProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('defaultModel: $defaultModel, ')
          ..write('generationConfigJson: $generationConfigJson, ')
          ..write('notes: $notes, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('priority: $priority, ')
          ..write('featuresJson: $featuresJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      type,
      baseUrl,
      defaultModel,
      generationConfigJson,
      notes,
      isEnabled,
      priority,
      featuresJson,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProviderProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.baseUrl == this.baseUrl &&
          other.defaultModel == this.defaultModel &&
          other.generationConfigJson == this.generationConfigJson &&
          other.notes == this.notes &&
          other.isEnabled == this.isEnabled &&
          other.priority == this.priority &&
          other.featuresJson == this.featuresJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProviderProfilesCompanion extends UpdateCompanion<ProviderProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String> baseUrl;
  final Value<String?> defaultModel;
  final Value<String> generationConfigJson;
  final Value<String> notes;
  final Value<bool> isEnabled;
  final Value<int> priority;
  final Value<String> featuresJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ProviderProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.defaultModel = const Value.absent(),
    this.generationConfigJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.featuresJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProviderProfilesCompanion.insert({
    required String id,
    required String name,
    this.type = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.defaultModel = const Value.absent(),
    this.generationConfigJson = const Value.absent(),
    this.notes = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.featuresJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<ProviderProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? baseUrl,
    Expression<String>? defaultModel,
    Expression<String>? generationConfigJson,
    Expression<String>? notes,
    Expression<bool>? isEnabled,
    Expression<int>? priority,
    Expression<String>? featuresJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (baseUrl != null) 'base_url': baseUrl,
      if (defaultModel != null) 'default_model': defaultModel,
      if (generationConfigJson != null)
        'generation_config_json': generationConfigJson,
      if (notes != null) 'notes': notes,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (priority != null) 'priority': priority,
      if (featuresJson != null) 'features_json': featuresJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProviderProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<String>? baseUrl,
      Value<String?>? defaultModel,
      Value<String>? generationConfigJson,
      Value<String>? notes,
      Value<bool>? isEnabled,
      Value<int>? priority,
      Value<String>? featuresJson,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ProviderProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      baseUrl: baseUrl ?? this.baseUrl,
      defaultModel: defaultModel ?? this.defaultModel,
      generationConfigJson: generationConfigJson ?? this.generationConfigJson,
      notes: notes ?? this.notes,
      isEnabled: isEnabled ?? this.isEnabled,
      priority: priority ?? this.priority,
      featuresJson: featuresJson ?? this.featuresJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (defaultModel.present) {
      map['default_model'] = Variable<String>(defaultModel.value);
    }
    if (generationConfigJson.present) {
      map['generation_config_json'] =
          Variable<String>(generationConfigJson.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (featuresJson.present) {
      map['features_json'] = Variable<String>(featuresJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProviderProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('defaultModel: $defaultModel, ')
          ..write('generationConfigJson: $generationConfigJson, ')
          ..write('notes: $notes, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('priority: $priority, ')
          ..write('featuresJson: $featuresJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProviderKeysTable extends ProviderKeys
    with TableInfo<$ProviderKeysTable, ProviderKey> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProviderKeysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _profileIdMeta =
      const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
      'profile_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES provider_profiles (id)'));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _secureKeyRefMeta =
      const VerificationMeta('secureKeyRef');
  @override
  late final GeneratedColumn<String> secureKeyRef = GeneratedColumn<String>(
      'secure_key_ref', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, profileId, label, secureKeyRef, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'provider_keys';
  @override
  VerificationContext validateIntegrity(Insertable<ProviderKey> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('secure_key_ref')) {
      context.handle(
          _secureKeyRefMeta,
          secureKeyRef.isAcceptableOrUnknown(
              data['secure_key_ref']!, _secureKeyRefMeta));
    } else if (isInserting) {
      context.missing(_secureKeyRefMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProviderKey map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProviderKey(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      profileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      secureKeyRef: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secure_key_ref'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ProviderKeysTable createAlias(String alias) {
    return $ProviderKeysTable(attachedDatabase, alias);
  }
}

class ProviderKey extends DataClass implements Insertable<ProviderKey> {
  final int id;
  final String profileId;
  final String label;
  final String secureKeyRef;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ProviderKey(
      {required this.id,
      required this.profileId,
      required this.label,
      required this.secureKeyRef,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['label'] = Variable<String>(label);
    map['secure_key_ref'] = Variable<String>(secureKeyRef);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProviderKeysCompanion toCompanion(bool nullToAbsent) {
    return ProviderKeysCompanion(
      id: Value(id),
      profileId: Value(profileId),
      label: Value(label),
      secureKeyRef: Value(secureKeyRef),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ProviderKey.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProviderKey(
      id: serializer.fromJson<int>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      label: serializer.fromJson<String>(json['label']),
      secureKeyRef: serializer.fromJson<String>(json['secureKeyRef']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'profileId': serializer.toJson<String>(profileId),
      'label': serializer.toJson<String>(label),
      'secureKeyRef': serializer.toJson<String>(secureKeyRef),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ProviderKey copyWith(
          {int? id,
          String? profileId,
          String? label,
          String? secureKeyRef,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ProviderKey(
        id: id ?? this.id,
        profileId: profileId ?? this.profileId,
        label: label ?? this.label,
        secureKeyRef: secureKeyRef ?? this.secureKeyRef,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ProviderKey copyWithCompanion(ProviderKeysCompanion data) {
    return ProviderKey(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      label: data.label.present ? data.label.value : this.label,
      secureKeyRef: data.secureKeyRef.present
          ? data.secureKeyRef.value
          : this.secureKeyRef,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProviderKey(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('label: $label, ')
          ..write('secureKeyRef: $secureKeyRef, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, profileId, label, secureKeyRef, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProviderKey &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.label == this.label &&
          other.secureKeyRef == this.secureKeyRef &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProviderKeysCompanion extends UpdateCompanion<ProviderKey> {
  final Value<int> id;
  final Value<String> profileId;
  final Value<String> label;
  final Value<String> secureKeyRef;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const ProviderKeysCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.label = const Value.absent(),
    this.secureKeyRef = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProviderKeysCompanion.insert({
    this.id = const Value.absent(),
    required String profileId,
    required String label,
    required String secureKeyRef,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : profileId = Value(profileId),
        label = Value(label),
        secureKeyRef = Value(secureKeyRef);
  static Insertable<ProviderKey> custom({
    Expression<int>? id,
    Expression<String>? profileId,
    Expression<String>? label,
    Expression<String>? secureKeyRef,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (label != null) 'label': label,
      if (secureKeyRef != null) 'secure_key_ref': secureKeyRef,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProviderKeysCompanion copyWith(
      {Value<int>? id,
      Value<String>? profileId,
      Value<String>? label,
      Value<String>? secureKeyRef,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return ProviderKeysCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      label: label ?? this.label,
      secureKeyRef: secureKeyRef ?? this.secureKeyRef,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (secureKeyRef.present) {
      map['secure_key_ref'] = Variable<String>(secureKeyRef.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProviderKeysCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('label: $label, ')
          ..write('secureKeyRef: $secureKeyRef, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ModelPresetsTable extends ModelPresets
    with TableInfo<$ModelPresetsTable, ModelPreset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelPresetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
      'temperature', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.7));
  static const VerificationMeta _topPMeta = const VerificationMeta('topP');
  @override
  late final GeneratedColumn<double> topP = GeneratedColumn<double>(
      'top_p', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _topKMeta = const VerificationMeta('topK');
  @override
  late final GeneratedColumn<int> topK = GeneratedColumn<int>(
      'top_k', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxTokensMeta =
      const VerificationMeta('maxTokens');
  @override
  late final GeneratedColumn<int> maxTokens = GeneratedColumn<int>(
      'max_tokens', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _presencePenaltyMeta =
      const VerificationMeta('presencePenalty');
  @override
  late final GeneratedColumn<double> presencePenalty = GeneratedColumn<double>(
      'presence_penalty', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _frequencyPenaltyMeta =
      const VerificationMeta('frequencyPenalty');
  @override
  late final GeneratedColumn<double> frequencyPenalty = GeneratedColumn<double>(
      'frequency_penalty', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _streamMeta = const VerificationMeta('stream');
  @override
  late final GeneratedColumn<bool> stream = GeneratedColumn<bool>(
      'stream', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("stream" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _stopSequencesJsonMeta =
      const VerificationMeta('stopSequencesJson');
  @override
  late final GeneratedColumn<String> stopSequencesJson =
      GeneratedColumn<String>('stop_sequences_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        temperature,
        topP,
        topK,
        maxTokens,
        presencePenalty,
        frequencyPenalty,
        stream,
        stopSequencesJson,
        metadata,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'model_presets';
  @override
  VerificationContext validateIntegrity(Insertable<ModelPreset> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    }
    if (data.containsKey('top_p')) {
      context.handle(
          _topPMeta, topP.isAcceptableOrUnknown(data['top_p']!, _topPMeta));
    }
    if (data.containsKey('top_k')) {
      context.handle(
          _topKMeta, topK.isAcceptableOrUnknown(data['top_k']!, _topKMeta));
    }
    if (data.containsKey('max_tokens')) {
      context.handle(_maxTokensMeta,
          maxTokens.isAcceptableOrUnknown(data['max_tokens']!, _maxTokensMeta));
    }
    if (data.containsKey('presence_penalty')) {
      context.handle(
          _presencePenaltyMeta,
          presencePenalty.isAcceptableOrUnknown(
              data['presence_penalty']!, _presencePenaltyMeta));
    }
    if (data.containsKey('frequency_penalty')) {
      context.handle(
          _frequencyPenaltyMeta,
          frequencyPenalty.isAcceptableOrUnknown(
              data['frequency_penalty']!, _frequencyPenaltyMeta));
    }
    if (data.containsKey('stream')) {
      context.handle(_streamMeta,
          stream.isAcceptableOrUnknown(data['stream']!, _streamMeta));
    }
    if (data.containsKey('stop_sequences_json')) {
      context.handle(
          _stopSequencesJsonMeta,
          stopSequencesJson.isAcceptableOrUnknown(
              data['stop_sequences_json']!, _stopSequencesJsonMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ModelPreset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModelPreset(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temperature'])!,
      topP: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}top_p'])!,
      topK: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}top_k'])!,
      maxTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_tokens']),
      presencePenalty: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}presence_penalty'])!,
      frequencyPenalty: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}frequency_penalty'])!,
      stream: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}stream'])!,
      stopSequencesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}stop_sequences_json'])!,
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ModelPresetsTable createAlias(String alias) {
    return $ModelPresetsTable(attachedDatabase, alias);
  }
}

class ModelPreset extends DataClass implements Insertable<ModelPreset> {
  final String id;
  final String name;
  final double temperature;
  final double topP;
  final int topK;
  final int? maxTokens;
  final double presencePenalty;
  final double frequencyPenalty;
  final bool stream;
  final String stopSequencesJson;
  final String metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ModelPreset(
      {required this.id,
      required this.name,
      required this.temperature,
      required this.topP,
      required this.topK,
      this.maxTokens,
      required this.presencePenalty,
      required this.frequencyPenalty,
      required this.stream,
      required this.stopSequencesJson,
      required this.metadata,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['temperature'] = Variable<double>(temperature);
    map['top_p'] = Variable<double>(topP);
    map['top_k'] = Variable<int>(topK);
    if (!nullToAbsent || maxTokens != null) {
      map['max_tokens'] = Variable<int>(maxTokens);
    }
    map['presence_penalty'] = Variable<double>(presencePenalty);
    map['frequency_penalty'] = Variable<double>(frequencyPenalty);
    map['stream'] = Variable<bool>(stream);
    map['stop_sequences_json'] = Variable<String>(stopSequencesJson);
    map['metadata'] = Variable<String>(metadata);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ModelPresetsCompanion toCompanion(bool nullToAbsent) {
    return ModelPresetsCompanion(
      id: Value(id),
      name: Value(name),
      temperature: Value(temperature),
      topP: Value(topP),
      topK: Value(topK),
      maxTokens: maxTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(maxTokens),
      presencePenalty: Value(presencePenalty),
      frequencyPenalty: Value(frequencyPenalty),
      stream: Value(stream),
      stopSequencesJson: Value(stopSequencesJson),
      metadata: Value(metadata),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ModelPreset.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelPreset(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      temperature: serializer.fromJson<double>(json['temperature']),
      topP: serializer.fromJson<double>(json['topP']),
      topK: serializer.fromJson<int>(json['topK']),
      maxTokens: serializer.fromJson<int?>(json['maxTokens']),
      presencePenalty: serializer.fromJson<double>(json['presencePenalty']),
      frequencyPenalty: serializer.fromJson<double>(json['frequencyPenalty']),
      stream: serializer.fromJson<bool>(json['stream']),
      stopSequencesJson: serializer.fromJson<String>(json['stopSequencesJson']),
      metadata: serializer.fromJson<String>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'temperature': serializer.toJson<double>(temperature),
      'topP': serializer.toJson<double>(topP),
      'topK': serializer.toJson<int>(topK),
      'maxTokens': serializer.toJson<int?>(maxTokens),
      'presencePenalty': serializer.toJson<double>(presencePenalty),
      'frequencyPenalty': serializer.toJson<double>(frequencyPenalty),
      'stream': serializer.toJson<bool>(stream),
      'stopSequencesJson': serializer.toJson<String>(stopSequencesJson),
      'metadata': serializer.toJson<String>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ModelPreset copyWith(
          {String? id,
          String? name,
          double? temperature,
          double? topP,
          int? topK,
          Value<int?> maxTokens = const Value.absent(),
          double? presencePenalty,
          double? frequencyPenalty,
          bool? stream,
          String? stopSequencesJson,
          String? metadata,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ModelPreset(
        id: id ?? this.id,
        name: name ?? this.name,
        temperature: temperature ?? this.temperature,
        topP: topP ?? this.topP,
        topK: topK ?? this.topK,
        maxTokens: maxTokens.present ? maxTokens.value : this.maxTokens,
        presencePenalty: presencePenalty ?? this.presencePenalty,
        frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
        stream: stream ?? this.stream,
        stopSequencesJson: stopSequencesJson ?? this.stopSequencesJson,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ModelPreset copyWithCompanion(ModelPresetsCompanion data) {
    return ModelPreset(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      topP: data.topP.present ? data.topP.value : this.topP,
      topK: data.topK.present ? data.topK.value : this.topK,
      maxTokens: data.maxTokens.present ? data.maxTokens.value : this.maxTokens,
      presencePenalty: data.presencePenalty.present
          ? data.presencePenalty.value
          : this.presencePenalty,
      frequencyPenalty: data.frequencyPenalty.present
          ? data.frequencyPenalty.value
          : this.frequencyPenalty,
      stream: data.stream.present ? data.stream.value : this.stream,
      stopSequencesJson: data.stopSequencesJson.present
          ? data.stopSequencesJson.value
          : this.stopSequencesJson,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModelPreset(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('temperature: $temperature, ')
          ..write('topP: $topP, ')
          ..write('topK: $topK, ')
          ..write('maxTokens: $maxTokens, ')
          ..write('presencePenalty: $presencePenalty, ')
          ..write('frequencyPenalty: $frequencyPenalty, ')
          ..write('stream: $stream, ')
          ..write('stopSequencesJson: $stopSequencesJson, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      temperature,
      topP,
      topK,
      maxTokens,
      presencePenalty,
      frequencyPenalty,
      stream,
      stopSequencesJson,
      metadata,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelPreset &&
          other.id == this.id &&
          other.name == this.name &&
          other.temperature == this.temperature &&
          other.topP == this.topP &&
          other.topK == this.topK &&
          other.maxTokens == this.maxTokens &&
          other.presencePenalty == this.presencePenalty &&
          other.frequencyPenalty == this.frequencyPenalty &&
          other.stream == this.stream &&
          other.stopSequencesJson == this.stopSequencesJson &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ModelPresetsCompanion extends UpdateCompanion<ModelPreset> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> temperature;
  final Value<double> topP;
  final Value<int> topK;
  final Value<int?> maxTokens;
  final Value<double> presencePenalty;
  final Value<double> frequencyPenalty;
  final Value<bool> stream;
  final Value<String> stopSequencesJson;
  final Value<String> metadata;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ModelPresetsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.temperature = const Value.absent(),
    this.topP = const Value.absent(),
    this.topK = const Value.absent(),
    this.maxTokens = const Value.absent(),
    this.presencePenalty = const Value.absent(),
    this.frequencyPenalty = const Value.absent(),
    this.stream = const Value.absent(),
    this.stopSequencesJson = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ModelPresetsCompanion.insert({
    required String id,
    required String name,
    this.temperature = const Value.absent(),
    this.topP = const Value.absent(),
    this.topK = const Value.absent(),
    this.maxTokens = const Value.absent(),
    this.presencePenalty = const Value.absent(),
    this.frequencyPenalty = const Value.absent(),
    this.stream = const Value.absent(),
    this.stopSequencesJson = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<ModelPreset> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? temperature,
    Expression<double>? topP,
    Expression<int>? topK,
    Expression<int>? maxTokens,
    Expression<double>? presencePenalty,
    Expression<double>? frequencyPenalty,
    Expression<bool>? stream,
    Expression<String>? stopSequencesJson,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (temperature != null) 'temperature': temperature,
      if (topP != null) 'top_p': topP,
      if (topK != null) 'top_k': topK,
      if (maxTokens != null) 'max_tokens': maxTokens,
      if (presencePenalty != null) 'presence_penalty': presencePenalty,
      if (frequencyPenalty != null) 'frequency_penalty': frequencyPenalty,
      if (stream != null) 'stream': stream,
      if (stopSequencesJson != null) 'stop_sequences_json': stopSequencesJson,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ModelPresetsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double>? temperature,
      Value<double>? topP,
      Value<int>? topK,
      Value<int?>? maxTokens,
      Value<double>? presencePenalty,
      Value<double>? frequencyPenalty,
      Value<bool>? stream,
      Value<String>? stopSequencesJson,
      Value<String>? metadata,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ModelPresetsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      topK: topK ?? this.topK,
      maxTokens: maxTokens ?? this.maxTokens,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      stream: stream ?? this.stream,
      stopSequencesJson: stopSequencesJson ?? this.stopSequencesJson,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (topP.present) {
      map['top_p'] = Variable<double>(topP.value);
    }
    if (topK.present) {
      map['top_k'] = Variable<int>(topK.value);
    }
    if (maxTokens.present) {
      map['max_tokens'] = Variable<int>(maxTokens.value);
    }
    if (presencePenalty.present) {
      map['presence_penalty'] = Variable<double>(presencePenalty.value);
    }
    if (frequencyPenalty.present) {
      map['frequency_penalty'] = Variable<double>(frequencyPenalty.value);
    }
    if (stream.present) {
      map['stream'] = Variable<bool>(stream.value);
    }
    if (stopSequencesJson.present) {
      map['stop_sequences_json'] = Variable<String>(stopSequencesJson.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelPresetsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('temperature: $temperature, ')
          ..write('topP: $topP, ')
          ..write('topK: $topK, ')
          ..write('maxTokens: $maxTokens, ')
          ..write('presencePenalty: $presencePenalty, ')
          ..write('frequencyPenalty: $frequencyPenalty, ')
          ..write('stream: $stream, ')
          ..write('stopSequencesJson: $stopSequencesJson, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personaMeta =
      const VerificationMeta('persona');
  @override
  late final GeneratedColumn<String> persona = GeneratedColumn<String>(
      'persona', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _greetingMeta =
      const VerificationMeta('greeting');
  @override
  late final GeneratedColumn<String> greeting = GeneratedColumn<String>(
      'greeting', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _avatarColorMeta =
      const VerificationMeta('avatarColor');
  @override
  late final GeneratedColumn<String> avatarColor = GeneratedColumn<String>(
      'avatar_color', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('#07C160'));
  static const VerificationMeta _endpointIdMeta =
      const VerificationMeta('endpointId');
  @override
  late final GeneratedColumn<String> endpointId = GeneratedColumn<String>(
      'endpoint_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES provider_profiles (id)'));
  static const VerificationMeta _presetIdMeta =
      const VerificationMeta('presetId');
  @override
  late final GeneratedColumn<String> presetId = GeneratedColumn<String>(
      'preset_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES model_presets (id)'));
  static const VerificationMeta _memoryConfigJsonMeta =
      const VerificationMeta('memoryConfigJson');
  @override
  late final GeneratedColumn<String> memoryConfigJson = GeneratedColumn<String>(
      'memory_config_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(
          '{"autoSummary":true,"tokenWindow":2000,"summaryTarget":600,"minIntervalSeconds":180}'));
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _sampleRepliesJsonMeta =
      const VerificationMeta('sampleRepliesJson');
  @override
  late final GeneratedColumn<String> sampleRepliesJson =
      GeneratedColumn<String>('sample_replies_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _archivedMeta =
      const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
      'archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        persona,
        greeting,
        description,
        avatarColor,
        endpointId,
        presetId,
        memoryConfigJson,
        tagsJson,
        sampleRepliesJson,
        archived,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('persona')) {
      context.handle(_personaMeta,
          persona.isAcceptableOrUnknown(data['persona']!, _personaMeta));
    }
    if (data.containsKey('greeting')) {
      context.handle(_greetingMeta,
          greeting.isAcceptableOrUnknown(data['greeting']!, _greetingMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('avatar_color')) {
      context.handle(
          _avatarColorMeta,
          avatarColor.isAcceptableOrUnknown(
              data['avatar_color']!, _avatarColorMeta));
    }
    if (data.containsKey('endpoint_id')) {
      context.handle(
          _endpointIdMeta,
          endpointId.isAcceptableOrUnknown(
              data['endpoint_id']!, _endpointIdMeta));
    }
    if (data.containsKey('preset_id')) {
      context.handle(_presetIdMeta,
          presetId.isAcceptableOrUnknown(data['preset_id']!, _presetIdMeta));
    }
    if (data.containsKey('memory_config_json')) {
      context.handle(
          _memoryConfigJsonMeta,
          memoryConfigJson.isAcceptableOrUnknown(
              data['memory_config_json']!, _memoryConfigJsonMeta));
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    }
    if (data.containsKey('sample_replies_json')) {
      context.handle(
          _sampleRepliesJsonMeta,
          sampleRepliesJson.isAcceptableOrUnknown(
              data['sample_replies_json']!, _sampleRepliesJsonMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta,
          archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      persona: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}persona'])!,
      greeting: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}greeting'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      avatarColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_color'])!,
      endpointId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}endpoint_id']),
      presetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preset_id']),
      memoryConfigJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}memory_config_json'])!,
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json'])!,
      sampleRepliesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sample_replies_json'])!,
      archived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final String id;
  final String name;
  final String persona;
  final String greeting;
  final String description;
  final String avatarColor;
  final String? endpointId;
  final String? presetId;
  final String memoryConfigJson;
  final String tagsJson;
  final String sampleRepliesJson;
  final bool archived;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Contact(
      {required this.id,
      required this.name,
      required this.persona,
      required this.greeting,
      required this.description,
      required this.avatarColor,
      this.endpointId,
      this.presetId,
      required this.memoryConfigJson,
      required this.tagsJson,
      required this.sampleRepliesJson,
      required this.archived,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['persona'] = Variable<String>(persona);
    map['greeting'] = Variable<String>(greeting);
    map['description'] = Variable<String>(description);
    map['avatar_color'] = Variable<String>(avatarColor);
    if (!nullToAbsent || endpointId != null) {
      map['endpoint_id'] = Variable<String>(endpointId);
    }
    if (!nullToAbsent || presetId != null) {
      map['preset_id'] = Variable<String>(presetId);
    }
    map['memory_config_json'] = Variable<String>(memoryConfigJson);
    map['tags_json'] = Variable<String>(tagsJson);
    map['sample_replies_json'] = Variable<String>(sampleRepliesJson);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      name: Value(name),
      persona: Value(persona),
      greeting: Value(greeting),
      description: Value(description),
      avatarColor: Value(avatarColor),
      endpointId: endpointId == null && nullToAbsent
          ? const Value.absent()
          : Value(endpointId),
      presetId: presetId == null && nullToAbsent
          ? const Value.absent()
          : Value(presetId),
      memoryConfigJson: Value(memoryConfigJson),
      tagsJson: Value(tagsJson),
      sampleRepliesJson: Value(sampleRepliesJson),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      persona: serializer.fromJson<String>(json['persona']),
      greeting: serializer.fromJson<String>(json['greeting']),
      description: serializer.fromJson<String>(json['description']),
      avatarColor: serializer.fromJson<String>(json['avatarColor']),
      endpointId: serializer.fromJson<String?>(json['endpointId']),
      presetId: serializer.fromJson<String?>(json['presetId']),
      memoryConfigJson: serializer.fromJson<String>(json['memoryConfigJson']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
      sampleRepliesJson: serializer.fromJson<String>(json['sampleRepliesJson']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'persona': serializer.toJson<String>(persona),
      'greeting': serializer.toJson<String>(greeting),
      'description': serializer.toJson<String>(description),
      'avatarColor': serializer.toJson<String>(avatarColor),
      'endpointId': serializer.toJson<String?>(endpointId),
      'presetId': serializer.toJson<String?>(presetId),
      'memoryConfigJson': serializer.toJson<String>(memoryConfigJson),
      'tagsJson': serializer.toJson<String>(tagsJson),
      'sampleRepliesJson': serializer.toJson<String>(sampleRepliesJson),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Contact copyWith(
          {String? id,
          String? name,
          String? persona,
          String? greeting,
          String? description,
          String? avatarColor,
          Value<String?> endpointId = const Value.absent(),
          Value<String?> presetId = const Value.absent(),
          String? memoryConfigJson,
          String? tagsJson,
          String? sampleRepliesJson,
          bool? archived,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        persona: persona ?? this.persona,
        greeting: greeting ?? this.greeting,
        description: description ?? this.description,
        avatarColor: avatarColor ?? this.avatarColor,
        endpointId: endpointId.present ? endpointId.value : this.endpointId,
        presetId: presetId.present ? presetId.value : this.presetId,
        memoryConfigJson: memoryConfigJson ?? this.memoryConfigJson,
        tagsJson: tagsJson ?? this.tagsJson,
        sampleRepliesJson: sampleRepliesJson ?? this.sampleRepliesJson,
        archived: archived ?? this.archived,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      persona: data.persona.present ? data.persona.value : this.persona,
      greeting: data.greeting.present ? data.greeting.value : this.greeting,
      description:
          data.description.present ? data.description.value : this.description,
      avatarColor:
          data.avatarColor.present ? data.avatarColor.value : this.avatarColor,
      endpointId:
          data.endpointId.present ? data.endpointId.value : this.endpointId,
      presetId: data.presetId.present ? data.presetId.value : this.presetId,
      memoryConfigJson: data.memoryConfigJson.present
          ? data.memoryConfigJson.value
          : this.memoryConfigJson,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      sampleRepliesJson: data.sampleRepliesJson.present
          ? data.sampleRepliesJson.value
          : this.sampleRepliesJson,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('persona: $persona, ')
          ..write('greeting: $greeting, ')
          ..write('description: $description, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('endpointId: $endpointId, ')
          ..write('presetId: $presetId, ')
          ..write('memoryConfigJson: $memoryConfigJson, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('sampleRepliesJson: $sampleRepliesJson, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      persona,
      greeting,
      description,
      avatarColor,
      endpointId,
      presetId,
      memoryConfigJson,
      tagsJson,
      sampleRepliesJson,
      archived,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.name == this.name &&
          other.persona == this.persona &&
          other.greeting == this.greeting &&
          other.description == this.description &&
          other.avatarColor == this.avatarColor &&
          other.endpointId == this.endpointId &&
          other.presetId == this.presetId &&
          other.memoryConfigJson == this.memoryConfigJson &&
          other.tagsJson == this.tagsJson &&
          other.sampleRepliesJson == this.sampleRepliesJson &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> persona;
  final Value<String> greeting;
  final Value<String> description;
  final Value<String> avatarColor;
  final Value<String?> endpointId;
  final Value<String?> presetId;
  final Value<String> memoryConfigJson;
  final Value<String> tagsJson;
  final Value<String> sampleRepliesJson;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.persona = const Value.absent(),
    this.greeting = const Value.absent(),
    this.description = const Value.absent(),
    this.avatarColor = const Value.absent(),
    this.endpointId = const Value.absent(),
    this.presetId = const Value.absent(),
    this.memoryConfigJson = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.sampleRepliesJson = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String id,
    required String name,
    this.persona = const Value.absent(),
    this.greeting = const Value.absent(),
    this.description = const Value.absent(),
    this.avatarColor = const Value.absent(),
    this.endpointId = const Value.absent(),
    this.presetId = const Value.absent(),
    this.memoryConfigJson = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.sampleRepliesJson = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Contact> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? persona,
    Expression<String>? greeting,
    Expression<String>? description,
    Expression<String>? avatarColor,
    Expression<String>? endpointId,
    Expression<String>? presetId,
    Expression<String>? memoryConfigJson,
    Expression<String>? tagsJson,
    Expression<String>? sampleRepliesJson,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (persona != null) 'persona': persona,
      if (greeting != null) 'greeting': greeting,
      if (description != null) 'description': description,
      if (avatarColor != null) 'avatar_color': avatarColor,
      if (endpointId != null) 'endpoint_id': endpointId,
      if (presetId != null) 'preset_id': presetId,
      if (memoryConfigJson != null) 'memory_config_json': memoryConfigJson,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (sampleRepliesJson != null) 'sample_replies_json': sampleRepliesJson,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? persona,
      Value<String>? greeting,
      Value<String>? description,
      Value<String>? avatarColor,
      Value<String?>? endpointId,
      Value<String?>? presetId,
      Value<String>? memoryConfigJson,
      Value<String>? tagsJson,
      Value<String>? sampleRepliesJson,
      Value<bool>? archived,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ContactsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      persona: persona ?? this.persona,
      greeting: greeting ?? this.greeting,
      description: description ?? this.description,
      avatarColor: avatarColor ?? this.avatarColor,
      endpointId: endpointId ?? this.endpointId,
      presetId: presetId ?? this.presetId,
      memoryConfigJson: memoryConfigJson ?? this.memoryConfigJson,
      tagsJson: tagsJson ?? this.tagsJson,
      sampleRepliesJson: sampleRepliesJson ?? this.sampleRepliesJson,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (persona.present) {
      map['persona'] = Variable<String>(persona.value);
    }
    if (greeting.present) {
      map['greeting'] = Variable<String>(greeting.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (avatarColor.present) {
      map['avatar_color'] = Variable<String>(avatarColor.value);
    }
    if (endpointId.present) {
      map['endpoint_id'] = Variable<String>(endpointId.value);
    }
    if (presetId.present) {
      map['preset_id'] = Variable<String>(presetId.value);
    }
    if (memoryConfigJson.present) {
      map['memory_config_json'] = Variable<String>(memoryConfigJson.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (sampleRepliesJson.present) {
      map['sample_replies_json'] = Variable<String>(sampleRepliesJson.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('persona: $persona, ')
          ..write('greeting: $greeting, ')
          ..write('description: $description, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('endpointId: $endpointId, ')
          ..write('presetId: $presetId, ')
          ..write('memoryConfigJson: $memoryConfigJson, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('sampleRepliesJson: $sampleRepliesJson, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  static const VerificationMeta _providerProfileIdMeta =
      const VerificationMeta('providerProfileId');
  @override
  late final GeneratedColumn<String> providerProfileId =
      GeneratedColumn<String>('provider_profile_id', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'REFERENCES provider_profiles (id)'));
  static const VerificationMeta _modelPresetIdMeta =
      const VerificationMeta('modelPresetId');
  @override
  late final GeneratedColumn<String> modelPresetId = GeneratedColumn<String>(
      'model_preset_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES model_presets (id)'));
  static const VerificationMeta _lastMessageSnippetMeta =
      const VerificationMeta('lastMessageSnippet');
  @override
  late final GeneratedColumn<String> lastMessageSnippet =
      GeneratedColumn<String>('last_message_snippet', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant(''));
  static const VerificationMeta _lastMessageTimeMeta =
      const VerificationMeta('lastMessageTime');
  @override
  late final GeneratedColumn<DateTime> lastMessageTime =
      GeneratedColumn<DateTime>('last_message_time', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _unreadCountMeta =
      const VerificationMeta('unreadCount');
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
      'unread_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isMutedMeta =
      const VerificationMeta('isMuted');
  @override
  late final GeneratedColumn<bool> isMuted = GeneratedColumn<bool>(
      'is_muted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_muted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _draftTextMeta =
      const VerificationMeta('draftText');
  @override
  late final GeneratedColumn<String> draftText = GeneratedColumn<String>(
      'draft_text', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _memoryPolicyJsonMeta =
      const VerificationMeta('memoryPolicyJson');
  @override
  late final GeneratedColumn<String> memoryPolicyJson = GeneratedColumn<String>(
      'memory_policy_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(
          '{"autoSummary":true,"tokenWindow":2000,"summaryTarget":500,"minIntervalSeconds":180,"maxSummaries":3}'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        contactId,
        providerProfileId,
        modelPresetId,
        lastMessageSnippet,
        lastMessageTime,
        unreadCount,
        isPinned,
        isMuted,
        draftText,
        metadata,
        memoryPolicyJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conversations';
  @override
  VerificationContext validateIntegrity(Insertable<Conversation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    }
    if (data.containsKey('provider_profile_id')) {
      context.handle(
          _providerProfileIdMeta,
          providerProfileId.isAcceptableOrUnknown(
              data['provider_profile_id']!, _providerProfileIdMeta));
    }
    if (data.containsKey('model_preset_id')) {
      context.handle(
          _modelPresetIdMeta,
          modelPresetId.isAcceptableOrUnknown(
              data['model_preset_id']!, _modelPresetIdMeta));
    }
    if (data.containsKey('last_message_snippet')) {
      context.handle(
          _lastMessageSnippetMeta,
          lastMessageSnippet.isAcceptableOrUnknown(
              data['last_message_snippet']!, _lastMessageSnippetMeta));
    }
    if (data.containsKey('last_message_time')) {
      context.handle(
          _lastMessageTimeMeta,
          lastMessageTime.isAcceptableOrUnknown(
              data['last_message_time']!, _lastMessageTimeMeta));
    }
    if (data.containsKey('unread_count')) {
      context.handle(
          _unreadCountMeta,
          unreadCount.isAcceptableOrUnknown(
              data['unread_count']!, _unreadCountMeta));
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    }
    if (data.containsKey('is_muted')) {
      context.handle(_isMutedMeta,
          isMuted.isAcceptableOrUnknown(data['is_muted']!, _isMutedMeta));
    }
    if (data.containsKey('draft_text')) {
      context.handle(_draftTextMeta,
          draftText.isAcceptableOrUnknown(data['draft_text']!, _draftTextMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('memory_policy_json')) {
      context.handle(
          _memoryPolicyJsonMeta,
          memoryPolicyJson.isAcceptableOrUnknown(
              data['memory_policy_json']!, _memoryPolicyJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id']),
      providerProfileId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}provider_profile_id']),
      modelPresetId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model_preset_id']),
      lastMessageSnippet: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_message_snippet'])!,
      lastMessageTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_message_time']),
      unreadCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}unread_count'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      isMuted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_muted'])!,
      draftText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}draft_text'])!,
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
      memoryPolicyJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}memory_policy_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final String id;
  final String title;
  final String? contactId;
  final String? providerProfileId;
  final String? modelPresetId;
  final String lastMessageSnippet;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final bool isPinned;
  final bool isMuted;
  final String draftText;
  final String metadata;
  final String memoryPolicyJson;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Conversation(
      {required this.id,
      required this.title,
      this.contactId,
      this.providerProfileId,
      this.modelPresetId,
      required this.lastMessageSnippet,
      this.lastMessageTime,
      required this.unreadCount,
      required this.isPinned,
      required this.isMuted,
      required this.draftText,
      required this.metadata,
      required this.memoryPolicyJson,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    if (!nullToAbsent || providerProfileId != null) {
      map['provider_profile_id'] = Variable<String>(providerProfileId);
    }
    if (!nullToAbsent || modelPresetId != null) {
      map['model_preset_id'] = Variable<String>(modelPresetId);
    }
    map['last_message_snippet'] = Variable<String>(lastMessageSnippet);
    if (!nullToAbsent || lastMessageTime != null) {
      map['last_message_time'] = Variable<DateTime>(lastMessageTime);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['is_pinned'] = Variable<bool>(isPinned);
    map['is_muted'] = Variable<bool>(isMuted);
    map['draft_text'] = Variable<String>(draftText);
    map['metadata'] = Variable<String>(metadata);
    map['memory_policy_json'] = Variable<String>(memoryPolicyJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      title: Value(title),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      providerProfileId: providerProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerProfileId),
      modelPresetId: modelPresetId == null && nullToAbsent
          ? const Value.absent()
          : Value(modelPresetId),
      lastMessageSnippet: Value(lastMessageSnippet),
      lastMessageTime: lastMessageTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageTime),
      unreadCount: Value(unreadCount),
      isPinned: Value(isPinned),
      isMuted: Value(isMuted),
      draftText: Value(draftText),
      metadata: Value(metadata),
      memoryPolicyJson: Value(memoryPolicyJson),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      providerProfileId:
          serializer.fromJson<String?>(json['providerProfileId']),
      modelPresetId: serializer.fromJson<String?>(json['modelPresetId']),
      lastMessageSnippet:
          serializer.fromJson<String>(json['lastMessageSnippet']),
      lastMessageTime: serializer.fromJson<DateTime?>(json['lastMessageTime']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      isMuted: serializer.fromJson<bool>(json['isMuted']),
      draftText: serializer.fromJson<String>(json['draftText']),
      metadata: serializer.fromJson<String>(json['metadata']),
      memoryPolicyJson: serializer.fromJson<String>(json['memoryPolicyJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'contactId': serializer.toJson<String?>(contactId),
      'providerProfileId': serializer.toJson<String?>(providerProfileId),
      'modelPresetId': serializer.toJson<String?>(modelPresetId),
      'lastMessageSnippet': serializer.toJson<String>(lastMessageSnippet),
      'lastMessageTime': serializer.toJson<DateTime?>(lastMessageTime),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'isPinned': serializer.toJson<bool>(isPinned),
      'isMuted': serializer.toJson<bool>(isMuted),
      'draftText': serializer.toJson<String>(draftText),
      'metadata': serializer.toJson<String>(metadata),
      'memoryPolicyJson': serializer.toJson<String>(memoryPolicyJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Conversation copyWith(
          {String? id,
          String? title,
          Value<String?> contactId = const Value.absent(),
          Value<String?> providerProfileId = const Value.absent(),
          Value<String?> modelPresetId = const Value.absent(),
          String? lastMessageSnippet,
          Value<DateTime?> lastMessageTime = const Value.absent(),
          int? unreadCount,
          bool? isPinned,
          bool? isMuted,
          String? draftText,
          String? metadata,
          String? memoryPolicyJson,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Conversation(
        id: id ?? this.id,
        title: title ?? this.title,
        contactId: contactId.present ? contactId.value : this.contactId,
        providerProfileId: providerProfileId.present
            ? providerProfileId.value
            : this.providerProfileId,
        modelPresetId:
            modelPresetId.present ? modelPresetId.value : this.modelPresetId,
        lastMessageSnippet: lastMessageSnippet ?? this.lastMessageSnippet,
        lastMessageTime: lastMessageTime.present
            ? lastMessageTime.value
            : this.lastMessageTime,
        unreadCount: unreadCount ?? this.unreadCount,
        isPinned: isPinned ?? this.isPinned,
        isMuted: isMuted ?? this.isMuted,
        draftText: draftText ?? this.draftText,
        metadata: metadata ?? this.metadata,
        memoryPolicyJson: memoryPolicyJson ?? this.memoryPolicyJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Conversation copyWithCompanion(ConversationsCompanion data) {
    return Conversation(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      providerProfileId: data.providerProfileId.present
          ? data.providerProfileId.value
          : this.providerProfileId,
      modelPresetId: data.modelPresetId.present
          ? data.modelPresetId.value
          : this.modelPresetId,
      lastMessageSnippet: data.lastMessageSnippet.present
          ? data.lastMessageSnippet.value
          : this.lastMessageSnippet,
      lastMessageTime: data.lastMessageTime.present
          ? data.lastMessageTime.value
          : this.lastMessageTime,
      unreadCount:
          data.unreadCount.present ? data.unreadCount.value : this.unreadCount,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      isMuted: data.isMuted.present ? data.isMuted.value : this.isMuted,
      draftText: data.draftText.present ? data.draftText.value : this.draftText,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      memoryPolicyJson: data.memoryPolicyJson.present
          ? data.memoryPolicyJson.value
          : this.memoryPolicyJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('contactId: $contactId, ')
          ..write('providerProfileId: $providerProfileId, ')
          ..write('modelPresetId: $modelPresetId, ')
          ..write('lastMessageSnippet: $lastMessageSnippet, ')
          ..write('lastMessageTime: $lastMessageTime, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isPinned: $isPinned, ')
          ..write('isMuted: $isMuted, ')
          ..write('draftText: $draftText, ')
          ..write('metadata: $metadata, ')
          ..write('memoryPolicyJson: $memoryPolicyJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      contactId,
      providerProfileId,
      modelPresetId,
      lastMessageSnippet,
      lastMessageTime,
      unreadCount,
      isPinned,
      isMuted,
      draftText,
      metadata,
      memoryPolicyJson,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.title == this.title &&
          other.contactId == this.contactId &&
          other.providerProfileId == this.providerProfileId &&
          other.modelPresetId == this.modelPresetId &&
          other.lastMessageSnippet == this.lastMessageSnippet &&
          other.lastMessageTime == this.lastMessageTime &&
          other.unreadCount == this.unreadCount &&
          other.isPinned == this.isPinned &&
          other.isMuted == this.isMuted &&
          other.draftText == this.draftText &&
          other.metadata == this.metadata &&
          other.memoryPolicyJson == this.memoryPolicyJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> contactId;
  final Value<String?> providerProfileId;
  final Value<String?> modelPresetId;
  final Value<String> lastMessageSnippet;
  final Value<DateTime?> lastMessageTime;
  final Value<int> unreadCount;
  final Value<bool> isPinned;
  final Value<bool> isMuted;
  final Value<String> draftText;
  final Value<String> metadata;
  final Value<String> memoryPolicyJson;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.contactId = const Value.absent(),
    this.providerProfileId = const Value.absent(),
    this.modelPresetId = const Value.absent(),
    this.lastMessageSnippet = const Value.absent(),
    this.lastMessageTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isMuted = const Value.absent(),
    this.draftText = const Value.absent(),
    this.metadata = const Value.absent(),
    this.memoryPolicyJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConversationsCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    this.contactId = const Value.absent(),
    this.providerProfileId = const Value.absent(),
    this.modelPresetId = const Value.absent(),
    this.lastMessageSnippet = const Value.absent(),
    this.lastMessageTime = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.isMuted = const Value.absent(),
    this.draftText = const Value.absent(),
    this.metadata = const Value.absent(),
    this.memoryPolicyJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Conversation> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? contactId,
    Expression<String>? providerProfileId,
    Expression<String>? modelPresetId,
    Expression<String>? lastMessageSnippet,
    Expression<DateTime>? lastMessageTime,
    Expression<int>? unreadCount,
    Expression<bool>? isPinned,
    Expression<bool>? isMuted,
    Expression<String>? draftText,
    Expression<String>? metadata,
    Expression<String>? memoryPolicyJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (contactId != null) 'contact_id': contactId,
      if (providerProfileId != null) 'provider_profile_id': providerProfileId,
      if (modelPresetId != null) 'model_preset_id': modelPresetId,
      if (lastMessageSnippet != null)
        'last_message_snippet': lastMessageSnippet,
      if (lastMessageTime != null) 'last_message_time': lastMessageTime,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (isPinned != null) 'is_pinned': isPinned,
      if (isMuted != null) 'is_muted': isMuted,
      if (draftText != null) 'draft_text': draftText,
      if (metadata != null) 'metadata': metadata,
      if (memoryPolicyJson != null) 'memory_policy_json': memoryPolicyJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConversationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? contactId,
      Value<String?>? providerProfileId,
      Value<String?>? modelPresetId,
      Value<String>? lastMessageSnippet,
      Value<DateTime?>? lastMessageTime,
      Value<int>? unreadCount,
      Value<bool>? isPinned,
      Value<bool>? isMuted,
      Value<String>? draftText,
      Value<String>? metadata,
      Value<String>? memoryPolicyJson,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ConversationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      contactId: contactId ?? this.contactId,
      providerProfileId: providerProfileId ?? this.providerProfileId,
      modelPresetId: modelPresetId ?? this.modelPresetId,
      lastMessageSnippet: lastMessageSnippet ?? this.lastMessageSnippet,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isPinned: isPinned ?? this.isPinned,
      isMuted: isMuted ?? this.isMuted,
      draftText: draftText ?? this.draftText,
      metadata: metadata ?? this.metadata,
      memoryPolicyJson: memoryPolicyJson ?? this.memoryPolicyJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (providerProfileId.present) {
      map['provider_profile_id'] = Variable<String>(providerProfileId.value);
    }
    if (modelPresetId.present) {
      map['model_preset_id'] = Variable<String>(modelPresetId.value);
    }
    if (lastMessageSnippet.present) {
      map['last_message_snippet'] = Variable<String>(lastMessageSnippet.value);
    }
    if (lastMessageTime.present) {
      map['last_message_time'] = Variable<DateTime>(lastMessageTime.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (isMuted.present) {
      map['is_muted'] = Variable<bool>(isMuted.value);
    }
    if (draftText.present) {
      map['draft_text'] = Variable<String>(draftText.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (memoryPolicyJson.present) {
      map['memory_policy_json'] = Variable<String>(memoryPolicyJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('contactId: $contactId, ')
          ..write('providerProfileId: $providerProfileId, ')
          ..write('modelPresetId: $modelPresetId, ')
          ..write('lastMessageSnippet: $lastMessageSnippet, ')
          ..write('lastMessageTime: $lastMessageTime, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('isPinned: $isPinned, ')
          ..write('isMuted: $isMuted, ')
          ..write('draftText: $draftText, ')
          ..write('metadata: $metadata, ')
          ..write('memoryPolicyJson: $memoryPolicyJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ParticipantsTable extends Participants
    with TableInfo<$ParticipantsTable, Participant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES conversations (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('member'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, conversationId, contactId, role, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'participants';
  @override
  VerificationContext validateIntegrity(Insertable<Participant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Participant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Participant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      conversationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conversation_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ParticipantsTable createAlias(String alias) {
    return $ParticipantsTable(attachedDatabase, alias);
  }
}

class Participant extends DataClass implements Insertable<Participant> {
  final int id;
  final String conversationId;
  final String contactId;
  final String role;
  final DateTime createdAt;
  const Participant(
      {required this.id,
      required this.conversationId,
      required this.contactId,
      required this.role,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['contact_id'] = Variable<String>(contactId);
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ParticipantsCompanion toCompanion(bool nullToAbsent) {
    return ParticipantsCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      contactId: Value(contactId),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory Participant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Participant(
      id: serializer.fromJson<int>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      contactId: serializer.fromJson<String>(json['contactId']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'contactId': serializer.toJson<String>(contactId),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Participant copyWith(
          {int? id,
          String? conversationId,
          String? contactId,
          String? role,
          DateTime? createdAt}) =>
      Participant(
        id: id ?? this.id,
        conversationId: conversationId ?? this.conversationId,
        contactId: contactId ?? this.contactId,
        role: role ?? this.role,
        createdAt: createdAt ?? this.createdAt,
      );
  Participant copyWithCompanion(ParticipantsCompanion data) {
    return Participant(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Participant(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('contactId: $contactId, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, conversationId, contactId, role, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Participant &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.contactId == this.contactId &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class ParticipantsCompanion extends UpdateCompanion<Participant> {
  final Value<int> id;
  final Value<String> conversationId;
  final Value<String> contactId;
  final Value<String> role;
  final Value<DateTime> createdAt;
  const ParticipantsCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required String conversationId,
    required String contactId,
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : conversationId = Value(conversationId),
        contactId = Value(contactId);
  static Insertable<Participant> custom({
    Expression<int>? id,
    Expression<String>? conversationId,
    Expression<String>? contactId,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (contactId != null) 'contact_id': contactId,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ParticipantsCompanion copyWith(
      {Value<int>? id,
      Value<String>? conversationId,
      Value<String>? contactId,
      Value<String>? role,
      Value<DateTime>? createdAt}) {
    return ParticipantsCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      contactId: contactId ?? this.contactId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('contactId: $contactId, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageIdentifierMeta =
      const VerificationMeta('messageIdentifier');
  @override
  late final GeneratedColumn<String> messageIdentifier =
      GeneratedColumn<String>('message_identifier', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
      'conversation_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES conversations (id)'));
  static const VerificationMeta _senderTypeMeta =
      const VerificationMeta('senderType');
  @override
  late final GeneratedColumn<String> senderType = GeneratedColumn<String>(
      'sender_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('assistant'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentSearchTermsMeta =
      const VerificationMeta('contentSearchTerms');
  @override
  late final GeneratedColumn<String> contentSearchTerms =
      GeneratedColumn<String>('content_search_terms', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
      'format', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('text'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('sent'));
  static const VerificationMeta _tokenCountMeta =
      const VerificationMeta('tokenCount');
  @override
  late final GeneratedColumn<int> tokenCount = GeneratedColumn<int>(
      'token_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _parentIdentifierMeta =
      const VerificationMeta('parentIdentifier');
  @override
  late final GeneratedColumn<String> parentIdentifier = GeneratedColumn<String>(
      'parent_identifier', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _variantGroupMeta =
      const VerificationMeta('variantGroup');
  @override
  late final GeneratedColumn<int> variantGroup = GeneratedColumn<int>(
      'variant_group', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isVisibleMeta =
      const VerificationMeta('isVisible');
  @override
  late final GeneratedColumn<bool> isVisible = GeneratedColumn<bool>(
      'is_visible', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_visible" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        messageIdentifier,
        conversationId,
        senderType,
        role,
        content,
        contentSearchTerms,
        format,
        status,
        tokenCount,
        parentIdentifier,
        variantGroup,
        isVisible,
        metadata,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_identifier')) {
      context.handle(
          _messageIdentifierMeta,
          messageIdentifier.isAcceptableOrUnknown(
              data['message_identifier']!, _messageIdentifierMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('sender_type')) {
      context.handle(
          _senderTypeMeta,
          senderType.isAcceptableOrUnknown(
              data['sender_type']!, _senderTypeMeta));
    } else if (isInserting) {
      context.missing(_senderTypeMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('content_search_terms')) {
      context.handle(
          _contentSearchTermsMeta,
          contentSearchTerms.isAcceptableOrUnknown(
              data['content_search_terms']!, _contentSearchTermsMeta));
    }
    if (data.containsKey('format')) {
      context.handle(_formatMeta,
          format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('token_count')) {
      context.handle(
          _tokenCountMeta,
          tokenCount.isAcceptableOrUnknown(
              data['token_count']!, _tokenCountMeta));
    }
    if (data.containsKey('parent_identifier')) {
      context.handle(
          _parentIdentifierMeta,
          parentIdentifier.isAcceptableOrUnknown(
              data['parent_identifier']!, _parentIdentifierMeta));
    }
    if (data.containsKey('variant_group')) {
      context.handle(
          _variantGroupMeta,
          variantGroup.isAcceptableOrUnknown(
              data['variant_group']!, _variantGroupMeta));
    }
    if (data.containsKey('is_visible')) {
      context.handle(_isVisibleMeta,
          isVisible.isAcceptableOrUnknown(data['is_visible']!, _isVisibleMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messageIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}message_identifier']),
      conversationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}conversation_id'])!,
      senderType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sender_type'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      contentSearchTerms: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}content_search_terms']),
      format: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      tokenCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}token_count']),
      parentIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}parent_identifier']),
      variantGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}variant_group']),
      isVisible: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_visible'])!,
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final String? messageIdentifier;
  final String conversationId;
  final String senderType;
  final String role;
  final String content;
  final String? contentSearchTerms;
  final String format;
  final String status;
  final int? tokenCount;
  final String? parentIdentifier;
  final int? variantGroup;
  final bool isVisible;
  final String? metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Message(
      {required this.id,
      this.messageIdentifier,
      required this.conversationId,
      required this.senderType,
      required this.role,
      required this.content,
      this.contentSearchTerms,
      required this.format,
      required this.status,
      this.tokenCount,
      this.parentIdentifier,
      this.variantGroup,
      required this.isVisible,
      this.metadata,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || messageIdentifier != null) {
      map['message_identifier'] = Variable<String>(messageIdentifier);
    }
    map['conversation_id'] = Variable<String>(conversationId);
    map['sender_type'] = Variable<String>(senderType);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || contentSearchTerms != null) {
      map['content_search_terms'] = Variable<String>(contentSearchTerms);
    }
    map['format'] = Variable<String>(format);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || tokenCount != null) {
      map['token_count'] = Variable<int>(tokenCount);
    }
    if (!nullToAbsent || parentIdentifier != null) {
      map['parent_identifier'] = Variable<String>(parentIdentifier);
    }
    if (!nullToAbsent || variantGroup != null) {
      map['variant_group'] = Variable<int>(variantGroup);
    }
    map['is_visible'] = Variable<bool>(isVisible);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      messageIdentifier: messageIdentifier == null && nullToAbsent
          ? const Value.absent()
          : Value(messageIdentifier),
      conversationId: Value(conversationId),
      senderType: Value(senderType),
      role: Value(role),
      content: Value(content),
      contentSearchTerms: contentSearchTerms == null && nullToAbsent
          ? const Value.absent()
          : Value(contentSearchTerms),
      format: Value(format),
      status: Value(status),
      tokenCount: tokenCount == null && nullToAbsent
          ? const Value.absent()
          : Value(tokenCount),
      parentIdentifier: parentIdentifier == null && nullToAbsent
          ? const Value.absent()
          : Value(parentIdentifier),
      variantGroup: variantGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(variantGroup),
      isVisible: Value(isVisible),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      messageIdentifier:
          serializer.fromJson<String?>(json['messageIdentifier']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      senderType: serializer.fromJson<String>(json['senderType']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      contentSearchTerms:
          serializer.fromJson<String?>(json['contentSearchTerms']),
      format: serializer.fromJson<String>(json['format']),
      status: serializer.fromJson<String>(json['status']),
      tokenCount: serializer.fromJson<int?>(json['tokenCount']),
      parentIdentifier: serializer.fromJson<String?>(json['parentIdentifier']),
      variantGroup: serializer.fromJson<int?>(json['variantGroup']),
      isVisible: serializer.fromJson<bool>(json['isVisible']),
      metadata: serializer.fromJson<String?>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageIdentifier': serializer.toJson<String?>(messageIdentifier),
      'conversationId': serializer.toJson<String>(conversationId),
      'senderType': serializer.toJson<String>(senderType),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'contentSearchTerms': serializer.toJson<String?>(contentSearchTerms),
      'format': serializer.toJson<String>(format),
      'status': serializer.toJson<String>(status),
      'tokenCount': serializer.toJson<int?>(tokenCount),
      'parentIdentifier': serializer.toJson<String?>(parentIdentifier),
      'variantGroup': serializer.toJson<int?>(variantGroup),
      'isVisible': serializer.toJson<bool>(isVisible),
      'metadata': serializer.toJson<String?>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Message copyWith(
          {int? id,
          Value<String?> messageIdentifier = const Value.absent(),
          String? conversationId,
          String? senderType,
          String? role,
          String? content,
          Value<String?> contentSearchTerms = const Value.absent(),
          String? format,
          String? status,
          Value<int?> tokenCount = const Value.absent(),
          Value<String?> parentIdentifier = const Value.absent(),
          Value<int?> variantGroup = const Value.absent(),
          bool? isVisible,
          Value<String?> metadata = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Message(
        id: id ?? this.id,
        messageIdentifier: messageIdentifier.present
            ? messageIdentifier.value
            : this.messageIdentifier,
        conversationId: conversationId ?? this.conversationId,
        senderType: senderType ?? this.senderType,
        role: role ?? this.role,
        content: content ?? this.content,
        contentSearchTerms: contentSearchTerms.present
            ? contentSearchTerms.value
            : this.contentSearchTerms,
        format: format ?? this.format,
        status: status ?? this.status,
        tokenCount: tokenCount.present ? tokenCount.value : this.tokenCount,
        parentIdentifier: parentIdentifier.present
            ? parentIdentifier.value
            : this.parentIdentifier,
        variantGroup:
            variantGroup.present ? variantGroup.value : this.variantGroup,
        isVisible: isVisible ?? this.isVisible,
        metadata: metadata.present ? metadata.value : this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      messageIdentifier: data.messageIdentifier.present
          ? data.messageIdentifier.value
          : this.messageIdentifier,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      senderType:
          data.senderType.present ? data.senderType.value : this.senderType,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      contentSearchTerms: data.contentSearchTerms.present
          ? data.contentSearchTerms.value
          : this.contentSearchTerms,
      format: data.format.present ? data.format.value : this.format,
      status: data.status.present ? data.status.value : this.status,
      tokenCount:
          data.tokenCount.present ? data.tokenCount.value : this.tokenCount,
      parentIdentifier: data.parentIdentifier.present
          ? data.parentIdentifier.value
          : this.parentIdentifier,
      variantGroup: data.variantGroup.present
          ? data.variantGroup.value
          : this.variantGroup,
      isVisible: data.isVisible.present ? data.isVisible.value : this.isVisible,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('messageIdentifier: $messageIdentifier, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderType: $senderType, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('contentSearchTerms: $contentSearchTerms, ')
          ..write('format: $format, ')
          ..write('status: $status, ')
          ..write('tokenCount: $tokenCount, ')
          ..write('parentIdentifier: $parentIdentifier, ')
          ..write('variantGroup: $variantGroup, ')
          ..write('isVisible: $isVisible, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      messageIdentifier,
      conversationId,
      senderType,
      role,
      content,
      contentSearchTerms,
      format,
      status,
      tokenCount,
      parentIdentifier,
      variantGroup,
      isVisible,
      metadata,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.messageIdentifier == this.messageIdentifier &&
          other.conversationId == this.conversationId &&
          other.senderType == this.senderType &&
          other.role == this.role &&
          other.content == this.content &&
          other.contentSearchTerms == this.contentSearchTerms &&
          other.format == this.format &&
          other.status == this.status &&
          other.tokenCount == this.tokenCount &&
          other.parentIdentifier == this.parentIdentifier &&
          other.variantGroup == this.variantGroup &&
          other.isVisible == this.isVisible &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<String?> messageIdentifier;
  final Value<String> conversationId;
  final Value<String> senderType;
  final Value<String> role;
  final Value<String> content;
  final Value<String?> contentSearchTerms;
  final Value<String> format;
  final Value<String> status;
  final Value<int?> tokenCount;
  final Value<String?> parentIdentifier;
  final Value<int?> variantGroup;
  final Value<bool> isVisible;
  final Value<String?> metadata;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.messageIdentifier = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.senderType = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.contentSearchTerms = const Value.absent(),
    this.format = const Value.absent(),
    this.status = const Value.absent(),
    this.tokenCount = const Value.absent(),
    this.parentIdentifier = const Value.absent(),
    this.variantGroup = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    this.messageIdentifier = const Value.absent(),
    required String conversationId,
    required String senderType,
    this.role = const Value.absent(),
    required String content,
    this.contentSearchTerms = const Value.absent(),
    this.format = const Value.absent(),
    this.status = const Value.absent(),
    this.tokenCount = const Value.absent(),
    this.parentIdentifier = const Value.absent(),
    this.variantGroup = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : conversationId = Value(conversationId),
        senderType = Value(senderType),
        content = Value(content);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<String>? messageIdentifier,
    Expression<String>? conversationId,
    Expression<String>? senderType,
    Expression<String>? role,
    Expression<String>? content,
    Expression<String>? contentSearchTerms,
    Expression<String>? format,
    Expression<String>? status,
    Expression<int>? tokenCount,
    Expression<String>? parentIdentifier,
    Expression<int>? variantGroup,
    Expression<bool>? isVisible,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageIdentifier != null) 'message_identifier': messageIdentifier,
      if (conversationId != null) 'conversation_id': conversationId,
      if (senderType != null) 'sender_type': senderType,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (contentSearchTerms != null)
        'content_search_terms': contentSearchTerms,
      if (format != null) 'format': format,
      if (status != null) 'status': status,
      if (tokenCount != null) 'token_count': tokenCount,
      if (parentIdentifier != null) 'parent_identifier': parentIdentifier,
      if (variantGroup != null) 'variant_group': variantGroup,
      if (isVisible != null) 'is_visible': isVisible,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<String?>? messageIdentifier,
      Value<String>? conversationId,
      Value<String>? senderType,
      Value<String>? role,
      Value<String>? content,
      Value<String?>? contentSearchTerms,
      Value<String>? format,
      Value<String>? status,
      Value<int?>? tokenCount,
      Value<String?>? parentIdentifier,
      Value<int?>? variantGroup,
      Value<bool>? isVisible,
      Value<String?>? metadata,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return MessagesCompanion(
      id: id ?? this.id,
      messageIdentifier: messageIdentifier ?? this.messageIdentifier,
      conversationId: conversationId ?? this.conversationId,
      senderType: senderType ?? this.senderType,
      role: role ?? this.role,
      content: content ?? this.content,
      contentSearchTerms: contentSearchTerms ?? this.contentSearchTerms,
      format: format ?? this.format,
      status: status ?? this.status,
      tokenCount: tokenCount ?? this.tokenCount,
      parentIdentifier: parentIdentifier ?? this.parentIdentifier,
      variantGroup: variantGroup ?? this.variantGroup,
      isVisible: isVisible ?? this.isVisible,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageIdentifier.present) {
      map['message_identifier'] = Variable<String>(messageIdentifier.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (senderType.present) {
      map['sender_type'] = Variable<String>(senderType.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (contentSearchTerms.present) {
      map['content_search_terms'] = Variable<String>(contentSearchTerms.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (tokenCount.present) {
      map['token_count'] = Variable<int>(tokenCount.value);
    }
    if (parentIdentifier.present) {
      map['parent_identifier'] = Variable<String>(parentIdentifier.value);
    }
    if (variantGroup.present) {
      map['variant_group'] = Variable<int>(variantGroup.value);
    }
    if (isVisible.present) {
      map['is_visible'] = Variable<bool>(isVisible.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('messageIdentifier: $messageIdentifier, ')
          ..write('conversationId: $conversationId, ')
          ..write('senderType: $senderType, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('contentSearchTerms: $contentSearchTerms, ')
          ..write('format: $format, ')
          ..write('status: $status, ')
          ..write('tokenCount: $tokenCount, ')
          ..write('parentIdentifier: $parentIdentifier, ')
          ..write('variantGroup: $variantGroup, ')
          ..write('isVisible: $isVisible, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $GenerationsTable extends Generations
    with TableInfo<$GenerationsTable, Generation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenerationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
      'message_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES messages (id)'));
  static const VerificationMeta _parentIdentifierMeta =
      const VerificationMeta('parentIdentifier');
  @override
  late final GeneratedColumn<String> parentIdentifier = GeneratedColumn<String>(
      'parent_identifier', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _variantIndexMeta =
      const VerificationMeta('variantIndex');
  @override
  late final GeneratedColumn<int> variantIndex = GeneratedColumn<int>(
      'variant_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paramsSnapshotMeta =
      const VerificationMeta('paramsSnapshot');
  @override
  late final GeneratedColumn<String> paramsSnapshot = GeneratedColumn<String>(
      'params_snapshot', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        messageId,
        parentIdentifier,
        variantIndex,
        content,
        paramsSnapshot,
        score,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'generations';
  @override
  VerificationContext validateIntegrity(Insertable<Generation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('parent_identifier')) {
      context.handle(
          _parentIdentifierMeta,
          parentIdentifier.isAcceptableOrUnknown(
              data['parent_identifier']!, _parentIdentifierMeta));
    }
    if (data.containsKey('variant_index')) {
      context.handle(
          _variantIndexMeta,
          variantIndex.isAcceptableOrUnknown(
              data['variant_index']!, _variantIndexMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('params_snapshot')) {
      context.handle(
          _paramsSnapshotMeta,
          paramsSnapshot.isAcceptableOrUnknown(
              data['params_snapshot']!, _paramsSnapshotMeta));
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Generation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Generation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_id'])!,
      parentIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}parent_identifier']),
      variantIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}variant_index'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      paramsSnapshot: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}params_snapshot'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $GenerationsTable createAlias(String alias) {
    return $GenerationsTable(attachedDatabase, alias);
  }
}

class Generation extends DataClass implements Insertable<Generation> {
  final int id;
  final int messageId;
  final String? parentIdentifier;
  final int variantIndex;
  final String content;
  final String paramsSnapshot;
  final double? score;
  final DateTime createdAt;
  const Generation(
      {required this.id,
      required this.messageId,
      this.parentIdentifier,
      required this.variantIndex,
      required this.content,
      required this.paramsSnapshot,
      this.score,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<int>(messageId);
    if (!nullToAbsent || parentIdentifier != null) {
      map['parent_identifier'] = Variable<String>(parentIdentifier);
    }
    map['variant_index'] = Variable<int>(variantIndex);
    map['content'] = Variable<String>(content);
    map['params_snapshot'] = Variable<String>(paramsSnapshot);
    if (!nullToAbsent || score != null) {
      map['score'] = Variable<double>(score);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GenerationsCompanion toCompanion(bool nullToAbsent) {
    return GenerationsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      parentIdentifier: parentIdentifier == null && nullToAbsent
          ? const Value.absent()
          : Value(parentIdentifier),
      variantIndex: Value(variantIndex),
      content: Value(content),
      paramsSnapshot: Value(paramsSnapshot),
      score:
          score == null && nullToAbsent ? const Value.absent() : Value(score),
      createdAt: Value(createdAt),
    );
  }

  factory Generation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Generation(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<int>(json['messageId']),
      parentIdentifier: serializer.fromJson<String?>(json['parentIdentifier']),
      variantIndex: serializer.fromJson<int>(json['variantIndex']),
      content: serializer.fromJson<String>(json['content']),
      paramsSnapshot: serializer.fromJson<String>(json['paramsSnapshot']),
      score: serializer.fromJson<double?>(json['score']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<int>(messageId),
      'parentIdentifier': serializer.toJson<String?>(parentIdentifier),
      'variantIndex': serializer.toJson<int>(variantIndex),
      'content': serializer.toJson<String>(content),
      'paramsSnapshot': serializer.toJson<String>(paramsSnapshot),
      'score': serializer.toJson<double?>(score),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Generation copyWith(
          {int? id,
          int? messageId,
          Value<String?> parentIdentifier = const Value.absent(),
          int? variantIndex,
          String? content,
          String? paramsSnapshot,
          Value<double?> score = const Value.absent(),
          DateTime? createdAt}) =>
      Generation(
        id: id ?? this.id,
        messageId: messageId ?? this.messageId,
        parentIdentifier: parentIdentifier.present
            ? parentIdentifier.value
            : this.parentIdentifier,
        variantIndex: variantIndex ?? this.variantIndex,
        content: content ?? this.content,
        paramsSnapshot: paramsSnapshot ?? this.paramsSnapshot,
        score: score.present ? score.value : this.score,
        createdAt: createdAt ?? this.createdAt,
      );
  Generation copyWithCompanion(GenerationsCompanion data) {
    return Generation(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      parentIdentifier: data.parentIdentifier.present
          ? data.parentIdentifier.value
          : this.parentIdentifier,
      variantIndex: data.variantIndex.present
          ? data.variantIndex.value
          : this.variantIndex,
      content: data.content.present ? data.content.value : this.content,
      paramsSnapshot: data.paramsSnapshot.present
          ? data.paramsSnapshot.value
          : this.paramsSnapshot,
      score: data.score.present ? data.score.value : this.score,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Generation(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('parentIdentifier: $parentIdentifier, ')
          ..write('variantIndex: $variantIndex, ')
          ..write('content: $content, ')
          ..write('paramsSnapshot: $paramsSnapshot, ')
          ..write('score: $score, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, parentIdentifier, variantIndex,
      content, paramsSnapshot, score, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Generation &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.parentIdentifier == this.parentIdentifier &&
          other.variantIndex == this.variantIndex &&
          other.content == this.content &&
          other.paramsSnapshot == this.paramsSnapshot &&
          other.score == this.score &&
          other.createdAt == this.createdAt);
}

class GenerationsCompanion extends UpdateCompanion<Generation> {
  final Value<int> id;
  final Value<int> messageId;
  final Value<String?> parentIdentifier;
  final Value<int> variantIndex;
  final Value<String> content;
  final Value<String> paramsSnapshot;
  final Value<double?> score;
  final Value<DateTime> createdAt;
  const GenerationsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.parentIdentifier = const Value.absent(),
    this.variantIndex = const Value.absent(),
    this.content = const Value.absent(),
    this.paramsSnapshot = const Value.absent(),
    this.score = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  GenerationsCompanion.insert({
    this.id = const Value.absent(),
    required int messageId,
    this.parentIdentifier = const Value.absent(),
    this.variantIndex = const Value.absent(),
    required String content,
    this.paramsSnapshot = const Value.absent(),
    this.score = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : messageId = Value(messageId),
        content = Value(content);
  static Insertable<Generation> custom({
    Expression<int>? id,
    Expression<int>? messageId,
    Expression<String>? parentIdentifier,
    Expression<int>? variantIndex,
    Expression<String>? content,
    Expression<String>? paramsSnapshot,
    Expression<double>? score,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (parentIdentifier != null) 'parent_identifier': parentIdentifier,
      if (variantIndex != null) 'variant_index': variantIndex,
      if (content != null) 'content': content,
      if (paramsSnapshot != null) 'params_snapshot': paramsSnapshot,
      if (score != null) 'score': score,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  GenerationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? messageId,
      Value<String?>? parentIdentifier,
      Value<int>? variantIndex,
      Value<String>? content,
      Value<String>? paramsSnapshot,
      Value<double?>? score,
      Value<DateTime>? createdAt}) {
    return GenerationsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      parentIdentifier: parentIdentifier ?? this.parentIdentifier,
      variantIndex: variantIndex ?? this.variantIndex,
      content: content ?? this.content,
      paramsSnapshot: paramsSnapshot ?? this.paramsSnapshot,
      score: score ?? this.score,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (parentIdentifier.present) {
      map['parent_identifier'] = Variable<String>(parentIdentifier.value);
    }
    if (variantIndex.present) {
      map['variant_index'] = Variable<int>(variantIndex.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (paramsSnapshot.present) {
      map['params_snapshot'] = Variable<String>(paramsSnapshot.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenerationsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('parentIdentifier: $parentIdentifier, ')
          ..write('variantIndex: $variantIndex, ')
          ..write('content: $content, ')
          ..write('paramsSnapshot: $paramsSnapshot, ')
          ..write('score: $score, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MemoryEntriesTable extends MemoryEntries
    with TableInfo<$MemoryEntriesTable, MemoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
      'scope', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('global'));
  static const VerificationMeta _conversationIdMeta =
      const VerificationMeta('conversationId');
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
      'conversation_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES conversations (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _triggersMeta =
      const VerificationMeta('triggers');
  @override
  late final GeneratedColumn<String> triggers = GeneratedColumn<String>(
      'triggers', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
      'pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("pinned" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUsedAtMeta =
      const VerificationMeta('lastUsedAt');
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
      'last_used_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        scope,
        conversationId,
        type,
        content,
        triggers,
        weight,
        pinned,
        lastUsedAt,
        metadata,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'memory_entries';
  @override
  VerificationContext validateIntegrity(Insertable<MemoryEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scope')) {
      context.handle(
          _scopeMeta, scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
          _conversationIdMeta,
          conversationId.isAcceptableOrUnknown(
              data['conversation_id']!, _conversationIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('triggers')) {
      context.handle(_triggersMeta,
          triggers.isAcceptableOrUnknown(data['triggers']!, _triggersMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('pinned')) {
      context.handle(_pinnedMeta,
          pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta));
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
          _lastUsedAtMeta,
          lastUsedAt.isAcceptableOrUnknown(
              data['last_used_at']!, _lastUsedAtMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      scope: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scope'])!,
      conversationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conversation_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      triggers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}triggers'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      pinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}pinned'])!,
      lastUsedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_used_at']),
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $MemoryEntriesTable createAlias(String alias) {
    return $MemoryEntriesTable(attachedDatabase, alias);
  }
}

class MemoryEntry extends DataClass implements Insertable<MemoryEntry> {
  final int id;
  final String scope;
  final String? conversationId;
  final String type;
  final String content;
  final String triggers;
  final double weight;
  final bool pinned;
  final DateTime? lastUsedAt;
  final String metadata;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const MemoryEntry(
      {required this.id,
      required this.scope,
      this.conversationId,
      required this.type,
      required this.content,
      required this.triggers,
      required this.weight,
      required this.pinned,
      this.lastUsedAt,
      required this.metadata,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scope'] = Variable<String>(scope);
    if (!nullToAbsent || conversationId != null) {
      map['conversation_id'] = Variable<String>(conversationId);
    }
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['triggers'] = Variable<String>(triggers);
    map['weight'] = Variable<double>(weight);
    map['pinned'] = Variable<bool>(pinned);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    map['metadata'] = Variable<String>(metadata);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MemoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return MemoryEntriesCompanion(
      id: Value(id),
      scope: Value(scope),
      conversationId: conversationId == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationId),
      type: Value(type),
      content: Value(content),
      triggers: Value(triggers),
      weight: Value(weight),
      pinned: Value(pinned),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
      metadata: Value(metadata),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory MemoryEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryEntry(
      id: serializer.fromJson<int>(json['id']),
      scope: serializer.fromJson<String>(json['scope']),
      conversationId: serializer.fromJson<String?>(json['conversationId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      triggers: serializer.fromJson<String>(json['triggers']),
      weight: serializer.fromJson<double>(json['weight']),
      pinned: serializer.fromJson<bool>(json['pinned']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
      metadata: serializer.fromJson<String>(json['metadata']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scope': serializer.toJson<String>(scope),
      'conversationId': serializer.toJson<String?>(conversationId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'triggers': serializer.toJson<String>(triggers),
      'weight': serializer.toJson<double>(weight),
      'pinned': serializer.toJson<bool>(pinned),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
      'metadata': serializer.toJson<String>(metadata),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  MemoryEntry copyWith(
          {int? id,
          String? scope,
          Value<String?> conversationId = const Value.absent(),
          String? type,
          String? content,
          String? triggers,
          double? weight,
          bool? pinned,
          Value<DateTime?> lastUsedAt = const Value.absent(),
          String? metadata,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      MemoryEntry(
        id: id ?? this.id,
        scope: scope ?? this.scope,
        conversationId:
            conversationId.present ? conversationId.value : this.conversationId,
        type: type ?? this.type,
        content: content ?? this.content,
        triggers: triggers ?? this.triggers,
        weight: weight ?? this.weight,
        pinned: pinned ?? this.pinned,
        lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  MemoryEntry copyWithCompanion(MemoryEntriesCompanion data) {
    return MemoryEntry(
      id: data.id.present ? data.id.value : this.id,
      scope: data.scope.present ? data.scope.value : this.scope,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      triggers: data.triggers.present ? data.triggers.value : this.triggers,
      weight: data.weight.present ? data.weight.value : this.weight,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
      lastUsedAt:
          data.lastUsedAt.present ? data.lastUsedAt.value : this.lastUsedAt,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemoryEntry(')
          ..write('id: $id, ')
          ..write('scope: $scope, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('triggers: $triggers, ')
          ..write('weight: $weight, ')
          ..write('pinned: $pinned, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, scope, conversationId, type, content,
      triggers, weight, pinned, lastUsedAt, metadata, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryEntry &&
          other.id == this.id &&
          other.scope == this.scope &&
          other.conversationId == this.conversationId &&
          other.type == this.type &&
          other.content == this.content &&
          other.triggers == this.triggers &&
          other.weight == this.weight &&
          other.pinned == this.pinned &&
          other.lastUsedAt == this.lastUsedAt &&
          other.metadata == this.metadata &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MemoryEntriesCompanion extends UpdateCompanion<MemoryEntry> {
  final Value<int> id;
  final Value<String> scope;
  final Value<String?> conversationId;
  final Value<String> type;
  final Value<String> content;
  final Value<String> triggers;
  final Value<double> weight;
  final Value<bool> pinned;
  final Value<DateTime?> lastUsedAt;
  final Value<String> metadata;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const MemoryEntriesCompanion({
    this.id = const Value.absent(),
    this.scope = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.triggers = const Value.absent(),
    this.weight = const Value.absent(),
    this.pinned = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MemoryEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.scope = const Value.absent(),
    this.conversationId = const Value.absent(),
    required String type,
    required String content,
    this.triggers = const Value.absent(),
    this.weight = const Value.absent(),
    this.pinned = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.metadata = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : type = Value(type),
        content = Value(content);
  static Insertable<MemoryEntry> custom({
    Expression<int>? id,
    Expression<String>? scope,
    Expression<String>? conversationId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? triggers,
    Expression<double>? weight,
    Expression<bool>? pinned,
    Expression<DateTime>? lastUsedAt,
    Expression<String>? metadata,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (scope != null) 'scope': scope,
      if (conversationId != null) 'conversation_id': conversationId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (triggers != null) 'triggers': triggers,
      if (weight != null) 'weight': weight,
      if (pinned != null) 'pinned': pinned,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (metadata != null) 'metadata': metadata,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MemoryEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? scope,
      Value<String?>? conversationId,
      Value<String>? type,
      Value<String>? content,
      Value<String>? triggers,
      Value<double>? weight,
      Value<bool>? pinned,
      Value<DateTime?>? lastUsedAt,
      Value<String>? metadata,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return MemoryEntriesCompanion(
      id: id ?? this.id,
      scope: scope ?? this.scope,
      conversationId: conversationId ?? this.conversationId,
      type: type ?? this.type,
      content: content ?? this.content,
      triggers: triggers ?? this.triggers,
      weight: weight ?? this.weight,
      pinned: pinned ?? this.pinned,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (triggers.present) {
      map['triggers'] = Variable<String>(triggers.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('scope: $scope, ')
          ..write('conversationId: $conversationId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('triggers: $triggers, ')
          ..write('weight: $weight, ')
          ..write('pinned: $pinned, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('metadata: $metadata, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, Attachment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _messageIdMeta =
      const VerificationMeta('messageId');
  @override
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
      'message_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES messages (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbnailPathMeta =
      const VerificationMeta('thumbnailPath');
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
      'thumbnail_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mimeTypeMeta =
      const VerificationMeta('mimeType');
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
      'mime_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
      'size', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
      'width', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
      'height', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
      'sha256', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String> extra = GeneratedColumn<String>(
      'extra', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        messageId,
        type,
        path,
        thumbnailPath,
        mimeType,
        size,
        width,
        height,
        sha256,
        extra,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(Insertable<Attachment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('message_id')) {
      context.handle(_messageIdMeta,
          messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta));
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
          _thumbnailPathMeta,
          thumbnailPath.isAcceptableOrUnknown(
              data['thumbnail_path']!, _thumbnailPathMeta));
    }
    if (data.containsKey('mime_type')) {
      context.handle(_mimeTypeMeta,
          mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta));
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    }
    if (data.containsKey('sha256')) {
      context.handle(_sha256Meta,
          sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta));
    }
    if (data.containsKey('extra')) {
      context.handle(
          _extraMeta, extra.isAcceptableOrUnknown(data['extra']!, _extraMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attachment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attachment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      messageId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}message_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      thumbnailPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail_path']),
      mimeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mime_type']),
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size']),
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}width']),
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}height']),
      sha256: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sha256']),
      extra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class Attachment extends DataClass implements Insertable<Attachment> {
  final int id;
  final int messageId;
  final String type;
  final String path;
  final String? thumbnailPath;
  final String? mimeType;
  final int? size;
  final int? width;
  final int? height;
  final String? sha256;
  final String extra;
  final DateTime createdAt;
  const Attachment(
      {required this.id,
      required this.messageId,
      required this.type,
      required this.path,
      this.thumbnailPath,
      this.mimeType,
      this.size,
      this.width,
      this.height,
      this.sha256,
      required this.extra,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['message_id'] = Variable<int>(messageId);
    map['type'] = Variable<String>(type);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<int>(size);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    map['extra'] = Variable<String>(extra);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      messageId: Value(messageId),
      type: Value(type),
      path: Value(path),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      width:
          width == null && nullToAbsent ? const Value.absent() : Value(width),
      height:
          height == null && nullToAbsent ? const Value.absent() : Value(height),
      sha256:
          sha256 == null && nullToAbsent ? const Value.absent() : Value(sha256),
      extra: Value(extra),
      createdAt: Value(createdAt),
    );
  }

  factory Attachment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attachment(
      id: serializer.fromJson<int>(json['id']),
      messageId: serializer.fromJson<int>(json['messageId']),
      type: serializer.fromJson<String>(json['type']),
      path: serializer.fromJson<String>(json['path']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      size: serializer.fromJson<int?>(json['size']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      extra: serializer.fromJson<String>(json['extra']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'messageId': serializer.toJson<int>(messageId),
      'type': serializer.toJson<String>(type),
      'path': serializer.toJson<String>(path),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'mimeType': serializer.toJson<String?>(mimeType),
      'size': serializer.toJson<int?>(size),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'sha256': serializer.toJson<String?>(sha256),
      'extra': serializer.toJson<String>(extra),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Attachment copyWith(
          {int? id,
          int? messageId,
          String? type,
          String? path,
          Value<String?> thumbnailPath = const Value.absent(),
          Value<String?> mimeType = const Value.absent(),
          Value<int?> size = const Value.absent(),
          Value<int?> width = const Value.absent(),
          Value<int?> height = const Value.absent(),
          Value<String?> sha256 = const Value.absent(),
          String? extra,
          DateTime? createdAt}) =>
      Attachment(
        id: id ?? this.id,
        messageId: messageId ?? this.messageId,
        type: type ?? this.type,
        path: path ?? this.path,
        thumbnailPath:
            thumbnailPath.present ? thumbnailPath.value : this.thumbnailPath,
        mimeType: mimeType.present ? mimeType.value : this.mimeType,
        size: size.present ? size.value : this.size,
        width: width.present ? width.value : this.width,
        height: height.present ? height.value : this.height,
        sha256: sha256.present ? sha256.value : this.sha256,
        extra: extra ?? this.extra,
        createdAt: createdAt ?? this.createdAt,
      );
  Attachment copyWithCompanion(AttachmentsCompanion data) {
    return Attachment(
      id: data.id.present ? data.id.value : this.id,
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      type: data.type.present ? data.type.value : this.type,
      path: data.path.present ? data.path.value : this.path,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      size: data.size.present ? data.size.value : this.size,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      extra: data.extra.present ? data.extra.value : this.extra,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attachment(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('type: $type, ')
          ..write('path: $path, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sha256: $sha256, ')
          ..write('extra: $extra, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, messageId, type, path, thumbnailPath,
      mimeType, size, width, height, sha256, extra, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attachment &&
          other.id == this.id &&
          other.messageId == this.messageId &&
          other.type == this.type &&
          other.path == this.path &&
          other.thumbnailPath == this.thumbnailPath &&
          other.mimeType == this.mimeType &&
          other.size == this.size &&
          other.width == this.width &&
          other.height == this.height &&
          other.sha256 == this.sha256 &&
          other.extra == this.extra &&
          other.createdAt == this.createdAt);
}

class AttachmentsCompanion extends UpdateCompanion<Attachment> {
  final Value<int> id;
  final Value<int> messageId;
  final Value<String> type;
  final Value<String> path;
  final Value<String?> thumbnailPath;
  final Value<String?> mimeType;
  final Value<int?> size;
  final Value<int?> width;
  final Value<int?> height;
  final Value<String?> sha256;
  final Value<String> extra;
  final Value<DateTime> createdAt;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.messageId = const Value.absent(),
    this.type = const Value.absent(),
    this.path = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.size = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.extra = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required int messageId,
    required String type,
    required String path,
    this.thumbnailPath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.size = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.extra = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : messageId = Value(messageId),
        type = Value(type),
        path = Value(path);
  static Insertable<Attachment> custom({
    Expression<int>? id,
    Expression<int>? messageId,
    Expression<String>? type,
    Expression<String>? path,
    Expression<String>? thumbnailPath,
    Expression<String>? mimeType,
    Expression<int>? size,
    Expression<int>? width,
    Expression<int>? height,
    Expression<String>? sha256,
    Expression<String>? extra,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (messageId != null) 'message_id': messageId,
      if (type != null) 'type': type,
      if (path != null) 'path': path,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (mimeType != null) 'mime_type': mimeType,
      if (size != null) 'size': size,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (sha256 != null) 'sha256': sha256,
      if (extra != null) 'extra': extra,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AttachmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? messageId,
      Value<String>? type,
      Value<String>? path,
      Value<String?>? thumbnailPath,
      Value<String?>? mimeType,
      Value<int?>? size,
      Value<int?>? width,
      Value<int?>? height,
      Value<String?>? sha256,
      Value<String>? extra,
      Value<DateTime>? createdAt}) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      messageId: messageId ?? this.messageId,
      type: type ?? this.type,
      path: path ?? this.path,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      mimeType: mimeType ?? this.mimeType,
      size: size ?? this.size,
      width: width ?? this.width,
      height: height ?? this.height,
      sha256: sha256 ?? this.sha256,
      extra: extra ?? this.extra,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String>(extra.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('messageId: $messageId, ')
          ..write('type: $type, ')
          ..write('path: $path, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('size: $size, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sha256: $sha256, ')
          ..write('extra: $extra, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MomentsTable extends Moments with TableInfo<$MomentsTable, Moment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MomentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorIdMeta =
      const VerificationMeta('authorId');
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
      'author_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mediaJsonMeta =
      const VerificationMeta('mediaJson');
  @override
  late final GeneratedColumn<String> mediaJson = GeneratedColumn<String>(
      'media_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _visibilityMeta =
      const VerificationMeta('visibility');
  @override
  late final GeneratedColumn<String> visibility = GeneratedColumn<String>(
      'visibility', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('private'));
  static const VerificationMeta _allowCommentsMeta =
      const VerificationMeta('allowComments');
  @override
  late final GeneratedColumn<bool> allowComments = GeneratedColumn<bool>(
      'allow_comments', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_comments" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _likeCountMeta =
      const VerificationMeta('likeCount');
  @override
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
      'like_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _commentCountMeta =
      const VerificationMeta('commentCount');
  @override
  late final GeneratedColumn<int> commentCount = GeneratedColumn<int>(
      'comment_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        authorId,
        content,
        mediaJson,
        visibility,
        allowComments,
        likeCount,
        commentCount,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moments';
  @override
  VerificationContext validateIntegrity(Insertable<Moment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(_authorIdMeta,
          authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('media_json')) {
      context.handle(_mediaJsonMeta,
          mediaJson.isAcceptableOrUnknown(data['media_json']!, _mediaJsonMeta));
    }
    if (data.containsKey('visibility')) {
      context.handle(
          _visibilityMeta,
          visibility.isAcceptableOrUnknown(
              data['visibility']!, _visibilityMeta));
    }
    if (data.containsKey('allow_comments')) {
      context.handle(
          _allowCommentsMeta,
          allowComments.isAcceptableOrUnknown(
              data['allow_comments']!, _allowCommentsMeta));
    }
    if (data.containsKey('like_count')) {
      context.handle(_likeCountMeta,
          likeCount.isAcceptableOrUnknown(data['like_count']!, _likeCountMeta));
    }
    if (data.containsKey('comment_count')) {
      context.handle(
          _commentCountMeta,
          commentCount.isAcceptableOrUnknown(
              data['comment_count']!, _commentCountMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Moment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Moment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      authorId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author_id']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      mediaJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_json'])!,
      visibility: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}visibility'])!,
      allowComments: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_comments'])!,
      likeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}like_count'])!,
      commentCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}comment_count'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $MomentsTable createAlias(String alias) {
    return $MomentsTable(attachedDatabase, alias);
  }
}

class Moment extends DataClass implements Insertable<Moment> {
  final String id;
  final String? authorId;
  final String content;
  final String mediaJson;
  final String visibility;
  final bool allowComments;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Moment(
      {required this.id,
      this.authorId,
      required this.content,
      required this.mediaJson,
      required this.visibility,
      required this.allowComments,
      required this.likeCount,
      required this.commentCount,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    map['content'] = Variable<String>(content);
    map['media_json'] = Variable<String>(mediaJson);
    map['visibility'] = Variable<String>(visibility);
    map['allow_comments'] = Variable<bool>(allowComments);
    map['like_count'] = Variable<int>(likeCount);
    map['comment_count'] = Variable<int>(commentCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MomentsCompanion toCompanion(bool nullToAbsent) {
    return MomentsCompanion(
      id: Value(id),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      content: Value(content),
      mediaJson: Value(mediaJson),
      visibility: Value(visibility),
      allowComments: Value(allowComments),
      likeCount: Value(likeCount),
      commentCount: Value(commentCount),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Moment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Moment(
      id: serializer.fromJson<String>(json['id']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      content: serializer.fromJson<String>(json['content']),
      mediaJson: serializer.fromJson<String>(json['mediaJson']),
      visibility: serializer.fromJson<String>(json['visibility']),
      allowComments: serializer.fromJson<bool>(json['allowComments']),
      likeCount: serializer.fromJson<int>(json['likeCount']),
      commentCount: serializer.fromJson<int>(json['commentCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'authorId': serializer.toJson<String?>(authorId),
      'content': serializer.toJson<String>(content),
      'mediaJson': serializer.toJson<String>(mediaJson),
      'visibility': serializer.toJson<String>(visibility),
      'allowComments': serializer.toJson<bool>(allowComments),
      'likeCount': serializer.toJson<int>(likeCount),
      'commentCount': serializer.toJson<int>(commentCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Moment copyWith(
          {String? id,
          Value<String?> authorId = const Value.absent(),
          String? content,
          String? mediaJson,
          String? visibility,
          bool? allowComments,
          int? likeCount,
          int? commentCount,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Moment(
        id: id ?? this.id,
        authorId: authorId.present ? authorId.value : this.authorId,
        content: content ?? this.content,
        mediaJson: mediaJson ?? this.mediaJson,
        visibility: visibility ?? this.visibility,
        allowComments: allowComments ?? this.allowComments,
        likeCount: likeCount ?? this.likeCount,
        commentCount: commentCount ?? this.commentCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Moment copyWithCompanion(MomentsCompanion data) {
    return Moment(
      id: data.id.present ? data.id.value : this.id,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      content: data.content.present ? data.content.value : this.content,
      mediaJson: data.mediaJson.present ? data.mediaJson.value : this.mediaJson,
      visibility:
          data.visibility.present ? data.visibility.value : this.visibility,
      allowComments: data.allowComments.present
          ? data.allowComments.value
          : this.allowComments,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
      commentCount: data.commentCount.present
          ? data.commentCount.value
          : this.commentCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Moment(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('content: $content, ')
          ..write('mediaJson: $mediaJson, ')
          ..write('visibility: $visibility, ')
          ..write('allowComments: $allowComments, ')
          ..write('likeCount: $likeCount, ')
          ..write('commentCount: $commentCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, authorId, content, mediaJson, visibility,
      allowComments, likeCount, commentCount, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Moment &&
          other.id == this.id &&
          other.authorId == this.authorId &&
          other.content == this.content &&
          other.mediaJson == this.mediaJson &&
          other.visibility == this.visibility &&
          other.allowComments == this.allowComments &&
          other.likeCount == this.likeCount &&
          other.commentCount == this.commentCount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MomentsCompanion extends UpdateCompanion<Moment> {
  final Value<String> id;
  final Value<String?> authorId;
  final Value<String> content;
  final Value<String> mediaJson;
  final Value<String> visibility;
  final Value<bool> allowComments;
  final Value<int> likeCount;
  final Value<int> commentCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const MomentsCompanion({
    this.id = const Value.absent(),
    this.authorId = const Value.absent(),
    this.content = const Value.absent(),
    this.mediaJson = const Value.absent(),
    this.visibility = const Value.absent(),
    this.allowComments = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.commentCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MomentsCompanion.insert({
    required String id,
    this.authorId = const Value.absent(),
    required String content,
    this.mediaJson = const Value.absent(),
    this.visibility = const Value.absent(),
    this.allowComments = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.commentCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        content = Value(content);
  static Insertable<Moment> custom({
    Expression<String>? id,
    Expression<String>? authorId,
    Expression<String>? content,
    Expression<String>? mediaJson,
    Expression<String>? visibility,
    Expression<bool>? allowComments,
    Expression<int>? likeCount,
    Expression<int>? commentCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (authorId != null) 'author_id': authorId,
      if (content != null) 'content': content,
      if (mediaJson != null) 'media_json': mediaJson,
      if (visibility != null) 'visibility': visibility,
      if (allowComments != null) 'allow_comments': allowComments,
      if (likeCount != null) 'like_count': likeCount,
      if (commentCount != null) 'comment_count': commentCount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MomentsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? authorId,
      Value<String>? content,
      Value<String>? mediaJson,
      Value<String>? visibility,
      Value<bool>? allowComments,
      Value<int>? likeCount,
      Value<int>? commentCount,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return MomentsCompanion(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      mediaJson: mediaJson ?? this.mediaJson,
      visibility: visibility ?? this.visibility,
      allowComments: allowComments ?? this.allowComments,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (mediaJson.present) {
      map['media_json'] = Variable<String>(mediaJson.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<String>(visibility.value);
    }
    if (allowComments.present) {
      map['allow_comments'] = Variable<bool>(allowComments.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
    }
    if (commentCount.present) {
      map['comment_count'] = Variable<int>(commentCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MomentsCompanion(')
          ..write('id: $id, ')
          ..write('authorId: $authorId, ')
          ..write('content: $content, ')
          ..write('mediaJson: $mediaJson, ')
          ..write('visibility: $visibility, ')
          ..write('allowComments: $allowComments, ')
          ..write('likeCount: $likeCount, ')
          ..write('commentCount: $commentCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MomentReactionsTable extends MomentReactions
    with TableInfo<$MomentReactionsTable, MomentReaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MomentReactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _momentIdMeta =
      const VerificationMeta('momentId');
  @override
  late final GeneratedColumn<String> momentId = GeneratedColumn<String>(
      'moment_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES moments (id)'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contacts (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('like'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _replyToReactionIdMeta =
      const VerificationMeta('replyToReactionId');
  @override
  late final GeneratedColumn<int> replyToReactionId = GeneratedColumn<int>(
      'reply_to_reaction_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES moment_reactions (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, momentId, contactId, type, content, replyToReactionId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moment_reactions';
  @override
  VerificationContext validateIntegrity(Insertable<MomentReaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('moment_id')) {
      context.handle(_momentIdMeta,
          momentId.isAcceptableOrUnknown(data['moment_id']!, _momentIdMeta));
    } else if (isInserting) {
      context.missing(_momentIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('reply_to_reaction_id')) {
      context.handle(
          _replyToReactionIdMeta,
          replyToReactionId.isAcceptableOrUnknown(
              data['reply_to_reaction_id']!, _replyToReactionIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MomentReaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MomentReaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      momentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}moment_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      replyToReactionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}reply_to_reaction_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MomentReactionsTable createAlias(String alias) {
    return $MomentReactionsTable(attachedDatabase, alias);
  }
}

class MomentReaction extends DataClass implements Insertable<MomentReaction> {
  final int id;
  final String momentId;
  final String? contactId;
  final String type;
  final String content;
  final int? replyToReactionId;
  final DateTime createdAt;
  const MomentReaction(
      {required this.id,
      required this.momentId,
      this.contactId,
      required this.type,
      required this.content,
      this.replyToReactionId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['moment_id'] = Variable<String>(momentId);
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || replyToReactionId != null) {
      map['reply_to_reaction_id'] = Variable<int>(replyToReactionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MomentReactionsCompanion toCompanion(bool nullToAbsent) {
    return MomentReactionsCompanion(
      id: Value(id),
      momentId: Value(momentId),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      type: Value(type),
      content: Value(content),
      replyToReactionId: replyToReactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(replyToReactionId),
      createdAt: Value(createdAt),
    );
  }

  factory MomentReaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MomentReaction(
      id: serializer.fromJson<int>(json['id']),
      momentId: serializer.fromJson<String>(json['momentId']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      replyToReactionId: serializer.fromJson<int?>(json['replyToReactionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'momentId': serializer.toJson<String>(momentId),
      'contactId': serializer.toJson<String?>(contactId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'replyToReactionId': serializer.toJson<int?>(replyToReactionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MomentReaction copyWith(
          {int? id,
          String? momentId,
          Value<String?> contactId = const Value.absent(),
          String? type,
          String? content,
          Value<int?> replyToReactionId = const Value.absent(),
          DateTime? createdAt}) =>
      MomentReaction(
        id: id ?? this.id,
        momentId: momentId ?? this.momentId,
        contactId: contactId.present ? contactId.value : this.contactId,
        type: type ?? this.type,
        content: content ?? this.content,
        replyToReactionId: replyToReactionId.present
            ? replyToReactionId.value
            : this.replyToReactionId,
        createdAt: createdAt ?? this.createdAt,
      );
  MomentReaction copyWithCompanion(MomentReactionsCompanion data) {
    return MomentReaction(
      id: data.id.present ? data.id.value : this.id,
      momentId: data.momentId.present ? data.momentId.value : this.momentId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      replyToReactionId: data.replyToReactionId.present
          ? data.replyToReactionId.value
          : this.replyToReactionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MomentReaction(')
          ..write('id: $id, ')
          ..write('momentId: $momentId, ')
          ..write('contactId: $contactId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('replyToReactionId: $replyToReactionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, momentId, contactId, type, content, replyToReactionId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MomentReaction &&
          other.id == this.id &&
          other.momentId == this.momentId &&
          other.contactId == this.contactId &&
          other.type == this.type &&
          other.content == this.content &&
          other.replyToReactionId == this.replyToReactionId &&
          other.createdAt == this.createdAt);
}

class MomentReactionsCompanion extends UpdateCompanion<MomentReaction> {
  final Value<int> id;
  final Value<String> momentId;
  final Value<String?> contactId;
  final Value<String> type;
  final Value<String> content;
  final Value<int?> replyToReactionId;
  final Value<DateTime> createdAt;
  const MomentReactionsCompanion({
    this.id = const Value.absent(),
    this.momentId = const Value.absent(),
    this.contactId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.replyToReactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MomentReactionsCompanion.insert({
    this.id = const Value.absent(),
    required String momentId,
    this.contactId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.replyToReactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : momentId = Value(momentId);
  static Insertable<MomentReaction> custom({
    Expression<int>? id,
    Expression<String>? momentId,
    Expression<String>? contactId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<int>? replyToReactionId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (momentId != null) 'moment_id': momentId,
      if (contactId != null) 'contact_id': contactId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (replyToReactionId != null) 'reply_to_reaction_id': replyToReactionId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MomentReactionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? momentId,
      Value<String?>? contactId,
      Value<String>? type,
      Value<String>? content,
      Value<int?>? replyToReactionId,
      Value<DateTime>? createdAt}) {
    return MomentReactionsCompanion(
      id: id ?? this.id,
      momentId: momentId ?? this.momentId,
      contactId: contactId ?? this.contactId,
      type: type ?? this.type,
      content: content ?? this.content,
      replyToReactionId: replyToReactionId ?? this.replyToReactionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (momentId.present) {
      map['moment_id'] = Variable<String>(momentId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (replyToReactionId.present) {
      map['reply_to_reaction_id'] = Variable<int>(replyToReactionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MomentReactionsCompanion(')
          ..write('id: $id, ')
          ..write('momentId: $momentId, ')
          ..write('contactId: $contactId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('replyToReactionId: $replyToReactionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppPreferencesTable extends AppPreferences
    with TableInfo<$AppPreferencesTable, AppPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_preferences';
  @override
  VerificationContext validateIntegrity(Insertable<AppPreference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppPreference(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppPreferencesTable createAlias(String alias) {
    return $AppPreferencesTable(attachedDatabase, alias);
  }
}

class AppPreference extends DataClass implements Insertable<AppPreference> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppPreference(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppPreferencesCompanion toCompanion(bool nullToAbsent) {
    return AppPreferencesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppPreference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppPreference(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppPreference copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppPreference(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppPreference copyWithCompanion(AppPreferencesCompanion data) {
    return AppPreference(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppPreference(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppPreference &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppPreferencesCompanion extends UpdateCompanion<AppPreference> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppPreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppPreferencesCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<AppPreference> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppPreferencesCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AppPreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppPreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProviderProfilesTable providerProfiles =
      $ProviderProfilesTable(this);
  late final $ProviderKeysTable providerKeys = $ProviderKeysTable(this);
  late final $ModelPresetsTable modelPresets = $ModelPresetsTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $ParticipantsTable participants = $ParticipantsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $GenerationsTable generations = $GenerationsTable(this);
  late final $MemoryEntriesTable memoryEntries = $MemoryEntriesTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final $MomentsTable moments = $MomentsTable(this);
  late final $MomentReactionsTable momentReactions =
      $MomentReactionsTable(this);
  late final $AppPreferencesTable appPreferences = $AppPreferencesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        providerProfiles,
        providerKeys,
        modelPresets,
        contacts,
        conversations,
        participants,
        messages,
        generations,
        memoryEntries,
        attachments,
        moments,
        momentReactions,
        appPreferences
      ];
}

typedef $$ProviderProfilesTableCreateCompanionBuilder
    = ProviderProfilesCompanion Function({
  required String id,
  required String name,
  Value<String> type,
  Value<String> baseUrl,
  Value<String?> defaultModel,
  Value<String> generationConfigJson,
  Value<String> notes,
  Value<bool> isEnabled,
  Value<int> priority,
  Value<String> featuresJson,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ProviderProfilesTableUpdateCompanionBuilder
    = ProviderProfilesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<String> baseUrl,
  Value<String?> defaultModel,
  Value<String> generationConfigJson,
  Value<String> notes,
  Value<bool> isEnabled,
  Value<int> priority,
  Value<String> featuresJson,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ProviderProfilesTableReferences extends BaseReferences<
    _$AppDatabase, $ProviderProfilesTable, ProviderProfile> {
  $$ProviderProfilesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProviderKeysTable, List<ProviderKey>>
      _providerKeysRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.providerKeys,
              aliasName: $_aliasNameGenerator(
                  db.providerProfiles.id, db.providerKeys.profileId));

  $$ProviderKeysTableProcessedTableManager get providerKeysRefs {
    final manager = $$ProviderKeysTableTableManager($_db, $_db.providerKeys)
        .filter((f) => f.profileId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_providerKeysRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ContactsTable, List<Contact>> _contactsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.contacts,
          aliasName: $_aliasNameGenerator(
              db.providerProfiles.id, db.contacts.endpointId));

  $$ContactsTableProcessedTableManager get contactsRefs {
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.endpointId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_contactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ConversationsTable, List<Conversation>>
      _conversationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.conversations,
              aliasName: $_aliasNameGenerator(
                  db.providerProfiles.id, db.conversations.providerProfileId));

  $$ConversationsTableProcessedTableManager get conversationsRefs {
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.providerProfileId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_conversationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProviderProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProviderProfilesTable> {
  $$ProviderProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get baseUrl => $composableBuilder(
      column: $table.baseUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get defaultModel => $composableBuilder(
      column: $table.defaultModel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get generationConfigJson => $composableBuilder(
      column: $table.generationConfigJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get featuresJson => $composableBuilder(
      column: $table.featuresJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> providerKeysRefs(
      Expression<bool> Function($$ProviderKeysTableFilterComposer f) f) {
    final $$ProviderKeysTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.providerKeys,
        getReferencedColumn: (t) => t.profileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderKeysTableFilterComposer(
              $db: $db,
              $table: $db.providerKeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> contactsRefs(
      Expression<bool> Function($$ContactsTableFilterComposer f) f) {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.endpointId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> conversationsRefs(
      Expression<bool> Function($$ConversationsTableFilterComposer f) f) {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.providerProfileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProviderProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProviderProfilesTable> {
  $$ProviderProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get baseUrl => $composableBuilder(
      column: $table.baseUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get defaultModel => $composableBuilder(
      column: $table.defaultModel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get generationConfigJson => $composableBuilder(
      column: $table.generationConfigJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get featuresJson => $composableBuilder(
      column: $table.featuresJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProviderProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProviderProfilesTable> {
  $$ProviderProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get defaultModel => $composableBuilder(
      column: $table.defaultModel, builder: (column) => column);

  GeneratedColumn<String> get generationConfigJson => $composableBuilder(
      column: $table.generationConfigJson, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get featuresJson => $composableBuilder(
      column: $table.featuresJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> providerKeysRefs<T extends Object>(
      Expression<T> Function($$ProviderKeysTableAnnotationComposer a) f) {
    final $$ProviderKeysTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.providerKeys,
        getReferencedColumn: (t) => t.profileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderKeysTableAnnotationComposer(
              $db: $db,
              $table: $db.providerKeys,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> contactsRefs<T extends Object>(
      Expression<T> Function($$ContactsTableAnnotationComposer a) f) {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.endpointId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> conversationsRefs<T extends Object>(
      Expression<T> Function($$ConversationsTableAnnotationComposer a) f) {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.providerProfileId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProviderProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProviderProfilesTable,
    ProviderProfile,
    $$ProviderProfilesTableFilterComposer,
    $$ProviderProfilesTableOrderingComposer,
    $$ProviderProfilesTableAnnotationComposer,
    $$ProviderProfilesTableCreateCompanionBuilder,
    $$ProviderProfilesTableUpdateCompanionBuilder,
    (ProviderProfile, $$ProviderProfilesTableReferences),
    ProviderProfile,
    PrefetchHooks Function(
        {bool providerKeysRefs, bool contactsRefs, bool conversationsRefs})> {
  $$ProviderProfilesTableTableManager(
      _$AppDatabase db, $ProviderProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProviderProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProviderProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProviderProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> baseUrl = const Value.absent(),
            Value<String?> defaultModel = const Value.absent(),
            Value<String> generationConfigJson = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String> featuresJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProviderProfilesCompanion(
            id: id,
            name: name,
            type: type,
            baseUrl: baseUrl,
            defaultModel: defaultModel,
            generationConfigJson: generationConfigJson,
            notes: notes,
            isEnabled: isEnabled,
            priority: priority,
            featuresJson: featuresJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> type = const Value.absent(),
            Value<String> baseUrl = const Value.absent(),
            Value<String?> defaultModel = const Value.absent(),
            Value<String> generationConfigJson = const Value.absent(),
            Value<String> notes = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String> featuresJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProviderProfilesCompanion.insert(
            id: id,
            name: name,
            type: type,
            baseUrl: baseUrl,
            defaultModel: defaultModel,
            generationConfigJson: generationConfigJson,
            notes: notes,
            isEnabled: isEnabled,
            priority: priority,
            featuresJson: featuresJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProviderProfilesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {providerKeysRefs = false,
              contactsRefs = false,
              conversationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (providerKeysRefs) db.providerKeys,
                if (contactsRefs) db.contacts,
                if (conversationsRefs) db.conversations
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (providerKeysRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProviderProfilesTableReferences
                            ._providerKeysRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProviderProfilesTableReferences(db, table, p0)
                                .providerKeysRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.profileId == item.id),
                        typedResults: items),
                  if (contactsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProviderProfilesTableReferences
                            ._contactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProviderProfilesTableReferences(db, table, p0)
                                .contactsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.endpointId == item.id),
                        typedResults: items),
                  if (conversationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProviderProfilesTableReferences
                            ._conversationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProviderProfilesTableReferences(db, table, p0)
                                .conversationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.providerProfileId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProviderProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProviderProfilesTable,
    ProviderProfile,
    $$ProviderProfilesTableFilterComposer,
    $$ProviderProfilesTableOrderingComposer,
    $$ProviderProfilesTableAnnotationComposer,
    $$ProviderProfilesTableCreateCompanionBuilder,
    $$ProviderProfilesTableUpdateCompanionBuilder,
    (ProviderProfile, $$ProviderProfilesTableReferences),
    ProviderProfile,
    PrefetchHooks Function(
        {bool providerKeysRefs, bool contactsRefs, bool conversationsRefs})>;
typedef $$ProviderKeysTableCreateCompanionBuilder = ProviderKeysCompanion
    Function({
  Value<int> id,
  required String profileId,
  required String label,
  required String secureKeyRef,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$ProviderKeysTableUpdateCompanionBuilder = ProviderKeysCompanion
    Function({
  Value<int> id,
  Value<String> profileId,
  Value<String> label,
  Value<String> secureKeyRef,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$ProviderKeysTableReferences
    extends BaseReferences<_$AppDatabase, $ProviderKeysTable, ProviderKey> {
  $$ProviderKeysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProviderProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.providerProfiles.createAlias($_aliasNameGenerator(
          db.providerKeys.profileId, db.providerProfiles.id));

  $$ProviderProfilesTableProcessedTableManager? get profileId {
    if ($_item.profileId == null) return null;
    final manager =
        $$ProviderProfilesTableTableManager($_db, $_db.providerProfiles)
            .filter((f) => f.id($_item.profileId!));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ProviderKeysTableFilterComposer
    extends Composer<_$AppDatabase, $ProviderKeysTable> {
  $$ProviderKeysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get secureKeyRef => $composableBuilder(
      column: $table.secureKeyRef, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProviderProfilesTableFilterComposer get profileId {
    final $$ProviderProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profileId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableFilterComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProviderKeysTableOrderingComposer
    extends Composer<_$AppDatabase, $ProviderKeysTable> {
  $$ProviderKeysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get secureKeyRef => $composableBuilder(
      column: $table.secureKeyRef,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProviderProfilesTableOrderingComposer get profileId {
    final $$ProviderProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profileId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProviderKeysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProviderKeysTable> {
  $$ProviderKeysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get secureKeyRef => $composableBuilder(
      column: $table.secureKeyRef, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProviderProfilesTableAnnotationComposer get profileId {
    final $$ProviderProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.profileId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ProviderKeysTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProviderKeysTable,
    ProviderKey,
    $$ProviderKeysTableFilterComposer,
    $$ProviderKeysTableOrderingComposer,
    $$ProviderKeysTableAnnotationComposer,
    $$ProviderKeysTableCreateCompanionBuilder,
    $$ProviderKeysTableUpdateCompanionBuilder,
    (ProviderKey, $$ProviderKeysTableReferences),
    ProviderKey,
    PrefetchHooks Function({bool profileId})> {
  $$ProviderKeysTableTableManager(_$AppDatabase db, $ProviderKeysTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProviderKeysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProviderKeysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProviderKeysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> profileId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> secureKeyRef = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ProviderKeysCompanion(
            id: id,
            profileId: profileId,
            label: label,
            secureKeyRef: secureKeyRef,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String profileId,
            required String label,
            required String secureKeyRef,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              ProviderKeysCompanion.insert(
            id: id,
            profileId: profileId,
            label: label,
            secureKeyRef: secureKeyRef,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ProviderKeysTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (profileId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.profileId,
                    referencedTable:
                        $$ProviderKeysTableReferences._profileIdTable(db),
                    referencedColumn:
                        $$ProviderKeysTableReferences._profileIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ProviderKeysTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProviderKeysTable,
    ProviderKey,
    $$ProviderKeysTableFilterComposer,
    $$ProviderKeysTableOrderingComposer,
    $$ProviderKeysTableAnnotationComposer,
    $$ProviderKeysTableCreateCompanionBuilder,
    $$ProviderKeysTableUpdateCompanionBuilder,
    (ProviderKey, $$ProviderKeysTableReferences),
    ProviderKey,
    PrefetchHooks Function({bool profileId})>;
typedef $$ModelPresetsTableCreateCompanionBuilder = ModelPresetsCompanion
    Function({
  required String id,
  required String name,
  Value<double> temperature,
  Value<double> topP,
  Value<int> topK,
  Value<int?> maxTokens,
  Value<double> presencePenalty,
  Value<double> frequencyPenalty,
  Value<bool> stream,
  Value<String> stopSequencesJson,
  Value<String> metadata,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ModelPresetsTableUpdateCompanionBuilder = ModelPresetsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<double> temperature,
  Value<double> topP,
  Value<int> topK,
  Value<int?> maxTokens,
  Value<double> presencePenalty,
  Value<double> frequencyPenalty,
  Value<bool> stream,
  Value<String> stopSequencesJson,
  Value<String> metadata,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ModelPresetsTableReferences
    extends BaseReferences<_$AppDatabase, $ModelPresetsTable, ModelPreset> {
  $$ModelPresetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ContactsTable, List<Contact>> _contactsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.contacts,
          aliasName:
              $_aliasNameGenerator(db.modelPresets.id, db.contacts.presetId));

  $$ContactsTableProcessedTableManager get contactsRefs {
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.presetId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_contactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ConversationsTable, List<Conversation>>
      _conversationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.conversations,
              aliasName: $_aliasNameGenerator(
                  db.modelPresets.id, db.conversations.modelPresetId));

  $$ConversationsTableProcessedTableManager get conversationsRefs {
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.modelPresetId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_conversationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ModelPresetsTableFilterComposer
    extends Composer<_$AppDatabase, $ModelPresetsTable> {
  $$ModelPresetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get topP => $composableBuilder(
      column: $table.topP, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get topK => $composableBuilder(
      column: $table.topK, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxTokens => $composableBuilder(
      column: $table.maxTokens, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get presencePenalty => $composableBuilder(
      column: $table.presencePenalty,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get frequencyPenalty => $composableBuilder(
      column: $table.frequencyPenalty,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get stream => $composableBuilder(
      column: $table.stream, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stopSequencesJson => $composableBuilder(
      column: $table.stopSequencesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> contactsRefs(
      Expression<bool> Function($$ContactsTableFilterComposer f) f) {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.presetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> conversationsRefs(
      Expression<bool> Function($$ConversationsTableFilterComposer f) f) {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.modelPresetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ModelPresetsTableOrderingComposer
    extends Composer<_$AppDatabase, $ModelPresetsTable> {
  $$ModelPresetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get topP => $composableBuilder(
      column: $table.topP, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get topK => $composableBuilder(
      column: $table.topK, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxTokens => $composableBuilder(
      column: $table.maxTokens, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get presencePenalty => $composableBuilder(
      column: $table.presencePenalty,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get frequencyPenalty => $composableBuilder(
      column: $table.frequencyPenalty,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get stream => $composableBuilder(
      column: $table.stream, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stopSequencesJson => $composableBuilder(
      column: $table.stopSequencesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ModelPresetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModelPresetsTable> {
  $$ModelPresetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => column);

  GeneratedColumn<double> get topP =>
      $composableBuilder(column: $table.topP, builder: (column) => column);

  GeneratedColumn<int> get topK =>
      $composableBuilder(column: $table.topK, builder: (column) => column);

  GeneratedColumn<int> get maxTokens =>
      $composableBuilder(column: $table.maxTokens, builder: (column) => column);

  GeneratedColumn<double> get presencePenalty => $composableBuilder(
      column: $table.presencePenalty, builder: (column) => column);

  GeneratedColumn<double> get frequencyPenalty => $composableBuilder(
      column: $table.frequencyPenalty, builder: (column) => column);

  GeneratedColumn<bool> get stream =>
      $composableBuilder(column: $table.stream, builder: (column) => column);

  GeneratedColumn<String> get stopSequencesJson => $composableBuilder(
      column: $table.stopSequencesJson, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> contactsRefs<T extends Object>(
      Expression<T> Function($$ContactsTableAnnotationComposer a) f) {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.presetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> conversationsRefs<T extends Object>(
      Expression<T> Function($$ConversationsTableAnnotationComposer a) f) {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.modelPresetId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ModelPresetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ModelPresetsTable,
    ModelPreset,
    $$ModelPresetsTableFilterComposer,
    $$ModelPresetsTableOrderingComposer,
    $$ModelPresetsTableAnnotationComposer,
    $$ModelPresetsTableCreateCompanionBuilder,
    $$ModelPresetsTableUpdateCompanionBuilder,
    (ModelPreset, $$ModelPresetsTableReferences),
    ModelPreset,
    PrefetchHooks Function({bool contactsRefs, bool conversationsRefs})> {
  $$ModelPresetsTableTableManager(_$AppDatabase db, $ModelPresetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModelPresetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModelPresetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModelPresetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> temperature = const Value.absent(),
            Value<double> topP = const Value.absent(),
            Value<int> topK = const Value.absent(),
            Value<int?> maxTokens = const Value.absent(),
            Value<double> presencePenalty = const Value.absent(),
            Value<double> frequencyPenalty = const Value.absent(),
            Value<bool> stream = const Value.absent(),
            Value<String> stopSequencesJson = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModelPresetsCompanion(
            id: id,
            name: name,
            temperature: temperature,
            topP: topP,
            topK: topK,
            maxTokens: maxTokens,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty,
            stream: stream,
            stopSequencesJson: stopSequencesJson,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<double> temperature = const Value.absent(),
            Value<double> topP = const Value.absent(),
            Value<int> topK = const Value.absent(),
            Value<int?> maxTokens = const Value.absent(),
            Value<double> presencePenalty = const Value.absent(),
            Value<double> frequencyPenalty = const Value.absent(),
            Value<bool> stream = const Value.absent(),
            Value<String> stopSequencesJson = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ModelPresetsCompanion.insert(
            id: id,
            name: name,
            temperature: temperature,
            topP: topP,
            topK: topK,
            maxTokens: maxTokens,
            presencePenalty: presencePenalty,
            frequencyPenalty: frequencyPenalty,
            stream: stream,
            stopSequencesJson: stopSequencesJson,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ModelPresetsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {contactsRefs = false, conversationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (contactsRefs) db.contacts,
                if (conversationsRefs) db.conversations
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (contactsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ModelPresetsTableReferences
                            ._contactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ModelPresetsTableReferences(db, table, p0)
                                .contactsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.presetId == item.id),
                        typedResults: items),
                  if (conversationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ModelPresetsTableReferences
                            ._conversationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ModelPresetsTableReferences(db, table, p0)
                                .conversationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.modelPresetId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ModelPresetsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ModelPresetsTable,
    ModelPreset,
    $$ModelPresetsTableFilterComposer,
    $$ModelPresetsTableOrderingComposer,
    $$ModelPresetsTableAnnotationComposer,
    $$ModelPresetsTableCreateCompanionBuilder,
    $$ModelPresetsTableUpdateCompanionBuilder,
    (ModelPreset, $$ModelPresetsTableReferences),
    ModelPreset,
    PrefetchHooks Function({bool contactsRefs, bool conversationsRefs})>;
typedef $$ContactsTableCreateCompanionBuilder = ContactsCompanion Function({
  required String id,
  required String name,
  Value<String> persona,
  Value<String> greeting,
  Value<String> description,
  Value<String> avatarColor,
  Value<String?> endpointId,
  Value<String?> presetId,
  Value<String> memoryConfigJson,
  Value<String> tagsJson,
  Value<String> sampleRepliesJson,
  Value<bool> archived,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> persona,
  Value<String> greeting,
  Value<String> description,
  Value<String> avatarColor,
  Value<String?> endpointId,
  Value<String?> presetId,
  Value<String> memoryConfigJson,
  Value<String> tagsJson,
  Value<String> sampleRepliesJson,
  Value<bool> archived,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Contact> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProviderProfilesTable _endpointIdTable(_$AppDatabase db) =>
      db.providerProfiles.createAlias(
          $_aliasNameGenerator(db.contacts.endpointId, db.providerProfiles.id));

  $$ProviderProfilesTableProcessedTableManager? get endpointId {
    if ($_item.endpointId == null) return null;
    final manager =
        $$ProviderProfilesTableTableManager($_db, $_db.providerProfiles)
            .filter((f) => f.id($_item.endpointId!));
    final item = $_typedResult.readTableOrNull(_endpointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ModelPresetsTable _presetIdTable(_$AppDatabase db) =>
      db.modelPresets.createAlias(
          $_aliasNameGenerator(db.contacts.presetId, db.modelPresets.id));

  $$ModelPresetsTableProcessedTableManager? get presetId {
    if ($_item.presetId == null) return null;
    final manager = $$ModelPresetsTableTableManager($_db, $_db.modelPresets)
        .filter((f) => f.id($_item.presetId!));
    final item = $_typedResult.readTableOrNull(_presetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ConversationsTable, List<Conversation>>
      _conversationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.conversations,
              aliasName: $_aliasNameGenerator(
                  db.contacts.id, db.conversations.contactId));

  $$ConversationsTableProcessedTableManager get conversationsRefs {
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.contactId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_conversationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ParticipantsTable, List<Participant>>
      _participantsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.participants,
          aliasName:
              $_aliasNameGenerator(db.contacts.id, db.participants.contactId));

  $$ParticipantsTableProcessedTableManager get participantsRefs {
    final manager = $$ParticipantsTableTableManager($_db, $_db.participants)
        .filter((f) => f.contactId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_participantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MomentsTable, List<Moment>> _momentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.moments,
          aliasName: $_aliasNameGenerator(db.contacts.id, db.moments.authorId));

  $$MomentsTableProcessedTableManager get momentsRefs {
    final manager = $$MomentsTableTableManager($_db, $_db.moments)
        .filter((f) => f.authorId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_momentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MomentReactionsTable, List<MomentReaction>>
      _momentReactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.momentReactions,
              aliasName: $_aliasNameGenerator(
                  db.contacts.id, db.momentReactions.contactId));

  $$MomentReactionsTableProcessedTableManager get momentReactionsRefs {
    final manager =
        $$MomentReactionsTableTableManager($_db, $_db.momentReactions)
            .filter((f) => f.contactId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_momentReactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get persona => $composableBuilder(
      column: $table.persona, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get greeting => $composableBuilder(
      column: $table.greeting, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarColor => $composableBuilder(
      column: $table.avatarColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memoryConfigJson => $composableBuilder(
      column: $table.memoryConfigJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sampleRepliesJson => $composableBuilder(
      column: $table.sampleRepliesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived => $composableBuilder(
      column: $table.archived, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ProviderProfilesTableFilterComposer get endpointId {
    final $$ProviderProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.endpointId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableFilterComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ModelPresetsTableFilterComposer get presetId {
    final $$ModelPresetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.presetId,
        referencedTable: $db.modelPresets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPresetsTableFilterComposer(
              $db: $db,
              $table: $db.modelPresets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> conversationsRefs(
      Expression<bool> Function($$ConversationsTableFilterComposer f) f) {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> participantsRefs(
      Expression<bool> Function($$ParticipantsTableFilterComposer f) f) {
    final $$ParticipantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.participants,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParticipantsTableFilterComposer(
              $db: $db,
              $table: $db.participants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> momentsRefs(
      Expression<bool> Function($$MomentsTableFilterComposer f) f) {
    final $$MomentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.moments,
        getReferencedColumn: (t) => t.authorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentsTableFilterComposer(
              $db: $db,
              $table: $db.moments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> momentReactionsRefs(
      Expression<bool> Function($$MomentReactionsTableFilterComposer f) f) {
    final $$MomentReactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableFilterComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get persona => $composableBuilder(
      column: $table.persona, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get greeting => $composableBuilder(
      column: $table.greeting, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarColor => $composableBuilder(
      column: $table.avatarColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memoryConfigJson => $composableBuilder(
      column: $table.memoryConfigJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sampleRepliesJson => $composableBuilder(
      column: $table.sampleRepliesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived => $composableBuilder(
      column: $table.archived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ProviderProfilesTableOrderingComposer get endpointId {
    final $$ProviderProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.endpointId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ModelPresetsTableOrderingComposer get presetId {
    final $$ModelPresetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.presetId,
        referencedTable: $db.modelPresets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPresetsTableOrderingComposer(
              $db: $db,
              $table: $db.modelPresets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get persona =>
      $composableBuilder(column: $table.persona, builder: (column) => column);

  GeneratedColumn<String> get greeting =>
      $composableBuilder(column: $table.greeting, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get avatarColor => $composableBuilder(
      column: $table.avatarColor, builder: (column) => column);

  GeneratedColumn<String> get memoryConfigJson => $composableBuilder(
      column: $table.memoryConfigJson, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<String> get sampleRepliesJson => $composableBuilder(
      column: $table.sampleRepliesJson, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProviderProfilesTableAnnotationComposer get endpointId {
    final $$ProviderProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.endpointId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ModelPresetsTableAnnotationComposer get presetId {
    final $$ModelPresetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.presetId,
        referencedTable: $db.modelPresets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPresetsTableAnnotationComposer(
              $db: $db,
              $table: $db.modelPresets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> conversationsRefs<T extends Object>(
      Expression<T> Function($$ConversationsTableAnnotationComposer a) f) {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> participantsRefs<T extends Object>(
      Expression<T> Function($$ParticipantsTableAnnotationComposer a) f) {
    final $$ParticipantsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.participants,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParticipantsTableAnnotationComposer(
              $db: $db,
              $table: $db.participants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> momentsRefs<T extends Object>(
      Expression<T> Function($$MomentsTableAnnotationComposer a) f) {
    final $$MomentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.moments,
        getReferencedColumn: (t) => t.authorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentsTableAnnotationComposer(
              $db: $db,
              $table: $db.moments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> momentReactionsRefs<T extends Object>(
      Expression<T> Function($$MomentReactionsTableAnnotationComposer a) f) {
    final $$MomentReactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function(
        {bool endpointId,
        bool presetId,
        bool conversationsRefs,
        bool participantsRefs,
        bool momentsRefs,
        bool momentReactionsRefs})> {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> persona = const Value.absent(),
            Value<String> greeting = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> avatarColor = const Value.absent(),
            Value<String?> endpointId = const Value.absent(),
            Value<String?> presetId = const Value.absent(),
            Value<String> memoryConfigJson = const Value.absent(),
            Value<String> tagsJson = const Value.absent(),
            Value<String> sampleRepliesJson = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContactsCompanion(
            id: id,
            name: name,
            persona: persona,
            greeting: greeting,
            description: description,
            avatarColor: avatarColor,
            endpointId: endpointId,
            presetId: presetId,
            memoryConfigJson: memoryConfigJson,
            tagsJson: tagsJson,
            sampleRepliesJson: sampleRepliesJson,
            archived: archived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> persona = const Value.absent(),
            Value<String> greeting = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> avatarColor = const Value.absent(),
            Value<String?> endpointId = const Value.absent(),
            Value<String?> presetId = const Value.absent(),
            Value<String> memoryConfigJson = const Value.absent(),
            Value<String> tagsJson = const Value.absent(),
            Value<String> sampleRepliesJson = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContactsCompanion.insert(
            id: id,
            name: name,
            persona: persona,
            greeting: greeting,
            description: description,
            avatarColor: avatarColor,
            endpointId: endpointId,
            presetId: presetId,
            memoryConfigJson: memoryConfigJson,
            tagsJson: tagsJson,
            sampleRepliesJson: sampleRepliesJson,
            archived: archived,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ContactsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {endpointId = false,
              presetId = false,
              conversationsRefs = false,
              participantsRefs = false,
              momentsRefs = false,
              momentReactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (conversationsRefs) db.conversations,
                if (participantsRefs) db.participants,
                if (momentsRefs) db.moments,
                if (momentReactionsRefs) db.momentReactions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (endpointId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.endpointId,
                    referencedTable:
                        $$ContactsTableReferences._endpointIdTable(db),
                    referencedColumn:
                        $$ContactsTableReferences._endpointIdTable(db).id,
                  ) as T;
                }
                if (presetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.presetId,
                    referencedTable:
                        $$ContactsTableReferences._presetIdTable(db),
                    referencedColumn:
                        $$ContactsTableReferences._presetIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (conversationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._conversationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .conversationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items),
                  if (participantsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._participantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .participantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items),
                  if (momentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$ContactsTableReferences._momentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .momentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.authorId == item.id),
                        typedResults: items),
                  if (momentReactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._momentReactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .momentReactionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function(
        {bool endpointId,
        bool presetId,
        bool conversationsRefs,
        bool participantsRefs,
        bool momentsRefs,
        bool momentReactionsRefs})>;
typedef $$ConversationsTableCreateCompanionBuilder = ConversationsCompanion
    Function({
  required String id,
  Value<String> title,
  Value<String?> contactId,
  Value<String?> providerProfileId,
  Value<String?> modelPresetId,
  Value<String> lastMessageSnippet,
  Value<DateTime?> lastMessageTime,
  Value<int> unreadCount,
  Value<bool> isPinned,
  Value<bool> isMuted,
  Value<String> draftText,
  Value<String> metadata,
  Value<String> memoryPolicyJson,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ConversationsTableUpdateCompanionBuilder = ConversationsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> contactId,
  Value<String?> providerProfileId,
  Value<String?> modelPresetId,
  Value<String> lastMessageSnippet,
  Value<DateTime?> lastMessageTime,
  Value<int> unreadCount,
  Value<bool> isPinned,
  Value<bool> isMuted,
  Value<String> draftText,
  Value<String> metadata,
  Value<String> memoryPolicyJson,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ConversationsTableReferences
    extends BaseReferences<_$AppDatabase, $ConversationsTable, Conversation> {
  $$ConversationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias(
          $_aliasNameGenerator(db.conversations.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager? get contactId {
    if ($_item.contactId == null) return null;
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id($_item.contactId!));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ProviderProfilesTable _providerProfileIdTable(_$AppDatabase db) =>
      db.providerProfiles.createAlias($_aliasNameGenerator(
          db.conversations.providerProfileId, db.providerProfiles.id));

  $$ProviderProfilesTableProcessedTableManager? get providerProfileId {
    if ($_item.providerProfileId == null) return null;
    final manager =
        $$ProviderProfilesTableTableManager($_db, $_db.providerProfiles)
            .filter((f) => f.id($_item.providerProfileId!));
    final item = $_typedResult.readTableOrNull(_providerProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ModelPresetsTable _modelPresetIdTable(_$AppDatabase db) =>
      db.modelPresets.createAlias($_aliasNameGenerator(
          db.conversations.modelPresetId, db.modelPresets.id));

  $$ModelPresetsTableProcessedTableManager? get modelPresetId {
    if ($_item.modelPresetId == null) return null;
    final manager = $$ModelPresetsTableTableManager($_db, $_db.modelPresets)
        .filter((f) => f.id($_item.modelPresetId!));
    final item = $_typedResult.readTableOrNull(_modelPresetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ParticipantsTable, List<Participant>>
      _participantsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.participants,
              aliasName: $_aliasNameGenerator(
                  db.conversations.id, db.participants.conversationId));

  $$ParticipantsTableProcessedTableManager get participantsRefs {
    final manager = $$ParticipantsTableTableManager($_db, $_db.participants)
        .filter((f) => f.conversationId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_participantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MessagesTable, List<Message>> _messagesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.messages,
          aliasName: $_aliasNameGenerator(
              db.conversations.id, db.messages.conversationId));

  $$MessagesTableProcessedTableManager get messagesRefs {
    final manager = $$MessagesTableTableManager($_db, $_db.messages)
        .filter((f) => f.conversationId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_messagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MemoryEntriesTable, List<MemoryEntry>>
      _memoryEntriesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.memoryEntries,
              aliasName: $_aliasNameGenerator(
                  db.conversations.id, db.memoryEntries.conversationId));

  $$MemoryEntriesTableProcessedTableManager get memoryEntriesRefs {
    final manager = $$MemoryEntriesTableTableManager($_db, $_db.memoryEntries)
        .filter((f) => f.conversationId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_memoryEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastMessageSnippet => $composableBuilder(
      column: $table.lastMessageSnippet,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastMessageTime => $composableBuilder(
      column: $table.lastMessageTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unreadCount => $composableBuilder(
      column: $table.unreadCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMuted => $composableBuilder(
      column: $table.isMuted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get draftText => $composableBuilder(
      column: $table.draftText, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memoryPolicyJson => $composableBuilder(
      column: $table.memoryPolicyJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProviderProfilesTableFilterComposer get providerProfileId {
    final $$ProviderProfilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.providerProfileId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableFilterComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ModelPresetsTableFilterComposer get modelPresetId {
    final $$ModelPresetsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.modelPresetId,
        referencedTable: $db.modelPresets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPresetsTableFilterComposer(
              $db: $db,
              $table: $db.modelPresets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> participantsRefs(
      Expression<bool> Function($$ParticipantsTableFilterComposer f) f) {
    final $$ParticipantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.participants,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParticipantsTableFilterComposer(
              $db: $db,
              $table: $db.participants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> messagesRefs(
      Expression<bool> Function($$MessagesTableFilterComposer f) f) {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableFilterComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> memoryEntriesRefs(
      Expression<bool> Function($$MemoryEntriesTableFilterComposer f) f) {
    final $$MemoryEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memoryEntries,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoryEntriesTableFilterComposer(
              $db: $db,
              $table: $db.memoryEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastMessageSnippet => $composableBuilder(
      column: $table.lastMessageSnippet,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastMessageTime => $composableBuilder(
      column: $table.lastMessageTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unreadCount => $composableBuilder(
      column: $table.unreadCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMuted => $composableBuilder(
      column: $table.isMuted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get draftText => $composableBuilder(
      column: $table.draftText, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memoryPolicyJson => $composableBuilder(
      column: $table.memoryPolicyJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProviderProfilesTableOrderingComposer get providerProfileId {
    final $$ProviderProfilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.providerProfileId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableOrderingComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ModelPresetsTableOrderingComposer get modelPresetId {
    final $$ModelPresetsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.modelPresetId,
        referencedTable: $db.modelPresets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPresetsTableOrderingComposer(
              $db: $db,
              $table: $db.modelPresets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConversationsTable> {
  $$ConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get lastMessageSnippet => $composableBuilder(
      column: $table.lastMessageSnippet, builder: (column) => column);

  GeneratedColumn<DateTime> get lastMessageTime => $composableBuilder(
      column: $table.lastMessageTime, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(
      column: $table.unreadCount, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<bool> get isMuted =>
      $composableBuilder(column: $table.isMuted, builder: (column) => column);

  GeneratedColumn<String> get draftText =>
      $composableBuilder(column: $table.draftText, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<String> get memoryPolicyJson => $composableBuilder(
      column: $table.memoryPolicyJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ProviderProfilesTableAnnotationComposer get providerProfileId {
    final $$ProviderProfilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.providerProfileId,
        referencedTable: $db.providerProfiles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProviderProfilesTableAnnotationComposer(
              $db: $db,
              $table: $db.providerProfiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ModelPresetsTableAnnotationComposer get modelPresetId {
    final $$ModelPresetsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.modelPresetId,
        referencedTable: $db.modelPresets,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ModelPresetsTableAnnotationComposer(
              $db: $db,
              $table: $db.modelPresets,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> participantsRefs<T extends Object>(
      Expression<T> Function($$ParticipantsTableAnnotationComposer a) f) {
    final $$ParticipantsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.participants,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ParticipantsTableAnnotationComposer(
              $db: $db,
              $table: $db.participants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> messagesRefs<T extends Object>(
      Expression<T> Function($$MessagesTableAnnotationComposer a) f) {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> memoryEntriesRefs<T extends Object>(
      Expression<T> Function($$MemoryEntriesTableAnnotationComposer a) f) {
    final $$MemoryEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.memoryEntries,
        getReferencedColumn: (t) => t.conversationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MemoryEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.memoryEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ConversationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConversationsTable,
    Conversation,
    $$ConversationsTableFilterComposer,
    $$ConversationsTableOrderingComposer,
    $$ConversationsTableAnnotationComposer,
    $$ConversationsTableCreateCompanionBuilder,
    $$ConversationsTableUpdateCompanionBuilder,
    (Conversation, $$ConversationsTableReferences),
    Conversation,
    PrefetchHooks Function(
        {bool contactId,
        bool providerProfileId,
        bool modelPresetId,
        bool participantsRefs,
        bool messagesRefs,
        bool memoryEntriesRefs})> {
  $$ConversationsTableTableManager(_$AppDatabase db, $ConversationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConversationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> contactId = const Value.absent(),
            Value<String?> providerProfileId = const Value.absent(),
            Value<String?> modelPresetId = const Value.absent(),
            Value<String> lastMessageSnippet = const Value.absent(),
            Value<DateTime?> lastMessageTime = const Value.absent(),
            Value<int> unreadCount = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<bool> isMuted = const Value.absent(),
            Value<String> draftText = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<String> memoryPolicyJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationsCompanion(
            id: id,
            title: title,
            contactId: contactId,
            providerProfileId: providerProfileId,
            modelPresetId: modelPresetId,
            lastMessageSnippet: lastMessageSnippet,
            lastMessageTime: lastMessageTime,
            unreadCount: unreadCount,
            isPinned: isPinned,
            isMuted: isMuted,
            draftText: draftText,
            metadata: metadata,
            memoryPolicyJson: memoryPolicyJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String> title = const Value.absent(),
            Value<String?> contactId = const Value.absent(),
            Value<String?> providerProfileId = const Value.absent(),
            Value<String?> modelPresetId = const Value.absent(),
            Value<String> lastMessageSnippet = const Value.absent(),
            Value<DateTime?> lastMessageTime = const Value.absent(),
            Value<int> unreadCount = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<bool> isMuted = const Value.absent(),
            Value<String> draftText = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<String> memoryPolicyJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConversationsCompanion.insert(
            id: id,
            title: title,
            contactId: contactId,
            providerProfileId: providerProfileId,
            modelPresetId: modelPresetId,
            lastMessageSnippet: lastMessageSnippet,
            lastMessageTime: lastMessageTime,
            unreadCount: unreadCount,
            isPinned: isPinned,
            isMuted: isMuted,
            draftText: draftText,
            metadata: metadata,
            memoryPolicyJson: memoryPolicyJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ConversationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {contactId = false,
              providerProfileId = false,
              modelPresetId = false,
              participantsRefs = false,
              messagesRefs = false,
              memoryEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (participantsRefs) db.participants,
                if (messagesRefs) db.messages,
                if (memoryEntriesRefs) db.memoryEntries
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$ConversationsTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$ConversationsTableReferences._contactIdTable(db).id,
                  ) as T;
                }
                if (providerProfileId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.providerProfileId,
                    referencedTable: $$ConversationsTableReferences
                        ._providerProfileIdTable(db),
                    referencedColumn: $$ConversationsTableReferences
                        ._providerProfileIdTable(db)
                        .id,
                  ) as T;
                }
                if (modelPresetId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.modelPresetId,
                    referencedTable:
                        $$ConversationsTableReferences._modelPresetIdTable(db),
                    referencedColumn: $$ConversationsTableReferences
                        ._modelPresetIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (participantsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ConversationsTableReferences
                            ._participantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ConversationsTableReferences(db, table, p0)
                                .participantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.conversationId == item.id),
                        typedResults: items),
                  if (messagesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ConversationsTableReferences
                            ._messagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ConversationsTableReferences(db, table, p0)
                                .messagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.conversationId == item.id),
                        typedResults: items),
                  if (memoryEntriesRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ConversationsTableReferences
                            ._memoryEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ConversationsTableReferences(db, table, p0)
                                .memoryEntriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.conversationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ConversationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ConversationsTable,
    Conversation,
    $$ConversationsTableFilterComposer,
    $$ConversationsTableOrderingComposer,
    $$ConversationsTableAnnotationComposer,
    $$ConversationsTableCreateCompanionBuilder,
    $$ConversationsTableUpdateCompanionBuilder,
    (Conversation, $$ConversationsTableReferences),
    Conversation,
    PrefetchHooks Function(
        {bool contactId,
        bool providerProfileId,
        bool modelPresetId,
        bool participantsRefs,
        bool messagesRefs,
        bool memoryEntriesRefs})>;
typedef $$ParticipantsTableCreateCompanionBuilder = ParticipantsCompanion
    Function({
  Value<int> id,
  required String conversationId,
  required String contactId,
  Value<String> role,
  Value<DateTime> createdAt,
});
typedef $$ParticipantsTableUpdateCompanionBuilder = ParticipantsCompanion
    Function({
  Value<int> id,
  Value<String> conversationId,
  Value<String> contactId,
  Value<String> role,
  Value<DateTime> createdAt,
});

final class $$ParticipantsTableReferences
    extends BaseReferences<_$AppDatabase, $ParticipantsTable, Participant> {
  $$ParticipantsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) =>
      db.conversations.createAlias($_aliasNameGenerator(
          db.participants.conversationId, db.conversations.id));

  $$ConversationsTableProcessedTableManager? get conversationId {
    if ($_item.conversationId == null) return null;
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.id($_item.conversationId!));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias(
          $_aliasNameGenerator(db.participants.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager? get contactId {
    if ($_item.contactId == null) return null;
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id($_item.contactId!));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $ParticipantsTable> {
  $$ParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ParticipantsTable> {
  $$ParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableOrderingComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ParticipantsTable> {
  $$ParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ParticipantsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ParticipantsTable,
    Participant,
    $$ParticipantsTableFilterComposer,
    $$ParticipantsTableOrderingComposer,
    $$ParticipantsTableAnnotationComposer,
    $$ParticipantsTableCreateCompanionBuilder,
    $$ParticipantsTableUpdateCompanionBuilder,
    (Participant, $$ParticipantsTableReferences),
    Participant,
    PrefetchHooks Function({bool conversationId, bool contactId})> {
  $$ParticipantsTableTableManager(_$AppDatabase db, $ParticipantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ParticipantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ParticipantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ParticipantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> conversationId = const Value.absent(),
            Value<String> contactId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ParticipantsCompanion(
            id: id,
            conversationId: conversationId,
            contactId: contactId,
            role: role,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String conversationId,
            required String contactId,
            Value<String> role = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ParticipantsCompanion.insert(
            id: id,
            conversationId: conversationId,
            contactId: contactId,
            role: role,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ParticipantsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({conversationId = false, contactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (conversationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.conversationId,
                    referencedTable:
                        $$ParticipantsTableReferences._conversationIdTable(db),
                    referencedColumn: $$ParticipantsTableReferences
                        ._conversationIdTable(db)
                        .id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$ParticipantsTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$ParticipantsTableReferences._contactIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ParticipantsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ParticipantsTable,
    Participant,
    $$ParticipantsTableFilterComposer,
    $$ParticipantsTableOrderingComposer,
    $$ParticipantsTableAnnotationComposer,
    $$ParticipantsTableCreateCompanionBuilder,
    $$ParticipantsTableUpdateCompanionBuilder,
    (Participant, $$ParticipantsTableReferences),
    Participant,
    PrefetchHooks Function({bool conversationId, bool contactId})>;
typedef $$MessagesTableCreateCompanionBuilder = MessagesCompanion Function({
  Value<int> id,
  Value<String?> messageIdentifier,
  required String conversationId,
  required String senderType,
  Value<String> role,
  required String content,
  Value<String?> contentSearchTerms,
  Value<String> format,
  Value<String> status,
  Value<int?> tokenCount,
  Value<String?> parentIdentifier,
  Value<int?> variantGroup,
  Value<bool> isVisible,
  Value<String?> metadata,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$MessagesTableUpdateCompanionBuilder = MessagesCompanion Function({
  Value<int> id,
  Value<String?> messageIdentifier,
  Value<String> conversationId,
  Value<String> senderType,
  Value<String> role,
  Value<String> content,
  Value<String?> contentSearchTerms,
  Value<String> format,
  Value<String> status,
  Value<int?> tokenCount,
  Value<String?> parentIdentifier,
  Value<int?> variantGroup,
  Value<bool> isVisible,
  Value<String?> metadata,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$MessagesTableReferences
    extends BaseReferences<_$AppDatabase, $MessagesTable, Message> {
  $$MessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) =>
      db.conversations.createAlias($_aliasNameGenerator(
          db.messages.conversationId, db.conversations.id));

  $$ConversationsTableProcessedTableManager? get conversationId {
    if ($_item.conversationId == null) return null;
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.id($_item.conversationId!));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GenerationsTable, List<Generation>>
      _generationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.generations,
          aliasName:
              $_aliasNameGenerator(db.messages.id, db.generations.messageId));

  $$GenerationsTableProcessedTableManager get generationsRefs {
    final manager = $$GenerationsTableTableManager($_db, $_db.generations)
        .filter((f) => f.messageId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_generationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$AttachmentsTable, List<Attachment>>
      _attachmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.attachments,
          aliasName:
              $_aliasNameGenerator(db.messages.id, db.attachments.messageId));

  $$AttachmentsTableProcessedTableManager get attachmentsRefs {
    final manager = $$AttachmentsTableTableManager($_db, $_db.attachments)
        .filter((f) => f.messageId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_attachmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get messageIdentifier => $composableBuilder(
      column: $table.messageIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get senderType => $composableBuilder(
      column: $table.senderType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contentSearchTerms => $composableBuilder(
      column: $table.contentSearchTerms,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tokenCount => $composableBuilder(
      column: $table.tokenCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentIdentifier => $composableBuilder(
      column: $table.parentIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get variantGroup => $composableBuilder(
      column: $table.variantGroup, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isVisible => $composableBuilder(
      column: $table.isVisible, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> generationsRefs(
      Expression<bool> Function($$GenerationsTableFilterComposer f) f) {
    final $$GenerationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.generations,
        getReferencedColumn: (t) => t.messageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GenerationsTableFilterComposer(
              $db: $db,
              $table: $db.generations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> attachmentsRefs(
      Expression<bool> Function($$AttachmentsTableFilterComposer f) f) {
    final $$AttachmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attachments,
        getReferencedColumn: (t) => t.messageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttachmentsTableFilterComposer(
              $db: $db,
              $table: $db.attachments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get messageIdentifier => $composableBuilder(
      column: $table.messageIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get senderType => $composableBuilder(
      column: $table.senderType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contentSearchTerms => $composableBuilder(
      column: $table.contentSearchTerms,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get format => $composableBuilder(
      column: $table.format, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tokenCount => $composableBuilder(
      column: $table.tokenCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentIdentifier => $composableBuilder(
      column: $table.parentIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get variantGroup => $composableBuilder(
      column: $table.variantGroup,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isVisible => $composableBuilder(
      column: $table.isVisible, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableOrderingComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get messageIdentifier => $composableBuilder(
      column: $table.messageIdentifier, builder: (column) => column);

  GeneratedColumn<String> get senderType => $composableBuilder(
      column: $table.senderType, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get contentSearchTerms => $composableBuilder(
      column: $table.contentSearchTerms, builder: (column) => column);

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get tokenCount => $composableBuilder(
      column: $table.tokenCount, builder: (column) => column);

  GeneratedColumn<String> get parentIdentifier => $composableBuilder(
      column: $table.parentIdentifier, builder: (column) => column);

  GeneratedColumn<int> get variantGroup => $composableBuilder(
      column: $table.variantGroup, builder: (column) => column);

  GeneratedColumn<bool> get isVisible =>
      $composableBuilder(column: $table.isVisible, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> generationsRefs<T extends Object>(
      Expression<T> Function($$GenerationsTableAnnotationComposer a) f) {
    final $$GenerationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.generations,
        getReferencedColumn: (t) => t.messageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GenerationsTableAnnotationComposer(
              $db: $db,
              $table: $db.generations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> attachmentsRefs<T extends Object>(
      Expression<T> Function($$AttachmentsTableAnnotationComposer a) f) {
    final $$AttachmentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.attachments,
        getReferencedColumn: (t) => t.messageId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AttachmentsTableAnnotationComposer(
              $db: $db,
              $table: $db.attachments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MessagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (Message, $$MessagesTableReferences),
    Message,
    PrefetchHooks Function(
        {bool conversationId, bool generationsRefs, bool attachmentsRefs})> {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> messageIdentifier = const Value.absent(),
            Value<String> conversationId = const Value.absent(),
            Value<String> senderType = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> contentSearchTerms = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> tokenCount = const Value.absent(),
            Value<String?> parentIdentifier = const Value.absent(),
            Value<int?> variantGroup = const Value.absent(),
            Value<bool> isVisible = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              MessagesCompanion(
            id: id,
            messageIdentifier: messageIdentifier,
            conversationId: conversationId,
            senderType: senderType,
            role: role,
            content: content,
            contentSearchTerms: contentSearchTerms,
            format: format,
            status: status,
            tokenCount: tokenCount,
            parentIdentifier: parentIdentifier,
            variantGroup: variantGroup,
            isVisible: isVisible,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> messageIdentifier = const Value.absent(),
            required String conversationId,
            required String senderType,
            Value<String> role = const Value.absent(),
            required String content,
            Value<String?> contentSearchTerms = const Value.absent(),
            Value<String> format = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int?> tokenCount = const Value.absent(),
            Value<String?> parentIdentifier = const Value.absent(),
            Value<int?> variantGroup = const Value.absent(),
            Value<bool> isVisible = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              MessagesCompanion.insert(
            id: id,
            messageIdentifier: messageIdentifier,
            conversationId: conversationId,
            senderType: senderType,
            role: role,
            content: content,
            contentSearchTerms: contentSearchTerms,
            format: format,
            status: status,
            tokenCount: tokenCount,
            parentIdentifier: parentIdentifier,
            variantGroup: variantGroup,
            isVisible: isVisible,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MessagesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {conversationId = false,
              generationsRefs = false,
              attachmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (generationsRefs) db.generations,
                if (attachmentsRefs) db.attachments
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (conversationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.conversationId,
                    referencedTable:
                        $$MessagesTableReferences._conversationIdTable(db),
                    referencedColumn:
                        $$MessagesTableReferences._conversationIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (generationsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MessagesTableReferences._generationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MessagesTableReferences(db, table, p0)
                                .generationsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.messageId == item.id),
                        typedResults: items),
                  if (attachmentsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable:
                            $$MessagesTableReferences._attachmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MessagesTableReferences(db, table, p0)
                                .attachmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.messageId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MessagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MessagesTable,
    Message,
    $$MessagesTableFilterComposer,
    $$MessagesTableOrderingComposer,
    $$MessagesTableAnnotationComposer,
    $$MessagesTableCreateCompanionBuilder,
    $$MessagesTableUpdateCompanionBuilder,
    (Message, $$MessagesTableReferences),
    Message,
    PrefetchHooks Function(
        {bool conversationId, bool generationsRefs, bool attachmentsRefs})>;
typedef $$GenerationsTableCreateCompanionBuilder = GenerationsCompanion
    Function({
  Value<int> id,
  required int messageId,
  Value<String?> parentIdentifier,
  Value<int> variantIndex,
  required String content,
  Value<String> paramsSnapshot,
  Value<double?> score,
  Value<DateTime> createdAt,
});
typedef $$GenerationsTableUpdateCompanionBuilder = GenerationsCompanion
    Function({
  Value<int> id,
  Value<int> messageId,
  Value<String?> parentIdentifier,
  Value<int> variantIndex,
  Value<String> content,
  Value<String> paramsSnapshot,
  Value<double?> score,
  Value<DateTime> createdAt,
});

final class $$GenerationsTableReferences
    extends BaseReferences<_$AppDatabase, $GenerationsTable, Generation> {
  $$GenerationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MessagesTable _messageIdTable(_$AppDatabase db) =>
      db.messages.createAlias(
          $_aliasNameGenerator(db.generations.messageId, db.messages.id));

  $$MessagesTableProcessedTableManager? get messageId {
    if ($_item.messageId == null) return null;
    final manager = $$MessagesTableTableManager($_db, $_db.messages)
        .filter((f) => f.id($_item.messageId!));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GenerationsTableFilterComposer
    extends Composer<_$AppDatabase, $GenerationsTable> {
  $$GenerationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentIdentifier => $composableBuilder(
      column: $table.parentIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get variantIndex => $composableBuilder(
      column: $table.variantIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paramsSnapshot => $composableBuilder(
      column: $table.paramsSnapshot,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableFilterComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GenerationsTableOrderingComposer
    extends Composer<_$AppDatabase, $GenerationsTable> {
  $$GenerationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentIdentifier => $composableBuilder(
      column: $table.parentIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get variantIndex => $composableBuilder(
      column: $table.variantIndex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paramsSnapshot => $composableBuilder(
      column: $table.paramsSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableOrderingComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GenerationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenerationsTable> {
  $$GenerationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get parentIdentifier => $composableBuilder(
      column: $table.parentIdentifier, builder: (column) => column);

  GeneratedColumn<int> get variantIndex => $composableBuilder(
      column: $table.variantIndex, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get paramsSnapshot => $composableBuilder(
      column: $table.paramsSnapshot, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GenerationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GenerationsTable,
    Generation,
    $$GenerationsTableFilterComposer,
    $$GenerationsTableOrderingComposer,
    $$GenerationsTableAnnotationComposer,
    $$GenerationsTableCreateCompanionBuilder,
    $$GenerationsTableUpdateCompanionBuilder,
    (Generation, $$GenerationsTableReferences),
    Generation,
    PrefetchHooks Function({bool messageId})> {
  $$GenerationsTableTableManager(_$AppDatabase db, $GenerationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenerationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenerationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenerationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> messageId = const Value.absent(),
            Value<String?> parentIdentifier = const Value.absent(),
            Value<int> variantIndex = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> paramsSnapshot = const Value.absent(),
            Value<double?> score = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GenerationsCompanion(
            id: id,
            messageId: messageId,
            parentIdentifier: parentIdentifier,
            variantIndex: variantIndex,
            content: content,
            paramsSnapshot: paramsSnapshot,
            score: score,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int messageId,
            Value<String?> parentIdentifier = const Value.absent(),
            Value<int> variantIndex = const Value.absent(),
            required String content,
            Value<String> paramsSnapshot = const Value.absent(),
            Value<double?> score = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              GenerationsCompanion.insert(
            id: id,
            messageId: messageId,
            parentIdentifier: parentIdentifier,
            variantIndex: variantIndex,
            content: content,
            paramsSnapshot: paramsSnapshot,
            score: score,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GenerationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({messageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (messageId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.messageId,
                    referencedTable:
                        $$GenerationsTableReferences._messageIdTable(db),
                    referencedColumn:
                        $$GenerationsTableReferences._messageIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GenerationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GenerationsTable,
    Generation,
    $$GenerationsTableFilterComposer,
    $$GenerationsTableOrderingComposer,
    $$GenerationsTableAnnotationComposer,
    $$GenerationsTableCreateCompanionBuilder,
    $$GenerationsTableUpdateCompanionBuilder,
    (Generation, $$GenerationsTableReferences),
    Generation,
    PrefetchHooks Function({bool messageId})>;
typedef $$MemoryEntriesTableCreateCompanionBuilder = MemoryEntriesCompanion
    Function({
  Value<int> id,
  Value<String> scope,
  Value<String?> conversationId,
  required String type,
  required String content,
  Value<String> triggers,
  Value<double> weight,
  Value<bool> pinned,
  Value<DateTime?> lastUsedAt,
  Value<String> metadata,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$MemoryEntriesTableUpdateCompanionBuilder = MemoryEntriesCompanion
    Function({
  Value<int> id,
  Value<String> scope,
  Value<String?> conversationId,
  Value<String> type,
  Value<String> content,
  Value<String> triggers,
  Value<double> weight,
  Value<bool> pinned,
  Value<DateTime?> lastUsedAt,
  Value<String> metadata,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$MemoryEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $MemoryEntriesTable, MemoryEntry> {
  $$MemoryEntriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ConversationsTable _conversationIdTable(_$AppDatabase db) =>
      db.conversations.createAlias($_aliasNameGenerator(
          db.memoryEntries.conversationId, db.conversations.id));

  $$ConversationsTableProcessedTableManager? get conversationId {
    if ($_item.conversationId == null) return null;
    final manager = $$ConversationsTableTableManager($_db, $_db.conversations)
        .filter((f) => f.id($_item.conversationId!));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MemoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MemoryEntriesTable> {
  $$MemoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scope => $composableBuilder(
      column: $table.scope, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get triggers => $composableBuilder(
      column: $table.triggers, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ConversationsTableFilterComposer get conversationId {
    final $$ConversationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableFilterComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MemoryEntriesTable> {
  $$MemoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scope => $composableBuilder(
      column: $table.scope, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get triggers => $composableBuilder(
      column: $table.triggers, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get pinned => $composableBuilder(
      column: $table.pinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ConversationsTableOrderingComposer get conversationId {
    final $$ConversationsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableOrderingComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MemoryEntriesTable> {
  $$MemoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get triggers =>
      $composableBuilder(column: $table.triggers, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
      column: $table.lastUsedAt, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ConversationsTableAnnotationComposer get conversationId {
    final $$ConversationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.conversationId,
        referencedTable: $db.conversations,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConversationsTableAnnotationComposer(
              $db: $db,
              $table: $db.conversations,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MemoryEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MemoryEntriesTable,
    MemoryEntry,
    $$MemoryEntriesTableFilterComposer,
    $$MemoryEntriesTableOrderingComposer,
    $$MemoryEntriesTableAnnotationComposer,
    $$MemoryEntriesTableCreateCompanionBuilder,
    $$MemoryEntriesTableUpdateCompanionBuilder,
    (MemoryEntry, $$MemoryEntriesTableReferences),
    MemoryEntry,
    PrefetchHooks Function({bool conversationId})> {
  $$MemoryEntriesTableTableManager(_$AppDatabase db, $MemoryEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MemoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MemoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MemoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> scope = const Value.absent(),
            Value<String?> conversationId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> triggers = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<bool> pinned = const Value.absent(),
            Value<DateTime?> lastUsedAt = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              MemoryEntriesCompanion(
            id: id,
            scope: scope,
            conversationId: conversationId,
            type: type,
            content: content,
            triggers: triggers,
            weight: weight,
            pinned: pinned,
            lastUsedAt: lastUsedAt,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> scope = const Value.absent(),
            Value<String?> conversationId = const Value.absent(),
            required String type,
            required String content,
            Value<String> triggers = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<bool> pinned = const Value.absent(),
            Value<DateTime?> lastUsedAt = const Value.absent(),
            Value<String> metadata = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              MemoryEntriesCompanion.insert(
            id: id,
            scope: scope,
            conversationId: conversationId,
            type: type,
            content: content,
            triggers: triggers,
            weight: weight,
            pinned: pinned,
            lastUsedAt: lastUsedAt,
            metadata: metadata,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MemoryEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (conversationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.conversationId,
                    referencedTable:
                        $$MemoryEntriesTableReferences._conversationIdTable(db),
                    referencedColumn: $$MemoryEntriesTableReferences
                        ._conversationIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MemoryEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MemoryEntriesTable,
    MemoryEntry,
    $$MemoryEntriesTableFilterComposer,
    $$MemoryEntriesTableOrderingComposer,
    $$MemoryEntriesTableAnnotationComposer,
    $$MemoryEntriesTableCreateCompanionBuilder,
    $$MemoryEntriesTableUpdateCompanionBuilder,
    (MemoryEntry, $$MemoryEntriesTableReferences),
    MemoryEntry,
    PrefetchHooks Function({bool conversationId})>;
typedef $$AttachmentsTableCreateCompanionBuilder = AttachmentsCompanion
    Function({
  Value<int> id,
  required int messageId,
  required String type,
  required String path,
  Value<String?> thumbnailPath,
  Value<String?> mimeType,
  Value<int?> size,
  Value<int?> width,
  Value<int?> height,
  Value<String?> sha256,
  Value<String> extra,
  Value<DateTime> createdAt,
});
typedef $$AttachmentsTableUpdateCompanionBuilder = AttachmentsCompanion
    Function({
  Value<int> id,
  Value<int> messageId,
  Value<String> type,
  Value<String> path,
  Value<String?> thumbnailPath,
  Value<String?> mimeType,
  Value<int?> size,
  Value<int?> width,
  Value<int?> height,
  Value<String?> sha256,
  Value<String> extra,
  Value<DateTime> createdAt,
});

final class $$AttachmentsTableReferences
    extends BaseReferences<_$AppDatabase, $AttachmentsTable, Attachment> {
  $$AttachmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MessagesTable _messageIdTable(_$AppDatabase db) =>
      db.messages.createAlias(
          $_aliasNameGenerator(db.attachments.messageId, db.messages.id));

  $$MessagesTableProcessedTableManager? get messageId {
    if ($_item.messageId == null) return null;
    final manager = $$MessagesTableTableManager($_db, $_db.messages)
        .filter((f) => f.id($_item.messageId!));
    final item = $_typedResult.readTableOrNull(_messageIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
      column: $table.thumbnailPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sha256 => $composableBuilder(
      column: $table.sha256, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extra => $composableBuilder(
      column: $table.extra, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$MessagesTableFilterComposer get messageId {
    final $$MessagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableFilterComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
      column: $table.thumbnailPath,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mimeType => $composableBuilder(
      column: $table.mimeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sha256 => $composableBuilder(
      column: $table.sha256, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extra => $composableBuilder(
      column: $table.extra, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$MessagesTableOrderingComposer get messageId {
    final $$MessagesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableOrderingComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
      column: $table.thumbnailPath, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<String> get extra =>
      $composableBuilder(column: $table.extra, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MessagesTableAnnotationComposer get messageId {
    final $$MessagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.messageId,
        referencedTable: $db.messages,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MessagesTableAnnotationComposer(
              $db: $db,
              $table: $db.messages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$AttachmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AttachmentsTable,
    Attachment,
    $$AttachmentsTableFilterComposer,
    $$AttachmentsTableOrderingComposer,
    $$AttachmentsTableAnnotationComposer,
    $$AttachmentsTableCreateCompanionBuilder,
    $$AttachmentsTableUpdateCompanionBuilder,
    (Attachment, $$AttachmentsTableReferences),
    Attachment,
    PrefetchHooks Function({bool messageId})> {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> messageId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String?> thumbnailPath = const Value.absent(),
            Value<String?> mimeType = const Value.absent(),
            Value<int?> size = const Value.absent(),
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<String?> sha256 = const Value.absent(),
            Value<String> extra = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AttachmentsCompanion(
            id: id,
            messageId: messageId,
            type: type,
            path: path,
            thumbnailPath: thumbnailPath,
            mimeType: mimeType,
            size: size,
            width: width,
            height: height,
            sha256: sha256,
            extra: extra,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int messageId,
            required String type,
            required String path,
            Value<String?> thumbnailPath = const Value.absent(),
            Value<String?> mimeType = const Value.absent(),
            Value<int?> size = const Value.absent(),
            Value<int?> width = const Value.absent(),
            Value<int?> height = const Value.absent(),
            Value<String?> sha256 = const Value.absent(),
            Value<String> extra = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              AttachmentsCompanion.insert(
            id: id,
            messageId: messageId,
            type: type,
            path: path,
            thumbnailPath: thumbnailPath,
            mimeType: mimeType,
            size: size,
            width: width,
            height: height,
            sha256: sha256,
            extra: extra,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AttachmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({messageId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (messageId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.messageId,
                    referencedTable:
                        $$AttachmentsTableReferences._messageIdTable(db),
                    referencedColumn:
                        $$AttachmentsTableReferences._messageIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$AttachmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AttachmentsTable,
    Attachment,
    $$AttachmentsTableFilterComposer,
    $$AttachmentsTableOrderingComposer,
    $$AttachmentsTableAnnotationComposer,
    $$AttachmentsTableCreateCompanionBuilder,
    $$AttachmentsTableUpdateCompanionBuilder,
    (Attachment, $$AttachmentsTableReferences),
    Attachment,
    PrefetchHooks Function({bool messageId})>;
typedef $$MomentsTableCreateCompanionBuilder = MomentsCompanion Function({
  required String id,
  Value<String?> authorId,
  required String content,
  Value<String> mediaJson,
  Value<String> visibility,
  Value<bool> allowComments,
  Value<int> likeCount,
  Value<int> commentCount,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$MomentsTableUpdateCompanionBuilder = MomentsCompanion Function({
  Value<String> id,
  Value<String?> authorId,
  Value<String> content,
  Value<String> mediaJson,
  Value<String> visibility,
  Value<bool> allowComments,
  Value<int> likeCount,
  Value<int> commentCount,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$MomentsTableReferences
    extends BaseReferences<_$AppDatabase, $MomentsTable, Moment> {
  $$MomentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContactsTable _authorIdTable(_$AppDatabase db) => db.contacts
      .createAlias($_aliasNameGenerator(db.moments.authorId, db.contacts.id));

  $$ContactsTableProcessedTableManager? get authorId {
    if ($_item.authorId == null) return null;
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id($_item.authorId!));
    final item = $_typedResult.readTableOrNull(_authorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MomentReactionsTable, List<MomentReaction>>
      _momentReactionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.momentReactions,
              aliasName: $_aliasNameGenerator(
                  db.moments.id, db.momentReactions.momentId));

  $$MomentReactionsTableProcessedTableManager get momentReactionsRefs {
    final manager =
        $$MomentReactionsTableTableManager($_db, $_db.momentReactions)
            .filter((f) => f.momentId.id($_item.id));

    final cache =
        $_typedResult.readTableOrNull(_momentReactionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MomentsTableFilterComposer
    extends Composer<_$AppDatabase, $MomentsTable> {
  $$MomentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaJson => $composableBuilder(
      column: $table.mediaJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowComments => $composableBuilder(
      column: $table.allowComments, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get likeCount => $composableBuilder(
      column: $table.likeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get commentCount => $composableBuilder(
      column: $table.commentCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ContactsTableFilterComposer get authorId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.authorId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> momentReactionsRefs(
      Expression<bool> Function($$MomentReactionsTableFilterComposer f) f) {
    final $$MomentReactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.momentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableFilterComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MomentsTableOrderingComposer
    extends Composer<_$AppDatabase, $MomentsTable> {
  $$MomentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaJson => $composableBuilder(
      column: $table.mediaJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowComments => $composableBuilder(
      column: $table.allowComments,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get likeCount => $composableBuilder(
      column: $table.likeCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get commentCount => $composableBuilder(
      column: $table.commentCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ContactsTableOrderingComposer get authorId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.authorId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MomentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MomentsTable> {
  $$MomentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get mediaJson =>
      $composableBuilder(column: $table.mediaJson, builder: (column) => column);

  GeneratedColumn<String> get visibility => $composableBuilder(
      column: $table.visibility, builder: (column) => column);

  GeneratedColumn<bool> get allowComments => $composableBuilder(
      column: $table.allowComments, builder: (column) => column);

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

  GeneratedColumn<int> get commentCount => $composableBuilder(
      column: $table.commentCount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ContactsTableAnnotationComposer get authorId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.authorId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> momentReactionsRefs<T extends Object>(
      Expression<T> Function($$MomentReactionsTableAnnotationComposer a) f) {
    final $$MomentReactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.momentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MomentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MomentsTable,
    Moment,
    $$MomentsTableFilterComposer,
    $$MomentsTableOrderingComposer,
    $$MomentsTableAnnotationComposer,
    $$MomentsTableCreateCompanionBuilder,
    $$MomentsTableUpdateCompanionBuilder,
    (Moment, $$MomentsTableReferences),
    Moment,
    PrefetchHooks Function({bool authorId, bool momentReactionsRefs})> {
  $$MomentsTableTableManager(_$AppDatabase db, $MomentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MomentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MomentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MomentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> authorId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> mediaJson = const Value.absent(),
            Value<String> visibility = const Value.absent(),
            Value<bool> allowComments = const Value.absent(),
            Value<int> likeCount = const Value.absent(),
            Value<int> commentCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MomentsCompanion(
            id: id,
            authorId: authorId,
            content: content,
            mediaJson: mediaJson,
            visibility: visibility,
            allowComments: allowComments,
            likeCount: likeCount,
            commentCount: commentCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> authorId = const Value.absent(),
            required String content,
            Value<String> mediaJson = const Value.absent(),
            Value<String> visibility = const Value.absent(),
            Value<bool> allowComments = const Value.absent(),
            Value<int> likeCount = const Value.absent(),
            Value<int> commentCount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MomentsCompanion.insert(
            id: id,
            authorId: authorId,
            content: content,
            mediaJson: mediaJson,
            visibility: visibility,
            allowComments: allowComments,
            likeCount: likeCount,
            commentCount: commentCount,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$MomentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {authorId = false, momentReactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (momentReactionsRefs) db.momentReactions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (authorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.authorId,
                    referencedTable:
                        $$MomentsTableReferences._authorIdTable(db),
                    referencedColumn:
                        $$MomentsTableReferences._authorIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (momentReactionsRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$MomentsTableReferences
                            ._momentReactionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MomentsTableReferences(db, table, p0)
                                .momentReactionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.momentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MomentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MomentsTable,
    Moment,
    $$MomentsTableFilterComposer,
    $$MomentsTableOrderingComposer,
    $$MomentsTableAnnotationComposer,
    $$MomentsTableCreateCompanionBuilder,
    $$MomentsTableUpdateCompanionBuilder,
    (Moment, $$MomentsTableReferences),
    Moment,
    PrefetchHooks Function({bool authorId, bool momentReactionsRefs})>;
typedef $$MomentReactionsTableCreateCompanionBuilder = MomentReactionsCompanion
    Function({
  Value<int> id,
  required String momentId,
  Value<String?> contactId,
  Value<String> type,
  Value<String> content,
  Value<int?> replyToReactionId,
  Value<DateTime> createdAt,
});
typedef $$MomentReactionsTableUpdateCompanionBuilder = MomentReactionsCompanion
    Function({
  Value<int> id,
  Value<String> momentId,
  Value<String?> contactId,
  Value<String> type,
  Value<String> content,
  Value<int?> replyToReactionId,
  Value<DateTime> createdAt,
});

final class $$MomentReactionsTableReferences extends BaseReferences<
    _$AppDatabase, $MomentReactionsTable, MomentReaction> {
  $$MomentReactionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MomentsTable _momentIdTable(_$AppDatabase db) =>
      db.moments.createAlias(
          $_aliasNameGenerator(db.momentReactions.momentId, db.moments.id));

  $$MomentsTableProcessedTableManager? get momentId {
    if ($_item.momentId == null) return null;
    final manager = $$MomentsTableTableManager($_db, $_db.moments)
        .filter((f) => f.id($_item.momentId!));
    final item = $_typedResult.readTableOrNull(_momentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias(
          $_aliasNameGenerator(db.momentReactions.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager? get contactId {
    if ($_item.contactId == null) return null;
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id($_item.contactId!));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MomentReactionsTable _replyToReactionIdTable(_$AppDatabase db) =>
      db.momentReactions.createAlias($_aliasNameGenerator(
          db.momentReactions.replyToReactionId, db.momentReactions.id));

  $$MomentReactionsTableProcessedTableManager? get replyToReactionId {
    if ($_item.replyToReactionId == null) return null;
    final manager =
        $$MomentReactionsTableTableManager($_db, $_db.momentReactions)
            .filter((f) => f.id($_item.replyToReactionId!));
    final item = $_typedResult.readTableOrNull(_replyToReactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MomentReactionsTableFilterComposer
    extends Composer<_$AppDatabase, $MomentReactionsTable> {
  $$MomentReactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$MomentsTableFilterComposer get momentId {
    final $$MomentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.momentId,
        referencedTable: $db.moments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentsTableFilterComposer(
              $db: $db,
              $table: $db.moments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MomentReactionsTableFilterComposer get replyToReactionId {
    final $$MomentReactionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.replyToReactionId,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableFilterComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MomentReactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MomentReactionsTable> {
  $$MomentReactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$MomentsTableOrderingComposer get momentId {
    final $$MomentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.momentId,
        referencedTable: $db.moments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentsTableOrderingComposer(
              $db: $db,
              $table: $db.moments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MomentReactionsTableOrderingComposer get replyToReactionId {
    final $$MomentReactionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.replyToReactionId,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableOrderingComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MomentReactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MomentReactionsTable> {
  $$MomentReactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MomentsTableAnnotationComposer get momentId {
    final $$MomentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.momentId,
        referencedTable: $db.moments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentsTableAnnotationComposer(
              $db: $db,
              $table: $db.moments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$MomentReactionsTableAnnotationComposer get replyToReactionId {
    final $$MomentReactionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.replyToReactionId,
        referencedTable: $db.momentReactions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MomentReactionsTableAnnotationComposer(
              $db: $db,
              $table: $db.momentReactions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MomentReactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MomentReactionsTable,
    MomentReaction,
    $$MomentReactionsTableFilterComposer,
    $$MomentReactionsTableOrderingComposer,
    $$MomentReactionsTableAnnotationComposer,
    $$MomentReactionsTableCreateCompanionBuilder,
    $$MomentReactionsTableUpdateCompanionBuilder,
    (MomentReaction, $$MomentReactionsTableReferences),
    MomentReaction,
    PrefetchHooks Function(
        {bool momentId, bool contactId, bool replyToReactionId})> {
  $$MomentReactionsTableTableManager(
      _$AppDatabase db, $MomentReactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MomentReactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MomentReactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MomentReactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> momentId = const Value.absent(),
            Value<String?> contactId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int?> replyToReactionId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MomentReactionsCompanion(
            id: id,
            momentId: momentId,
            contactId: contactId,
            type: type,
            content: content,
            replyToReactionId: replyToReactionId,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String momentId,
            Value<String?> contactId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int?> replyToReactionId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              MomentReactionsCompanion.insert(
            id: id,
            momentId: momentId,
            contactId: contactId,
            type: type,
            content: content,
            replyToReactionId: replyToReactionId,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MomentReactionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {momentId = false,
              contactId = false,
              replyToReactionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (momentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.momentId,
                    referencedTable:
                        $$MomentReactionsTableReferences._momentIdTable(db),
                    referencedColumn:
                        $$MomentReactionsTableReferences._momentIdTable(db).id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$MomentReactionsTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$MomentReactionsTableReferences._contactIdTable(db).id,
                  ) as T;
                }
                if (replyToReactionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.replyToReactionId,
                    referencedTable: $$MomentReactionsTableReferences
                        ._replyToReactionIdTable(db),
                    referencedColumn: $$MomentReactionsTableReferences
                        ._replyToReactionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MomentReactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MomentReactionsTable,
    MomentReaction,
    $$MomentReactionsTableFilterComposer,
    $$MomentReactionsTableOrderingComposer,
    $$MomentReactionsTableAnnotationComposer,
    $$MomentReactionsTableCreateCompanionBuilder,
    $$MomentReactionsTableUpdateCompanionBuilder,
    (MomentReaction, $$MomentReactionsTableReferences),
    MomentReaction,
    PrefetchHooks Function(
        {bool momentId, bool contactId, bool replyToReactionId})>;
typedef $$AppPreferencesTableCreateCompanionBuilder = AppPreferencesCompanion
    Function({
  required String key,
  required String value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$AppPreferencesTableUpdateCompanionBuilder = AppPreferencesCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AppPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppPreferencesTable> {
  $$AppPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppPreferencesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppPreferencesTable,
    AppPreference,
    $$AppPreferencesTableFilterComposer,
    $$AppPreferencesTableOrderingComposer,
    $$AppPreferencesTableAnnotationComposer,
    $$AppPreferencesTableCreateCompanionBuilder,
    $$AppPreferencesTableUpdateCompanionBuilder,
    (
      AppPreference,
      BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreference>
    ),
    AppPreference,
    PrefetchHooks Function()> {
  $$AppPreferencesTableTableManager(
      _$AppDatabase db, $AppPreferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppPreferencesCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppPreferencesCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppPreferencesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppPreferencesTable,
    AppPreference,
    $$AppPreferencesTableFilterComposer,
    $$AppPreferencesTableOrderingComposer,
    $$AppPreferencesTableAnnotationComposer,
    $$AppPreferencesTableCreateCompanionBuilder,
    $$AppPreferencesTableUpdateCompanionBuilder,
    (
      AppPreference,
      BaseReferences<_$AppDatabase, $AppPreferencesTable, AppPreference>
    ),
    AppPreference,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProviderProfilesTableTableManager get providerProfiles =>
      $$ProviderProfilesTableTableManager(_db, _db.providerProfiles);
  $$ProviderKeysTableTableManager get providerKeys =>
      $$ProviderKeysTableTableManager(_db, _db.providerKeys);
  $$ModelPresetsTableTableManager get modelPresets =>
      $$ModelPresetsTableTableManager(_db, _db.modelPresets);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$ConversationsTableTableManager get conversations =>
      $$ConversationsTableTableManager(_db, _db.conversations);
  $$ParticipantsTableTableManager get participants =>
      $$ParticipantsTableTableManager(_db, _db.participants);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$GenerationsTableTableManager get generations =>
      $$GenerationsTableTableManager(_db, _db.generations);
  $$MemoryEntriesTableTableManager get memoryEntries =>
      $$MemoryEntriesTableTableManager(_db, _db.memoryEntries);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
  $$MomentsTableTableManager get moments =>
      $$MomentsTableTableManager(_db, _db.moments);
  $$MomentReactionsTableTableManager get momentReactions =>
      $$MomentReactionsTableTableManager(_db, _db.momentReactions);
  $$AppPreferencesTableTableManager get appPreferences =>
      $$AppPreferencesTableTableManager(_db, _db.appPreferences);
}
