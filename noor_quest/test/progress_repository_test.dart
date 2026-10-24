import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_quest/data/database/app_database.dart';
import 'package:noor_quest/data/repositories/progress_repository.dart';

void main() {
  late AppDatabase db;
  late ProgressRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await db.ensureSeeded();
    repo = ProgressRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('seeded progress starts with arabic and manners unlocked', () async {
    final progress = await repo.getProgress();
    expect(progress.stars, 0);
    expect(progress.xp, 0);
    expect(progress.unlockedWorlds, containsAll(['arabic', 'manners']));
    expect(progress.completedGames, isEmpty);
  });

  test('completing arabic letters awards stars, XP, unlock, and badge', () async {
    final result = await repo.completeGame(
      gameId: 'arabic_letters',
      starsEarned: 3,
      xpEarned: 30,
      unlockWorld: 'prayer',
      badgeId: 'letter_learner',
    );

    expect(result.starsEarned, 3);
    expect(result.xpEarned, 30);
    expect(result.totalStars, 3);
    expect(result.newBadges, containsAll(['first_star', 'letter_learner']));

    final progress = await repo.getProgress();
    expect(progress.stars, 3);
    expect(progress.xp, 30);
    expect(progress.completedGames, contains('arabic_letters'));
    expect(progress.unlockedWorlds, contains('prayer'));
    expect(progress.badges, contains('letter_learner'));
  });

  test('progress survives logical restart via fresh repository on same DB', () async {
    await repo.completeGame(
      gameId: 'good_manners',
      starsEarned: 2,
      xpEarned: 20,
      badgeId: 'kind_heart',
    );

    final again = ProgressRepository(db);
    final progress = await again.getProgress();
    expect(progress.stars, 2);
    expect(progress.completedGames, contains('good_manners'));
    expect(progress.badges, contains('kind_heart'));
  });

  test('reset clears stars unlocks and badges', () async {
    await repo.completeGame(
      gameId: 'wudu_sequence',
      starsEarned: 3,
      xpEarned: 40,
      badgeId: 'wudu_explorer',
    );
    await repo.resetAll();
    final progress = await repo.getProgress();
    expect(progress.stars, 0);
    expect(progress.xp, 0);
    expect(progress.completedGames, isEmpty);
    expect(progress.badges, isEmpty);
    expect(progress.unlockedWorlds, containsAll(['arabic', 'manners']));
  });

  test('onboarding profile stores avatar without requiring PII', () async {
    await repo.completeOnboarding(displayName: 'Sam', avatarIndex: 2);
    final profile = await repo.getProfile();
    expect(profile.onboardingComplete, isTrue);
    expect(profile.displayName, 'Sam');
    expect(profile.avatarIndex, 2);
  });
}
