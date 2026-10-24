// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProgressRowsTable extends ProgressRows
    with TableInfo<$ProgressRowsTable, ProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
    'stars',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unlockedWorldsMeta = const VerificationMeta(
    'unlockedWorlds',
  );
  @override
  late final GeneratedColumn<String> unlockedWorlds = GeneratedColumn<String>(
    'unlocked_worlds',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('arabic,manners,garden'),
  );
  static const VerificationMeta _completedGamesMeta = const VerificationMeta(
    'completedGames',
  );
  @override
  late final GeneratedColumn<String> completedGames = GeneratedColumn<String>(
    'completed_games',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _mapVisitedMeta = const VerificationMeta(
    'mapVisited',
  );
  @override
  late final GeneratedColumn<bool> mapVisited = GeneratedColumn<bool>(
    'map_visited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("map_visited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _arabicStagesMeta = const VerificationMeta(
    'arabicStages',
  );
  @override
  late final GeneratedColumn<String> arabicStages = GeneratedColumn<String>(
    'arabic_stages',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('stage_1'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stars,
    xp,
    unlockedWorlds,
    completedGames,
    mapVisited,
    arabicStages,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('stars')) {
      context.handle(
        _starsMeta,
        stars.isAcceptableOrUnknown(data['stars']!, _starsMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('unlocked_worlds')) {
      context.handle(
        _unlockedWorldsMeta,
        unlockedWorlds.isAcceptableOrUnknown(
          data['unlocked_worlds']!,
          _unlockedWorldsMeta,
        ),
      );
    }
    if (data.containsKey('completed_games')) {
      context.handle(
        _completedGamesMeta,
        completedGames.isAcceptableOrUnknown(
          data['completed_games']!,
          _completedGamesMeta,
        ),
      );
    }
    if (data.containsKey('map_visited')) {
      context.handle(
        _mapVisitedMeta,
        mapVisited.isAcceptableOrUnknown(data['map_visited']!, _mapVisitedMeta),
      );
    }
    if (data.containsKey('arabic_stages')) {
      context.handle(
        _arabicStagesMeta,
        arabicStages.isAcceptableOrUnknown(
          data['arabic_stages']!,
          _arabicStagesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stars: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stars'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      unlockedWorlds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unlocked_worlds'],
      )!,
      completedGames: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}completed_games'],
      )!,
      mapVisited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}map_visited'],
      )!,
      arabicStages: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_stages'],
      )!,
    );
  }

  @override
  $ProgressRowsTable createAlias(String alias) {
    return $ProgressRowsTable(attachedDatabase, alias);
  }
}

class ProgressRow extends DataClass implements Insertable<ProgressRow> {
  final int id;
  final int stars;
  final int xp;
  final String unlockedWorlds;
  final String completedGames;
  final bool mapVisited;

