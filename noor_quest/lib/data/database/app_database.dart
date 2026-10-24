import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class ProgressRows extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  TextColumn get unlockedWorlds =>
      text().withDefault(const Constant('arabic,manners,garden'))();
  TextColumn get completedGames => text().withDefault(const Constant(''))();
  BoolColumn get mapVisited =>
      boolean().withDefault(const Constant(false))();
  /// V2: comma-separated stage ids unlocked on Arabic pathway.
  TextColumn get arabicStages =>
      text().withDefault(const Constant('stage_1'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BadgeRows extends Table {
  TextColumn get id => text()();
  DateTimeColumn get earnedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Idempotent reward ledger — same rewardKey never grants twice.
class RewardEventRows extends Table {
  TextColumn get rewardKey => text()();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  IntColumn get xp => integer().withDefault(const Constant(0))();
  DateTimeColumn get grantedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {rewardKey};
}

class ProfileRows extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get displayName => text().withDefault(const Constant(''))();
  IntColumn get avatarIndex => integer().withDefault(const Constant(0))();
  TextColumn get localeCode => text().withDefault(const Constant('en'))();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get audioEnabled =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get reducedMotion =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get sessionReminders =>
      boolean().withDefault(const Constant(false))();
  /// Optional parent PIN hash (simple local gate). Empty = math gate only.
  TextColumn get parentPinHash => text().withDefault(const Constant(''))();
  RealColumn get sfxVolume => real().withDefault(const Constant(0.8))();
  /// free | family_plus (entitlement stub; no live IAP).
  TextColumn get entitlement =>
      text().withDefault(const Constant('free'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [ProgressRows, BadgeRows, ProfileRows, RewardEventRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(progressRows, progressRows.arabicStages);
            await m.addColumn(profileRows, profileRows.parentPinHash);
            await m.addColumn(profileRows, profileRows.sfxVolume);
            await m.addColumn(profileRows, profileRows.entitlement);
            await m.createTable(rewardEventRows);
          }
        },
      );

  Future<void> ensureSeeded() async {
    final existing = await (select(profileRows)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (existing == null) {
      await into(profileRows).insert(ProfileRowsCompanion.insert());
    }
    final progress = await (select(progressRows)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (progress == null) {
      await into(progressRows).insert(ProgressRowsCompanion.insert());
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'noor_quest.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
