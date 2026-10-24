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
  });

  final int stars;
  final int xp;
  final Set<String> unlockedWorlds;
  final Set<String> completedGames;
  final Set<String> badges;
  final bool mapVisited;
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
  });

  final String displayName;
  final int avatarIndex;
  final String localeCode;
  final bool onboardingComplete;
  final bool audioEnabled;
  final bool reducedMotion;
  final bool sessionReminders;
}

class ProgressRepository {
  ProgressRepository(this._db);

  final AppDatabase _db;

  Stream<ProgressSnapshot> watchProgress() {
    return _db.select(_db.progressRows).watchSingle().asyncMap((row) async {
      final badges = await _db.select(_db.badgeRows).get();
      return ProgressSnapshot(
        stars: row.stars,
        xp: row.xp,
        unlockedWorlds: _split(row.unlockedWorlds),
        completedGames: _split(row.completedGames),
        badges: badges.map((b) => b.id).toSet(),
        mapVisited: row.mapVisited,
      );
    });
  }

  Stream<ProfileSnapshot> watchProfile() {
    return _db.select(_db.profileRows).watchSingle().map(
          (row) => ProfileSnapshot(
            displayName: row.displayName,
            avatarIndex: row.avatarIndex,
            localeCode: row.localeCode,
            onboardingComplete: row.onboardingComplete,
            audioEnabled: row.audioEnabled,
            reducedMotion: row.reducedMotion,
            sessionReminders: row.sessionReminders,
          ),
        );
  }

  Future<ProgressSnapshot> getProgress() async {
    final row = await (_db.select(_db.progressRows)
          ..where((t) => t.id.equals(1)))
        .getSingle();
    final badges = await _db.select(_db.badgeRows).get();
    return ProgressSnapshot(
      stars: row.stars,
      xp: row.xp,
      unlockedWorlds: _split(row.unlockedWorlds),
      completedGames: _split(row.completedGames),
      badges: badges.map((b) => b.id).toSet(),
      mapVisited: row.mapVisited,
    );
  }

  Future<ProfileSnapshot> getProfile() async {
    final row = await (_db.select(_db.profileRows)
          ..where((t) => t.id.equals(1)))
        .getSingle();
    return ProfileSnapshot(
      displayName: row.displayName,
      avatarIndex: row.avatarIndex,
      localeCode: row.localeCode,
      onboardingComplete: row.onboardingComplete,
      audioEnabled: row.audioEnabled,
      reducedMotion: row.reducedMotion,
      sessionReminders: row.sessionReminders,
    );
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
  }) async {
    await (_db.update(_db.profileRows)..where((t) => t.id.equals(1))).write(
      ProfileRowsCompanion(
        audioEnabled: audioEnabled == null
            ? const Value.absent()
            : Value(audioEnabled),
        reducedMotion: reducedMotion == null
            ? const Value.absent()
            : Value(reducedMotion),
        sessionReminders: sessionReminders == null
            ? const Value.absent()
            : Value(sessionReminders),
      ),
    );
  }

  Future<void> markMapVisited() async {
    await (_db.update(_db.progressRows)..where((t) => t.id.equals(1))).write(
      const ProgressRowsCompanion(mapVisited: Value(true)),
    );
    await _maybeAwardBadge('map_traveler');
  }

  /// Awards educational stars/XP only — never spiritual merit.
  Future<VictoryResult> completeGame({
    required String gameId,
    required int starsEarned,
    required int xpEarned,
    String? unlockWorld,
    String? badgeId,
  }) async {
    final current = await getProgress();
    final games = {...current.completedGames, gameId};
    final worlds = {...current.unlockedWorlds};
    if (unlockWorld != null) worlds.add(unlockWorld);

    // Completing letters unlocks prayer; manners already unlocked at start.
    if (gameId == 'arabic_letters') worlds.add('prayer');

    final newStars = current.stars + starsEarned;
    final newXp = current.xp + xpEarned;

    await (_db.update(_db.progressRows)..where((t) => t.id.equals(1))).write(
      ProgressRowsCompanion(
        stars: Value(newStars),
        xp: Value(newXp),
        completedGames: Value(games.join(',')),
        unlockedWorlds: Value(worlds.join(',')),
      ),
    );

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
    );
  }

  Future<void> resetAll() async {
    await (_db.update(_db.progressRows)..where((t) => t.id.equals(1))).write(
      const ProgressRowsCompanion(
        stars: Value(0),
        xp: Value(0),
        unlockedWorlds: Value('arabic,manners'),
        completedGames: Value(''),
        mapVisited: Value(false),
      ),
    );
    await _db.delete(_db.badgeRows).go();
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

  Set<String> _split(String raw) {
    if (raw.trim().isEmpty) return {};
    return raw.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toSet();
  }
}

class VictoryResult {
  const VictoryResult({
    required this.starsEarned,
    required this.xpEarned,
    required this.totalStars,
    required this.totalXp,
    required this.newBadges,
  });

  final int starsEarned;
  final int xpEarned;
  final int totalStars;
  final int totalXp;
  final List<String> newBadges;
}