  /// V2: comma-separated stage ids unlocked on Arabic pathway.
  final String arabicStages;
  const ProgressRow({
    required this.id,
    required this.stars,
    required this.xp,
    required this.unlockedWorlds,
    required this.completedGames,
    required this.mapVisited,
    required this.arabicStages,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['stars'] = Variable<int>(stars);
    map['xp'] = Variable<int>(xp);
    map['unlocked_worlds'] = Variable<String>(unlockedWorlds);
    map['completed_games'] = Variable<String>(completedGames);
    map['map_visited'] = Variable<bool>(mapVisited);
    map['arabic_stages'] = Variable<String>(arabicStages);
    return map;
  }

  ProgressRowsCompanion toCompanion(bool nullToAbsent) {
    return ProgressRowsCompanion(
      id: Value(id),
      stars: Value(stars),
      xp: Value(xp),
      unlockedWorlds: Value(unlockedWorlds),
      completedGames: Value(completedGames),
      mapVisited: Value(mapVisited),
      arabicStages: Value(arabicStages),
    );
  }

  factory ProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressRow(
      id: serializer.fromJson<int>(json['id']),
      stars: serializer.fromJson<int>(json['stars']),
      xp: serializer.fromJson<int>(json['xp']),
      unlockedWorlds: serializer.fromJson<String>(json['unlockedWorlds']),
      completedGames: serializer.fromJson<String>(json['completedGames']),
      mapVisited: serializer.fromJson<bool>(json['mapVisited']),
      arabicStages: serializer.fromJson<String>(json['arabicStages']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stars': serializer.toJson<int>(stars),
      'xp': serializer.toJson<int>(xp),
      'unlockedWorlds': serializer.toJson<String>(unlockedWorlds),
      'completedGames': serializer.toJson<String>(completedGames),
      'mapVisited': serializer.toJson<bool>(mapVisited),
      'arabicStages': serializer.toJson<String>(arabicStages),
    };
  }

  ProgressRow copyWith({
    int? id,
    int? stars,
    int? xp,
    String? unlockedWorlds,
    String? completedGames,
    bool? mapVisited,
    String? arabicStages,
  }) => ProgressRow(
    id: id ?? this.id,
    stars: stars ?? this.stars,
    xp: xp ?? this.xp,
    unlockedWorlds: unlockedWorlds ?? this.unlockedWorlds,
    completedGames: completedGames ?? this.completedGames,
    mapVisited: mapVisited ?? this.mapVisited,
    arabicStages: arabicStages ?? this.arabicStages,
  );
  ProgressRow copyWithCompanion(ProgressRowsCompanion data) {
    return ProgressRow(
      id: data.id.present ? data.id.value : this.id,
      stars: data.stars.present ? data.stars.value : this.stars,
      xp: data.xp.present ? data.xp.value : this.xp,
      unlockedWorlds: data.unlockedWorlds.present
          ? data.unlockedWorlds.value
          : this.unlockedWorlds,
      completedGames: data.completedGames.present
          ? data.completedGames.value
          : this.completedGames,
      mapVisited: data.mapVisited.present
          ? data.mapVisited.value
          : this.mapVisited,
      arabicStages: data.arabicStages.present
          ? data.arabicStages.value
          : this.arabicStages,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressRow(')
          ..write('id: $id, ')
          ..write('stars: $stars, ')
          ..write('xp: $xp, ')
          ..write('unlockedWorlds: $unlockedWorlds, ')
          ..write('completedGames: $completedGames, ')
          ..write('mapVisited: $mapVisited, ')
          ..write('arabicStages: $arabicStages')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stars,
    xp,
    unlockedWorlds,
    completedGames,
    mapVisited,
    arabicStages,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressRow &&
          other.id == this.id &&
          other.stars == this.stars &&
          other.xp == this.xp &&
          other.unlockedWorlds == this.unlockedWorlds &&
          other.completedGames == this.completedGames &&
          other.mapVisited == this.mapVisited &&
          other.arabicStages == this.arabicStages);
}

class ProgressRowsCompanion extends UpdateCompanion<ProgressRow> {
  final Value<int> id;
  final Value<int> stars;
  final Value<int> xp;
  final Value<String> unlockedWorlds;
  final Value<String> completedGames;
  final Value<bool> mapVisited;
  final Value<String> arabicStages;
  const ProgressRowsCompanion({
    this.id = const Value.absent(),
    this.stars = const Value.absent(),
    this.xp = const Value.absent(),
    this.unlockedWorlds = const Value.absent(),
    this.completedGames = const Value.absent(),
    this.mapVisited = const Value.absent(),
    this.arabicStages = const Value.absent(),
  });
  ProgressRowsCompanion.insert({
    this.id = const Value.absent(),
    this.stars = const Value.absent(),
    this.xp = const Value.absent(),
    this.unlockedWorlds = const Value.absent(),
    this.completedGames = const Value.absent(),
    this.mapVisited = const Value.absent(),
    this.arabicStages = const Value.absent(),
  });
  static Insertable<ProgressRow> custom({
    Expression<int>? id,
    Expression<int>? stars,
    Expression<int>? xp,
    Expression<String>? unlockedWorlds,
    Expression<String>? completedGames,
    Expression<bool>? mapVisited,
    Expression<String>? arabicStages,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stars != null) 'stars': stars,
      if (xp != null) 'xp': xp,
      if (unlockedWorlds != null) 'unlocked_worlds': unlockedWorlds,
      if (completedGames != null) 'completed_games': completedGames,
      if (mapVisited != null) 'map_visited': mapVisited,
      if (arabicStages != null) 'arabic_stages': arabicStages,
    });
  }

  ProgressRowsCompanion copyWith({
    Value<int>? id,
    Value<int>? stars,
    Value<int>? xp,
    Value<String>? unlockedWorlds,
    Value<String>? completedGames,
    Value<bool>? mapVisited,
    Value<String>? arabicStages,
  }) {
    return ProgressRowsCompanion(
      id: id ?? this.id,
      stars: stars ?? this.stars,
      xp: xp ?? this.xp,
      unlockedWorlds: unlockedWorlds ?? this.unlockedWorlds,
      completedGames: completedGames ?? this.completedGames,
      mapVisited: mapVisited ?? this.mapVisited,
      arabicStages: arabicStages ?? this.arabicStages,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (unlockedWorlds.present) {
      map['unlocked_worlds'] = Variable<String>(unlockedWorlds.value);
    }
    if (completedGames.present) {
      map['completed_games'] = Variable<String>(completedGames.value);
    }
    if (mapVisited.present) {
      map['map_visited'] = Variable<bool>(mapVisited.value);
    }
    if (arabicStages.present) {
      map['arabic_stages'] = Variable<String>(arabicStages.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressRowsCompanion(')
          ..write('id: $id, ')
          ..write('stars: $stars, ')
          ..write('xp: $xp, ')
          ..write('unlockedWorlds: $unlockedWorlds, ')
          ..write('completedGames: $completedGames, ')
          ..write('mapVisited: $mapVisited, ')
          ..write('arabicStages: $arabicStages')
          ..write(')'))
        .toString();
  }
}

class $BadgeRowsTable extends BadgeRows
    with TableInfo<$BadgeRowsTable, BadgeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgeRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _earnedAtMeta = const VerificationMeta(
    'earnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> earnedAt = GeneratedColumn<DateTime>(
    'earned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, earnedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badge_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<BadgeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('earned_at')) {
      context.handle(
        _earnedAtMeta,
        earnedAt.isAcceptableOrUnknown(data['earned_at']!, _earnedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_earnedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BadgeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BadgeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      earnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}earned_at'],
      )!,
    );
  }

  @override
  $BadgeRowsTable createAlias(String alias) {
    return $BadgeRowsTable(attachedDatabase, alias);
  }
}

class BadgeRow extends DataClass implements Insertable<BadgeRow> {
  final String id;
  final DateTime earnedAt;
  const BadgeRow({required this.id, required this.earnedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['earned_at'] = Variable<DateTime>(earnedAt);
    return map;
  }

  BadgeRowsCompanion toCompanion(bool nullToAbsent) {
    return BadgeRowsCompanion(id: Value(id), earnedAt: Value(earnedAt));
  }

  factory BadgeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BadgeRow(
      id: serializer.fromJson<String>(json['id']),
      earnedAt: serializer.fromJson<DateTime>(json['earnedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'earnedAt': serializer.toJson<DateTime>(earnedAt),
    };
  }

  BadgeRow copyWith({String? id, DateTime? earnedAt}) =>
      BadgeRow(id: id ?? this.id, earnedAt: earnedAt ?? this.earnedAt);
  BadgeRow copyWithCompanion(BadgeRowsCompanion data) {
    return BadgeRow(
      id: data.id.present ? data.id.value : this.id,
      earnedAt: data.earnedAt.present ? data.earnedAt.value : this.earnedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BadgeRow(')
          ..write('id: $id, ')
          ..write('earnedAt: $earnedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, earnedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BadgeRow &&
          other.id == this.id &&
          other.earnedAt == this.earnedAt);
}

class BadgeRowsCompanion extends UpdateCompanion<BadgeRow> {
  final Value<String> id;
  final Value<DateTime> earnedAt;
  final Value<int> rowid;
  const BadgeRowsCompanion({
    this.id = const Value.absent(),
    this.earnedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BadgeRowsCompanion.insert({
    required String id,
    required DateTime earnedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       earnedAt = Value(earnedAt);
  static Insertable<BadgeRow> custom({
    Expression<String>? id,
    Expression<DateTime>? earnedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (earnedAt != null) 'earned_at': earnedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BadgeRowsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? earnedAt,
    Value<int>? rowid,
  }) {
    return BadgeRowsCompanion(
      id: id ?? this.id,
      earnedAt: earnedAt ?? this.earnedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (earnedAt.present) {
      map['earned_at'] = Variable<DateTime>(earnedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgeRowsCompanion(')
          ..write('id: $id, ')
          ..write('earnedAt: $earnedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileRowsTable extends ProfileRows
    with TableInfo<$ProfileRowsTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _avatarIndexMeta = const VerificationMeta(
    'avatarIndex',
  );
  @override
  late final GeneratedColumn<int> avatarIndex = GeneratedColumn<int>(
    'avatar_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _localeCodeMeta = const VerificationMeta(
    'localeCode',
  );
  @override
  late final GeneratedColumn<String> localeCode = GeneratedColumn<String>(
    'locale_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _audioEnabledMeta = const VerificationMeta(
    'audioEnabled',
  );
  @override
  late final GeneratedColumn<bool> audioEnabled = GeneratedColumn<bool>(
    'audio_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("audio_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reducedMotionMeta = const VerificationMeta(
    'reducedMotion',
  );
  @override
  late final GeneratedColumn<bool> reducedMotion = GeneratedColumn<bool>(
    'reduced_motion',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reduced_motion" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sessionRemindersMeta = const VerificationMeta(
    'sessionReminders',
  );
  @override
  late final GeneratedColumn<bool> sessionReminders = GeneratedColumn<bool>(
    'session_reminders',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("session_reminders" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _parentPinHashMeta = const VerificationMeta(
    'parentPinHash',
  );
  @override
  late final GeneratedColumn<String> parentPinHash = GeneratedColumn<String>(
    'parent_pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sfxVolumeMeta = const VerificationMeta(
    'sfxVolume',
  );
  @override
  late final GeneratedColumn<double> sfxVolume = GeneratedColumn<double>(
    'sfx_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.8),
  );
  static const VerificationMeta _entitlementMeta = const VerificationMeta(
    'entitlement',
  );
  @override
  late final GeneratedColumn<String> entitlement = GeneratedColumn<String>(
    'entitlement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('free'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    avatarIndex,
    localeCode,
    onboardingComplete,
    audioEnabled,
    reducedMotion,
    sessionReminders,
    parentPinHash,
    sfxVolume,
    entitlement,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('avatar_index')) {
      context.handle(
        _avatarIndexMeta,
        avatarIndex.isAcceptableOrUnknown(
          data['avatar_index']!,
          _avatarIndexMeta,
        ),
      );
    }
    if (data.containsKey('locale_code')) {
      context.handle(
        _localeCodeMeta,
        localeCode.isAcceptableOrUnknown(data['locale_code']!, _localeCodeMeta),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('audio_enabled')) {
      context.handle(
        _audioEnabledMeta,
        audioEnabled.isAcceptableOrUnknown(
          data['audio_enabled']!,
          _audioEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reduced_motion')) {
      context.handle(
        _reducedMotionMeta,
        reducedMotion.isAcceptableOrUnknown(
          data['reduced_motion']!,
          _reducedMotionMeta,
        ),
      );
    }
    if (data.containsKey('session_reminders')) {
      context.handle(
        _sessionRemindersMeta,
        sessionReminders.isAcceptableOrUnknown(
          data['session_reminders']!,
          _sessionRemindersMeta,
        ),
      );
    }
    if (data.containsKey('parent_pin_hash')) {
      context.handle(
        _parentPinHashMeta,
        parentPinHash.isAcceptableOrUnknown(
          data['parent_pin_hash']!,
          _parentPinHashMeta,
        ),
      );
    }
    if (data.containsKey('sfx_volume')) {
      context.handle(
        _sfxVolumeMeta,
        sfxVolume.isAcceptableOrUnknown(data['sfx_volume']!, _sfxVolumeMeta),
      );
    }
    if (data.containsKey('entitlement')) {
      context.handle(
        _entitlementMeta,
        entitlement.isAcceptableOrUnknown(
          data['entitlement']!,
          _entitlementMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      avatarIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avatar_index'],
      )!,
      localeCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale_code'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      audioEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}audio_enabled'],
      )!,
      reducedMotion: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reduced_motion'],
      )!,
      sessionReminders: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}session_reminders'],
      )!,
      parentPinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_pin_hash'],
      )!,
      sfxVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sfx_volume'],
      )!,
      entitlement: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entitlement'],
      )!,
    );
  }

  @override
  $ProfileRowsTable createAlias(String alias) {
    return $ProfileRowsTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final int id;
  final String displayName;
  final int avatarIndex;
  final String localeCode;
  final bool onboardingComplete;
  final bool audioEnabled;
  final bool reducedMotion;
  final bool sessionReminders;

  /// Optional parent PIN hash (simple local gate). Empty = math gate only.
  final String parentPinHash;
  final double sfxVolume;

  /// free | family_plus (entitlement stub; no live IAP).
  final String entitlement;
  const ProfileRow({
    required this.id,
    required this.displayName,
    required this.avatarIndex,
    required this.localeCode,
    required this.onboardingComplete,
    required this.audioEnabled,
    required this.reducedMotion,
    required this.sessionReminders,
    required this.parentPinHash,
    required this.sfxVolume,
    required this.entitlement,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['display_name'] = Variable<String>(displayName);
    map['avatar_index'] = Variable<int>(avatarIndex);
    map['locale_code'] = Variable<String>(localeCode);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['audio_enabled'] = Variable<bool>(audioEnabled);
    map['reduced_motion'] = Variable<bool>(reducedMotion);
    map['session_reminders'] = Variable<bool>(sessionReminders);
    map['parent_pin_hash'] = Variable<String>(parentPinHash);
    map['sfx_volume'] = Variable<double>(sfxVolume);
    map['entitlement'] = Variable<String>(entitlement);
    return map;
  }

  ProfileRowsCompanion toCompanion(bool nullToAbsent) {
    return ProfileRowsCompanion(
      id: Value(id),
      displayName: Value(displayName),
      avatarIndex: Value(avatarIndex),
      localeCode: Value(localeCode),
      onboardingComplete: Value(onboardingComplete),
      audioEnabled: Value(audioEnabled),
      reducedMotion: Value(reducedMotion),
      sessionReminders: Value(sessionReminders),
      parentPinHash: Value(parentPinHash),
      sfxVolume: Value(sfxVolume),
      entitlement: Value(entitlement),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<int>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      avatarIndex: serializer.fromJson<int>(json['avatarIndex']),
      localeCode: serializer.fromJson<String>(json['localeCode']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      audioEnabled: serializer.fromJson<bool>(json['audioEnabled']),
      reducedMotion: serializer.fromJson<bool>(json['reducedMotion']),
      sessionReminders: serializer.fromJson<bool>(json['sessionReminders']),
      parentPinHash: serializer.fromJson<String>(json['parentPinHash']),
      sfxVolume: serializer.fromJson<double>(json['sfxVolume']),
      entitlement: serializer.fromJson<String>(json['entitlement']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'displayName': serializer.toJson<String>(displayName),
      'avatarIndex': serializer.toJson<int>(avatarIndex),
      'localeCode': serializer.toJson<String>(localeCode),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'audioEnabled': serializer.toJson<bool>(audioEnabled),
      'reducedMotion': serializer.toJson<bool>(reducedMotion),
      'sessionReminders': serializer.toJson<bool>(sessionReminders),
      'parentPinHash': serializer.toJson<String>(parentPinHash),
      'sfxVolume': serializer.toJson<double>(sfxVolume),
      'entitlement': serializer.toJson<String>(entitlement),
    };
  }

  ProfileRow copyWith({
    int? id,
    String? displayName,
    int? avatarIndex,
    String? localeCode,
    bool? onboardingComplete,
    bool? audioEnabled,
    bool? reducedMotion,
    bool? sessionReminders,
    String? parentPinHash,
    double? sfxVolume,
    String? entitlement,
  }) => ProfileRow(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    avatarIndex: avatarIndex ?? this.avatarIndex,
    localeCode: localeCode ?? this.localeCode,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    audioEnabled: audioEnabled ?? this.audioEnabled,
    reducedMotion: reducedMotion ?? this.reducedMotion,
    sessionReminders: sessionReminders ?? this.sessionReminders,
    parentPinHash: parentPinHash ?? this.parentPinHash,
    sfxVolume: sfxVolume ?? this.sfxVolume,
    entitlement: entitlement ?? this.entitlement,
  );
  ProfileRow copyWithCompanion(ProfileRowsCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarIndex: data.avatarIndex.present
          ? data.avatarIndex.value
          : this.avatarIndex,
      localeCode: data.localeCode.present
          ? data.localeCode.value
          : this.localeCode,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      audioEnabled: data.audioEnabled.present
          ? data.audioEnabled.value
          : this.audioEnabled,
      reducedMotion: data.reducedMotion.present
          ? data.reducedMotion.value
          : this.reducedMotion,
      sessionReminders: data.sessionReminders.present
          ? data.sessionReminders.value
          : this.sessionReminders,
      parentPinHash: data.parentPinHash.present
          ? data.parentPinHash.value
          : this.parentPinHash,
      sfxVolume: data.sfxVolume.present ? data.sfxVolume.value : this.sfxVolume,
      entitlement: data.entitlement.present
          ? data.entitlement.value
          : this.entitlement,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarIndex: $avatarIndex, ')
          ..write('localeCode: $localeCode, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('audioEnabled: $audioEnabled, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('sessionReminders: $sessionReminders, ')
          ..write('parentPinHash: $parentPinHash, ')
          ..write('sfxVolume: $sfxVolume, ')
          ..write('entitlement: $entitlement')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    avatarIndex,
    localeCode,
    onboardingComplete,
    audioEnabled,
    reducedMotion,
    sessionReminders,
    parentPinHash,
    sfxVolume,
    entitlement,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.avatarIndex == this.avatarIndex &&
          other.localeCode == this.localeCode &&
          other.onboardingComplete == this.onboardingComplete &&
          other.audioEnabled == this.audioEnabled &&
          other.reducedMotion == this.reducedMotion &&
          other.sessionReminders == this.sessionReminders &&
          other.parentPinHash == this.parentPinHash &&
          other.sfxVolume == this.sfxVolume &&
          other.entitlement == this.entitlement);
}

class ProfileRowsCompanion extends UpdateCompanion<ProfileRow> {
  final Value<int> id;
  final Value<String> displayName;
  final Value<int> avatarIndex;
  final Value<String> localeCode;
  final Value<bool> onboardingComplete;
  final Value<bool> audioEnabled;
  final Value<bool> reducedMotion;
  final Value<bool> sessionReminders;
  final Value<String> parentPinHash;
  final Value<double> sfxVolume;
  final Value<String> entitlement;
  const ProfileRowsCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarIndex = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.audioEnabled = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.sessionReminders = const Value.absent(),
    this.parentPinHash = const Value.absent(),
    this.sfxVolume = const Value.absent(),
    this.entitlement = const Value.absent(),
  });
  ProfileRowsCompanion.insert({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarIndex = const Value.absent(),
    this.localeCode = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.audioEnabled = const Value.absent(),
    this.reducedMotion = const Value.absent(),
    this.sessionReminders = const Value.absent(),
    this.parentPinHash = const Value.absent(),
    this.sfxVolume = const Value.absent(),
    this.entitlement = const Value.absent(),
  });
  static Insertable<ProfileRow> custom({
    Expression<int>? id,
    Expression<String>? displayName,
    Expression<int>? avatarIndex,
    Expression<String>? localeCode,
    Expression<bool>? onboardingComplete,
    Expression<bool>? audioEnabled,
    Expression<bool>? reducedMotion,
    Expression<bool>? sessionReminders,
    Expression<String>? parentPinHash,
    Expression<double>? sfxVolume,
    Expression<String>? entitlement,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (avatarIndex != null) 'avatar_index': avatarIndex,
      if (localeCode != null) 'locale_code': localeCode,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (audioEnabled != null) 'audio_enabled': audioEnabled,
      if (reducedMotion != null) 'reduced_motion': reducedMotion,
      if (sessionReminders != null) 'session_reminders': sessionReminders,
      if (parentPinHash != null) 'parent_pin_hash': parentPinHash,
      if (sfxVolume != null) 'sfx_volume': sfxVolume,
      if (entitlement != null) 'entitlement': entitlement,
    });
  }

  ProfileRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? displayName,
    Value<int>? avatarIndex,
    Value<String>? localeCode,
    Value<bool>? onboardingComplete,
    Value<bool>? audioEnabled,
    Value<bool>? reducedMotion,
    Value<bool>? sessionReminders,
    Value<String>? parentPinHash,
    Value<double>? sfxVolume,
    Value<String>? entitlement,
  }) {
    return ProfileRowsCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      localeCode: localeCode ?? this.localeCode,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      audioEnabled: audioEnabled ?? this.audioEnabled,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      sessionReminders: sessionReminders ?? this.sessionReminders,
      parentPinHash: parentPinHash ?? this.parentPinHash,
      sfxVolume: sfxVolume ?? this.sfxVolume,
      entitlement: entitlement ?? this.entitlement,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarIndex.present) {
      map['avatar_index'] = Variable<int>(avatarIndex.value);
    }
    if (localeCode.present) {
      map['locale_code'] = Variable<String>(localeCode.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (audioEnabled.present) {
      map['audio_enabled'] = Variable<bool>(audioEnabled.value);
    }
    if (reducedMotion.present) {
      map['reduced_motion'] = Variable<bool>(reducedMotion.value);
    }
    if (sessionReminders.present) {
      map['session_reminders'] = Variable<bool>(sessionReminders.value);
    }
    if (parentPinHash.present) {
      map['parent_pin_hash'] = Variable<String>(parentPinHash.value);
    }
    if (sfxVolume.present) {
      map['sfx_volume'] = Variable<double>(sfxVolume.value);
    }
    if (entitlement.present) {
      map['entitlement'] = Variable<String>(entitlement.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRowsCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('avatarIndex: $avatarIndex, ')
          ..write('localeCode: $localeCode, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('audioEnabled: $audioEnabled, ')
          ..write('reducedMotion: $reducedMotion, ')
          ..write('sessionReminders: $sessionReminders, ')
          ..write('parentPinHash: $parentPinHash, ')
          ..write('sfxVolume: $sfxVolume, ')
          ..write('entitlement: $entitlement')
          ..write(')'))
        .toString();
  }
}

class $RewardEventRowsTable extends RewardEventRows
    with TableInfo<$RewardEventRowsTable, RewardEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardEventRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rewardKeyMeta = const VerificationMeta(
    'rewardKey',
  );
  @override
  late final GeneratedColumn<String> rewardKey = GeneratedColumn<String>(
    'reward_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
    'stars',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _grantedAtMeta = const VerificationMeta(
    'grantedAt',
  );
  @override
  late final GeneratedColumn<DateTime> grantedAt = GeneratedColumn<DateTime>(
    'granted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [rewardKey, stars, xp, grantedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reward_event_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reward_key')) {
      context.handle(
        _rewardKeyMeta,
        rewardKey.isAcceptableOrUnknown(data['reward_key']!, _rewardKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_rewardKeyMeta);
    }
    if (data.containsKey('stars')) {
      context.handle(
        _starsMeta,
        stars.isAcceptableOrUnknown(data['stars']!, _starsMeta),
      );
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('granted_at')) {
      context.handle(
        _grantedAtMeta,
        grantedAt.isAcceptableOrUnknown(data['granted_at']!, _grantedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_grantedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rewardKey};
  @override
  RewardEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardEventRow(
      rewardKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reward_key'],
      )!,
      stars: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stars'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
      grantedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}granted_at'],
      )!,
    );
  }

  @override
  $RewardEventRowsTable createAlias(String alias) {
    return $RewardEventRowsTable(attachedDatabase, alias);
  }
}

class RewardEventRow extends DataClass implements Insertable<RewardEventRow> {
  final String rewardKey;
  final int stars;
  final int xp;
  final DateTime grantedAt;
  const RewardEventRow({
    required this.rewardKey,
    required this.stars,
    required this.xp,
    required this.grantedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['reward_key'] = Variable<String>(rewardKey);
    map['stars'] = Variable<int>(stars);
    map['xp'] = Variable<int>(xp);
    map['granted_at'] = Variable<DateTime>(grantedAt);
    return map;
  }

  RewardEventRowsCompanion toCompanion(bool nullToAbsent) {
    return RewardEventRowsCompanion(
      rewardKey: Value(rewardKey),
      stars: Value(stars),
      xp: Value(xp),
      grantedAt: Value(grantedAt),
    );
  }

  factory RewardEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardEventRow(
      rewardKey: serializer.fromJson<String>(json['rewardKey']),
      stars: serializer.fromJson<int>(json['stars']),
      xp: serializer.fromJson<int>(json['xp']),
      grantedAt: serializer.fromJson<DateTime>(json['grantedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rewardKey': serializer.toJson<String>(rewardKey),
      'stars': serializer.toJson<int>(stars),
      'xp': serializer.toJson<int>(xp),
      'grantedAt': serializer.toJson<DateTime>(grantedAt),
    };
  }

  RewardEventRow copyWith({
    String? rewardKey,
    int? stars,
    int? xp,
    DateTime? grantedAt,
  }) => RewardEventRow(
    rewardKey: rewardKey ?? this.rewardKey,
    stars: stars ?? this.stars,
    xp: xp ?? this.xp,
    grantedAt: grantedAt ?? this.grantedAt,
  );
  RewardEventRow copyWithCompanion(RewardEventRowsCompanion data) {
    return RewardEventRow(
      rewardKey: data.rewardKey.present ? data.rewardKey.value : this.rewardKey,
      stars: data.stars.present ? data.stars.value : this.stars,
      xp: data.xp.present ? data.xp.value : this.xp,
      grantedAt: data.grantedAt.present ? data.grantedAt.value : this.grantedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardEventRow(')
          ..write('rewardKey: $rewardKey, ')
          ..write('stars: $stars, ')
          ..write('xp: $xp, ')
          ..write('grantedAt: $grantedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(rewardKey, stars, xp, grantedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardEventRow &&
          other.rewardKey == this.rewardKey &&
          other.stars == this.stars &&
          other.xp == this.xp &&
          other.grantedAt == this.grantedAt);
}

class RewardEventRowsCompanion extends UpdateCompanion<RewardEventRow> {
  final Value<String> rewardKey;
  final Value<int> stars;
  final Value<int> xp;
  final Value<DateTime> grantedAt;
  final Value<int> rowid;
  const RewardEventRowsCompanion({
    this.rewardKey = const Value.absent(),
    this.stars = const Value.absent(),
    this.xp = const Value.absent(),
    this.grantedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RewardEventRowsCompanion.insert({
    required String rewardKey,
    this.stars = const Value.absent(),
    this.xp = const Value.absent(),
    required DateTime grantedAt,
    this.rowid = const Value.absent(),
  }) : rewardKey = Value(rewardKey),
       grantedAt = Value(grantedAt);
  static Insertable<RewardEventRow> custom({
    Expression<String>? rewardKey,
    Expression<int>? stars,
    Expression<int>? xp,
    Expression<DateTime>? grantedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (rewardKey != null) 'reward_key': rewardKey,
      if (stars != null) 'stars': stars,
      if (xp != null) 'xp': xp,
      if (grantedAt != null) 'granted_at': grantedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RewardEventRowsCompanion copyWith({
    Value<String>? rewardKey,
    Value<int>? stars,
    Value<int>? xp,
    Value<DateTime>? grantedAt,
    Value<int>? rowid,
  }) {
    return RewardEventRowsCompanion(
      rewardKey: rewardKey ?? this.rewardKey,
      stars: stars ?? this.stars,
      xp: xp ?? this.xp,
      grantedAt: grantedAt ?? this.grantedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rewardKey.present) {
      map['reward_key'] = Variable<String>(rewardKey.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (grantedAt.present) {
      map['granted_at'] = Variable<DateTime>(grantedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardEventRowsCompanion(')
          ..write('rewardKey: $rewardKey, ')
          ..write('stars: $stars, ')
          ..write('xp: $xp, ')
          ..write('grantedAt: $grantedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProgressRowsTable progressRows = $ProgressRowsTable(this);
  late final $BadgeRowsTable badgeRows = $BadgeRowsTable(this);
  late final $ProfileRowsTable profileRows = $ProfileRowsTable(this);
  late final $RewardEventRowsTable rewardEventRows = $RewardEventRowsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    progressRows,
    badgeRows,
    profileRows,
    rewardEventRows,
  ];
}

typedef $$ProgressRowsTableCreateCompanionBuilder =
    ProgressRowsCompanion Function({
      Value<int> id,
      Value<int> stars,
      Value<int> xp,
      Value<String> unlockedWorlds,
      Value<String> completedGames,
      Value<bool> mapVisited,
      Value<String> arabicStages,
    });
typedef $$ProgressRowsTableUpdateCompanionBuilder =
    ProgressRowsCompanion Function({
      Value<int> id,
      Value<int> stars,
      Value<int> xp,
      Value<String> unlockedWorlds,
      Value<String> completedGames,
      Value<bool> mapVisited,
      Value<String> arabicStages,
    });

class $$ProgressRowsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressRowsTable> {
  $$ProgressRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unlockedWorlds => $composableBuilder(
    column: $table.unlockedWorlds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get completedGames => $composableBuilder(
    column: $table.completedGames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mapVisited => $composableBuilder(
    column: $table.mapVisited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicStages => $composableBuilder(
    column: $table.arabicStages,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressRowsTable> {
  $$ProgressRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unlockedWorlds => $composableBuilder(
    column: $table.unlockedWorlds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get completedGames => $composableBuilder(
    column: $table.completedGames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mapVisited => $composableBuilder(
    column: $table.mapVisited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicStages => $composableBuilder(
    column: $table.arabicStages,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressRowsTable> {
  $$ProgressRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<String> get unlockedWorlds => $composableBuilder(
    column: $table.unlockedWorlds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get completedGames => $composableBuilder(
    column: $table.completedGames,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get mapVisited => $composableBuilder(
    column: $table.mapVisited,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arabicStages => $composableBuilder(
    column: $table.arabicStages,
    builder: (column) => column,
  );
}

class $$ProgressRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressRowsTable,
          ProgressRow,
          $$ProgressRowsTableFilterComposer,
          $$ProgressRowsTableOrderingComposer,
          $$ProgressRowsTableAnnotationComposer,
          $$ProgressRowsTableCreateCompanionBuilder,
          $$ProgressRowsTableUpdateCompanionBuilder,
          (
            ProgressRow,
            BaseReferences<_$AppDatabase, $ProgressRowsTable, ProgressRow>,
          ),
          ProgressRow,
          PrefetchHooks Function()
        > {
  $$ProgressRowsTableTableManager(_$AppDatabase db, $ProgressRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stars = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<String> unlockedWorlds = const Value.absent(),
                Value<String> completedGames = const Value.absent(),
                Value<bool> mapVisited = const Value.absent(),
                Value<String> arabicStages = const Value.absent(),
              }) => ProgressRowsCompanion(
                id: id,
                stars: stars,
                xp: xp,
                unlockedWorlds: unlockedWorlds,
                completedGames: completedGames,
                mapVisited: mapVisited,
                arabicStages: arabicStages,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stars = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<String> unlockedWorlds = const Value.absent(),
                Value<String> completedGames = const Value.absent(),
                Value<bool> mapVisited = const Value.absent(),
                Value<String> arabicStages = const Value.absent(),
              }) => ProgressRowsCompanion.insert(
                id: id,
                stars: stars,
                xp: xp,
                unlockedWorlds: unlockedWorlds,
                completedGames: completedGames,
                mapVisited: mapVisited,
                arabicStages: arabicStages,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProgressRowsTable, ProgressRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ProgressRowsTable,
                    ProgressRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressRowsTable,
      ProgressRow,
      $$ProgressRowsTableFilterComposer,
      $$ProgressRowsTableOrderingComposer,
      $$ProgressRowsTableAnnotationComposer,
      $$ProgressRowsTableCreateCompanionBuilder,
      $$ProgressRowsTableUpdateCompanionBuilder,
      (
        ProgressRow,
        BaseReferences<_$AppDatabase, $ProgressRowsTable, ProgressRow>,
      ),
      ProgressRow,
      PrefetchHooks Function()
    >;
typedef $$BadgeRowsTableCreateCompanionBuilder = BadgeRowsCompanion Function({
  required String id,
  required DateTime earnedAt,
  Value<int> rowid,
});
typedef $$BadgeRowsTableUpdateCompanionBuilder = BadgeRowsCompanion Function({
  Value<String> id,
  Value<DateTime> earnedAt,
  Value<int> rowid,
});

class $$BadgeRowsTableFilterComposer
    extends Composer<_$AppDatabase, $BadgeRowsTable> {
  $$BadgeRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BadgeRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgeRowsTable> {
  $$BadgeRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BadgeRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgeRowsTable> {
  $$BadgeRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get earnedAt =>
      $composableBuilder(column: $table.earnedAt, builder: (column) => column);
}

class $$BadgeRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BadgeRowsTable,
          BadgeRow,
          $$BadgeRowsTableFilterComposer,
          $$BadgeRowsTableOrderingComposer,
          $$BadgeRowsTableAnnotationComposer,
          $$BadgeRowsTableCreateCompanionBuilder,
          $$BadgeRowsTableUpdateCompanionBuilder,
          (BadgeRow, BaseReferences<_$AppDatabase, $BadgeRowsTable, BadgeRow>),
          BadgeRow,
          PrefetchHooks Function()
        > {
  $$BadgeRowsTableTableManager(_$AppDatabase db, $BadgeRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BadgeRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BadgeRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BadgeRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> earnedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => BadgeRowsCompanion(id: id, earnedAt: earnedAt, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required DateTime earnedAt,
                Value<int> rowid = const Value.absent(),
              }) => BadgeRowsCompanion.insert(
                id: id,
                earnedAt: earnedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BadgeRowsTable, BadgeRow>(table),
                  BaseReferences<_$AppDatabase, $BadgeRowsTable, BadgeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BadgeRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BadgeRowsTable,
      BadgeRow,
      $$BadgeRowsTableFilterComposer,
      $$BadgeRowsTableOrderingComposer,
      $$BadgeRowsTableAnnotationComposer,
      $$BadgeRowsTableCreateCompanionBuilder,
      $$BadgeRowsTableUpdateCompanionBuilder,
      (BadgeRow, BaseReferences<_$AppDatabase, $BadgeRowsTable, BadgeRow>),
      BadgeRow,
      PrefetchHooks Function()
    >;
typedef $$ProfileRowsTableCreateCompanionBuilder =
    ProfileRowsCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<int> avatarIndex,
      Value<String> localeCode,
      Value<bool> onboardingComplete,
      Value<bool> audioEnabled,
      Value<bool> reducedMotion,
      Value<bool> sessionReminders,
      Value<String> parentPinHash,
      Value<double> sfxVolume,
      Value<String> entitlement,
    });
typedef $$ProfileRowsTableUpdateCompanionBuilder =
    ProfileRowsCompanion Function({
      Value<int> id,
      Value<String> displayName,
      Value<int> avatarIndex,
      Value<String> localeCode,
      Value<bool> onboardingComplete,
      Value<bool> audioEnabled,
      Value<bool> reducedMotion,
      Value<bool> sessionReminders,
      Value<String> parentPinHash,
      Value<double> sfxVolume,
      Value<String> entitlement,
    });

class $$ProfileRowsTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileRowsTable> {
  $$ProfileRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avatarIndex => $composableBuilder(
    column: $table.avatarIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get audioEnabled => $composableBuilder(
    column: $table.audioEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sessionReminders => $composableBuilder(
    column: $table.sessionReminders,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentPinHash => $composableBuilder(
    column: $table.parentPinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sfxVolume => $composableBuilder(
    column: $table.sfxVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entitlement => $composableBuilder(
    column: $table.entitlement,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileRowsTable> {
  $$ProfileRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avatarIndex => $composableBuilder(
    column: $table.avatarIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get audioEnabled => $composableBuilder(
    column: $table.audioEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sessionReminders => $composableBuilder(
    column: $table.sessionReminders,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentPinHash => $composableBuilder(
    column: $table.parentPinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sfxVolume => $composableBuilder(
    column: $table.sfxVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entitlement => $composableBuilder(
    column: $table.entitlement,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileRowsTable> {
  $$ProfileRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get avatarIndex => $composableBuilder(
    column: $table.avatarIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localeCode => $composableBuilder(
    column: $table.localeCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get audioEnabled => $composableBuilder(
    column: $table.audioEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reducedMotion => $composableBuilder(
    column: $table.reducedMotion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get sessionReminders => $composableBuilder(
    column: $table.sessionReminders,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentPinHash => $composableBuilder(
    column: $table.parentPinHash,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sfxVolume =>
      $composableBuilder(column: $table.sfxVolume, builder: (column) => column);

  GeneratedColumn<String> get entitlement => $composableBuilder(
    column: $table.entitlement,
    builder: (column) => column,
  );
}

class $$ProfileRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileRowsTable,
          ProfileRow,
          $$ProfileRowsTableFilterComposer,
          $$ProfileRowsTableOrderingComposer,
          $$ProfileRowsTableAnnotationComposer,
          $$ProfileRowsTableCreateCompanionBuilder,
          $$ProfileRowsTableUpdateCompanionBuilder,
          (
            ProfileRow,
            BaseReferences<_$AppDatabase, $ProfileRowsTable, ProfileRow>,
          ),
          ProfileRow,
          PrefetchHooks Function()
        > {
  $$ProfileRowsTableTableManager(_$AppDatabase db, $ProfileRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> avatarIndex = const Value.absent(),
                Value<String> localeCode = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> audioEnabled = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<bool> sessionReminders = const Value.absent(),
                Value<String> parentPinHash = const Value.absent(),
                Value<double> sfxVolume = const Value.absent(),
                Value<String> entitlement = const Value.absent(),
              }) => ProfileRowsCompanion(
                id: id,
                displayName: displayName,
                avatarIndex: avatarIndex,
                localeCode: localeCode,
                onboardingComplete: onboardingComplete,
                audioEnabled: audioEnabled,
                reducedMotion: reducedMotion,
                sessionReminders: sessionReminders,
                parentPinHash: parentPinHash,
                sfxVolume: sfxVolume,
                entitlement: entitlement,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<int> avatarIndex = const Value.absent(),
                Value<String> localeCode = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<bool> audioEnabled = const Value.absent(),
                Value<bool> reducedMotion = const Value.absent(),
                Value<bool> sessionReminders = const Value.absent(),
                Value<String> parentPinHash = const Value.absent(),
                Value<double> sfxVolume = const Value.absent(),
                Value<String> entitlement = const Value.absent(),
              }) => ProfileRowsCompanion.insert(
                id: id,
                displayName: displayName,
                avatarIndex: avatarIndex,
                localeCode: localeCode,
                onboardingComplete: onboardingComplete,
                audioEnabled: audioEnabled,
                reducedMotion: reducedMotion,
                sessionReminders: sessionReminders,
                parentPinHash: parentPinHash,
                sfxVolume: sfxVolume,
                entitlement: entitlement,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProfileRowsTable, ProfileRow>(table),
                  BaseReferences<_$AppDatabase, $ProfileRowsTable, ProfileRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileRowsTable,
      ProfileRow,
      $$ProfileRowsTableFilterComposer,
      $$ProfileRowsTableOrderingComposer,
      $$ProfileRowsTableAnnotationComposer,
      $$ProfileRowsTableCreateCompanionBuilder,
      $$ProfileRowsTableUpdateCompanionBuilder,
      (
        ProfileRow,
        BaseReferences<_$AppDatabase, $ProfileRowsTable, ProfileRow>,
      ),
      ProfileRow,
      PrefetchHooks Function()
    >;
typedef $$RewardEventRowsTableCreateCompanionBuilder =
    RewardEventRowsCompanion Function({
      required String rewardKey,
      Value<int> stars,
      Value<int> xp,
      required DateTime grantedAt,
      Value<int> rowid,
    });
typedef $$RewardEventRowsTableUpdateCompanionBuilder =
    RewardEventRowsCompanion Function({
      Value<String> rewardKey,
      Value<int> stars,
      Value<int> xp,
      Value<DateTime> grantedAt,
      Value<int> rowid,
    });

class $$RewardEventRowsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardEventRowsTable> {
  $$RewardEventRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get rewardKey => $composableBuilder(
    column: $table.rewardKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RewardEventRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardEventRowsTable> {
  $$RewardEventRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get rewardKey => $composableBuilder(
    column: $table.rewardKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get grantedAt => $composableBuilder(
    column: $table.grantedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RewardEventRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardEventRowsTable> {
  $$RewardEventRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get rewardKey =>
      $composableBuilder(column: $table.rewardKey, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<DateTime> get grantedAt =>
      $composableBuilder(column: $table.grantedAt, builder: (column) => column);
}

class $$RewardEventRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardEventRowsTable,
          RewardEventRow,
          $$RewardEventRowsTableFilterComposer,
          $$RewardEventRowsTableOrderingComposer,
          $$RewardEventRowsTableAnnotationComposer,
          $$RewardEventRowsTableCreateCompanionBuilder,
          $$RewardEventRowsTableUpdateCompanionBuilder,
          (
            RewardEventRow,
            BaseReferences<
              _$AppDatabase,
              $RewardEventRowsTable,
              RewardEventRow
            >,
          ),
          RewardEventRow,
          PrefetchHooks Function()
        > {
  $$RewardEventRowsTableTableManager(
    _$AppDatabase db,
    $RewardEventRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardEventRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardEventRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardEventRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> rewardKey = const Value.absent(),
                Value<int> stars = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<DateTime> grantedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RewardEventRowsCompanion(
                rewardKey: rewardKey,
                stars: stars,
                xp: xp,
                grantedAt: grantedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String rewardKey,
                Value<int> stars = const Value.absent(),
                Value<int> xp = const Value.absent(),
                required DateTime grantedAt,
                Value<int> rowid = const Value.absent(),
              }) => RewardEventRowsCompanion.insert(
                rewardKey: rewardKey,
                stars: stars,
                xp: xp,
                grantedAt: grantedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RewardEventRowsTable, RewardEventRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $RewardEventRowsTable,
                    RewardEventRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardEventRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardEventRowsTable,
      RewardEventRow,
      $$RewardEventRowsTableFilterComposer,
      $$RewardEventRowsTableOrderingComposer,
      $$RewardEventRowsTableAnnotationComposer,
      $$RewardEventRowsTableCreateCompanionBuilder,
      $$RewardEventRowsTableUpdateCompanionBuilder,
      (
        RewardEventRow,
        BaseReferences<_$AppDatabase, $RewardEventRowsTable, RewardEventRow>,
      ),
      RewardEventRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProgressRowsTableTableManager get progressRows =>
      $$ProgressRowsTableTableManager(_db, _db.progressRows);
  $$BadgeRowsTableTableManager get badgeRows =>
      $$BadgeRowsTableTableManager(_db, _db.badgeRows);
  $$ProfileRowsTableTableManager get profileRows =>
      $$ProfileRowsTableTableManager(_db, _db.profileRows);
  $$RewardEventRowsTableTableManager get rewardEventRows =>
      $$RewardEventRowsTableTableManager(_db, _db.rewardEventRows);
}
