import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../lessons/lesson_catalog.dart';

class ProgressSnapshot {
  const ProgressSnapshot({
    required this.stars,
    required this.xp,
    required this.unlockedWorlds,
    required this.completedGames,
    required this.badges,
    required this.mapVisited,
    required this.arabicStages,
  });

  final int stars;
  final int xp;
  final Set<String> unlockedWorlds;
  final Set<String> completedGames;
  final Set<String> badges;
  final bool mapVisited;
  final Set<String> arabicStages;
}

class ProfileSnapshot {
  const ProfileSnapshot({
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

  final String displayName;
  final int avatarIndex;
  final String localeCode;
  final bool onboardingComplete;
  final bool audioEnabled;
  final bool reducedMotion;
  final bool sessionReminders;
  final String parentPinHash;
  final double sfxVolume;
  final String entitlement;

  bool get hasParentPin => parentPinHash.isNotEmpty;
}

class ProgressRepository {
  ProgressRepository(this._db);

  final AppDatabase _db;

  Stream<ProgressSnapshot> watchProgress() {
    return _db.select(_db.progressRows).watchSingle().asyncMap((row) async {
      final badges = await _db.select(_db.badgeRows).get();
      return _mapProgress(row, badges);
    });
  }

  Stream<ProfileSnapshot> watchProfile() {
    return _db.select(_db.profileRows).watchSingle().map(_mapProfile);
  }

  Future<ProgressSnapshot> getProgress() async {
    final row = await (_db.select(_db.progressRows)..where((t) => t.id.equals(1)))
        .getSingle();
    final badges = await _db.select(_db.badgeRows).get();
    return _mapProgress(row, badges);
  }

  Future<ProfileSnapshot> getProfile() async {
    final row = await (_db.select(_db.profileRows)..where((t) => t.id.equals(1)))
        .getSingle();
    return _mapProfile(row);
  }

  Future<void> setLocale(String code) async {
    await (_db.update(_db.profileRows)..where((t) => t.id.equals(1))).write(
      ProfileRowsCompanion(localeCode: Value(code)),
    );
  }

  Future<void> completeOnboarding({
    required String displayName,
    required int avatarIndex,
  }) async {
    await (_db.update(_db.profileRows)..where((t) => t.id.equals(1))).write(
      ProfileRowsCompanion(
        displayName: Value(displayName.trim()),
        avatarIndex: Value(avatarIndex),
        onboardingComplete: const Value(true),
      ),
    );
  }

  Future<void> updatePrefs({
    bool? audioEnabled,
    bool? reducedMotion,
    bool? sessionReminders,
    double? sfxVolume,
  }) async {
    await (_db.update(_db.profileRows)..where((t) => t.id.equals(1))).write(
      ProfileRowsCompanion(
        audioEnabled:
            audioEnabled == null ? const Value.absent() : Value(audioEnabled),
        reducedMotion:
            reducedMotion == null ? const Value.absent() : Value(reducedMotion),
        sessionReminders: sessionReminders == null
            ? const Value.absent()
            : Value(sessionReminders),
        sfxVolume: sfxVolume == null ? const Value.absent() : Value(sfxVolume),
      ),
    );
  }

  Future<void> setParentPin(String pin) async {
    final hash = _hashPin(pin);
    await (_db.update(_db.profileRows)..where((t) => t.id.equals(1))).write(
      ProfileRowsCompanion(parentPinHash: Value(hash)),
    );
  }

  Future<bool> verifyParentPin(String pin) async {
    final profile = await getProfile();
    if (!profile.hasParentPin) return false;
    return profile.parentPinHash == _hashPin(pin);
  }

  Future<void> clearParentPin() async {
    await (_db.update(_db.profileRows)..where((t) => t.id.equals(1))).write(
      const ProfileRowsCompanion(parentPinHash: Value('')),
    );
  }

  Future<void> markMapVisited() async {
    await (_db.update(_db.progressRows)..where((t) => t.id.equals(1))).write(
      const ProgressRowsCompanion(mapVisited: Value(true)),
    );
    await _maybeAwardBadge('map_traveler');
  }

  /// Idempotent rewards: same [rewardKey] never grants stars/XP twice.
  Future<VictoryResult> completeGame({
    required String gameId,
    required String rewardKey,
    required int starsEarned,
    required int xpEarned,
    String? unlockWorld,
    String? badgeId,
    String? unlockArabicStage,
  }) async {
    final existing = await (_db.select(_db.rewardEventRows)
          ..where((t) => t.rewardKey.equals(rewardKey)))
        .getSingleOrNull();
    final current = await getProgress();

    if (existing != null) {
      return VictoryResult(
        starsEarned: 0,
        xpEarned: 0,
        totalStars: current.stars,
        totalXp: current.xp,
        newBadges: const [],
        alreadyClaimed: true,
      );
    }

    final games = {...current.completedGames, gameId};
    final worlds = {...current.unlockedWorlds};
    if (unlockWorld != null) worlds.add(unlockWorld);
    if (gameId == 'arabic_letters' || gameId.startsWith('arabic_stage_')) {
      worlds.add('prayer');
      worlds.add('garden');
    }
    final stages = {...current.arabicStages};
    if (unlockArabicStage != null) stages.add(unlockArabicStage);

    final newStars = current.stars + starsEarned;
    final newXp = current.xp + xpEarned;

    await _db.transaction(() async {
      await _db.into(_db.rewardEventRows).insert(
            RewardEventRowsCompanion.insert(
              rewardKey: rewardKey,
              stars: Value(starsEarned),
              xp: Value(xpEarned),
              grantedAt: DateTime.now(),
            ),
          );
      await (_db.update(_db.progressRows)..where((t) => t.id.equals(1))).write(
        ProgressRowsCompanion(
          stars: Value(newStars),
          xp: Value(newXp),
          completedGames: Value(games.join(',')),
          unlockedWorlds: Value(worlds.join(',')),
          arabicStages: Value(stages.join(',')),
        ),
      );
    });

    final awarded = <String>[];
    if (newStars > 0 && !current.badges.contains('first_star')) {
      await _awardBadge('first_star');
      awarded.add('first_star');
    }
    if (badgeId != null && !current.badges.contains(badgeId)) {
      await _awardBadge(badgeId);
      awarded.add(badgeId);
    }
    if (newStars >= 15 && !current.badges.contains('star_collector')) {
      await _awardBadge('star_collector');
      awarded.add('star_collector');
    }

    return VictoryResult(
      starsEarned: starsEarned,
      xpEarned: xpEarned,
      totalStars: newStars,
      totalXp: newXp,
      newBadges: awarded,
      alreadyClaimed: false,
    );
  }

  Future<void> resetAll() async {
    await (_db.update(_db.progressRows)..where((t) => t.id.equals(1))).write(
      const ProgressRowsCompanion(
        stars: Value(0),
        xp: Value(0),
        unlockedWorlds: Value('arabic,manners,garden'),
        completedGames: Value(''),
        mapVisited: Value(false),
        arabicStages: Value('stage_1'),
      ),
    );
    await _db.delete(_db.badgeRows).go();
    await _db.delete(_db.rewardEventRows).go();
  }

  Future<void> _maybeAwardBadge(String id) async {
    final current = await getProgress();
    if (!current.badges.contains(id) && LessonCatalog.badgeIds.contains(id)) {
      await _awardBadge(id);
    }
  }

  Future<void> _awardBadge(String id) async {
    await _db.into(_db.badgeRows).insertOnConflictUpdate(
          BadgeRowsCompanion.insert(id: id, earnedAt: DateTime.now()),
        );
  }

  ProgressSnapshot _mapProgress(ProgressRow row, List<BadgeRow> badges) {
    return ProgressSnapshot(
      stars: row.stars,
      xp: row.xp,
      unlockedWorlds: _split(row.unlockedWorlds),
      completedGames: _split(row.completedGames),
      badges: badges.map((b) => b.id).toSet(),
      mapVisited: row.mapVisited,
      arabicStages: _split(row.arabicStages),
    );
  }

  ProfileSnapshot _mapProfile(ProfileRow row) {
    return ProfileSnapshot(
      displayName: row.displayName,
      avatarIndex: row.avatarIndex,
      localeCode: row.localeCode,
      onboardingComplete: row.onboardingComplete,
      audioEnabled: row.audioEnabled,
      reducedMotion: row.reducedMotion,
      sessionReminders: row.sessionReminders,
      parentPinHash: row.parentPinHash,
      sfxVolume: row.sfxVolume,
      entitlement: row.entitlement,
    );
  }

  String _hashPin(String pin) {
    return sha256.convert(utf8.encode('noor-quest-pin:$pin')).toString();
  }

  Set<String> _split(String raw) {
    if (raw.trim().isEmpty) return {};
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet();
  }
}

class VictoryResult {
  const VictoryResult({
    required this.starsEarned,
    required this.xpEarned,
    required this.totalStars,
    required this.totalXp,
    required this.newBadges,
    this.alreadyClaimed = false,
  });

  final int starsEarned;
  final int xpEarned;
  final int totalStars;
  final int totalXp;
  final List<String> newBadges;
  final bool alreadyClaimed;
}
