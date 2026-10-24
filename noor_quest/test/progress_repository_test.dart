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
    expect(progress.unlockedWorlds, containsAll(['arabic', 'manners', 'garden']));
    expect(progress.arabicStages, contains('stage_1'));
  });

  test('completeGame is idempotent for the same rewardKey', () async {
    final first = await repo.completeGame(
      gameId: 'arabic_letters',
      rewardKey: 'arabic_letters_v1_complete',
      starsEarned: 3,
      xpEarned: 30,
      unlockWorld: 'prayer',
      badgeId: 'letter_learner',
      unlockArabicStage: 'stage_2',
    );
    expect(first.alreadyClaimed, isFalse);
    expect(first.starsEarned, 3);

    final second = await repo.completeGame(
      gameId: 'arabic_letters',
      rewardKey: 'arabic_letters_v1_complete',
      starsEarned: 3,
      xpEarned: 30,
      badgeId: 'letter_learner',
    );
    expect(second.alreadyClaimed, isTrue);
    expect(second.starsEarned, 0);

    final progress = await repo.getProgress();
    expect(progress.stars, 3);
    expect(progress.unlockedWorlds, contains('prayer'));
    expect(progress.arabicStages, contains('stage_2'));
  });

  test('parent PIN can be set and verified', () async {
    await repo.setParentPin('4321');
    expect(await repo.verifyParentPin('4321'), isTrue);
    expect(await repo.verifyParentPin('0000'), isFalse);
    await repo.clearParentPin();
    final profile = await repo.getProfile();
    expect(profile.hasParentPin, isFalse);
  });

  test('reset clears rewards ledger', () async {
    await repo.completeGame(
      gameId: 'wudu_sequence',
      rewardKey: 'wudu_sequence_v1_complete',
      starsEarned: 3,
      xpEarned: 40,
      badgeId: 'wudu_explorer',
    );
    await repo.resetAll();
    final progress = await repo.getProgress();
    expect(progress.stars, 0);
    expect(progress.badges, isEmpty);
  });
}
