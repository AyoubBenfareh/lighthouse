import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/painters/object_painters.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';
import '../../data/lessons/lesson_catalog.dart';
import '../../data/models/lesson_models.dart';
import '../victory/victory_screen.dart';

class ArabicLettersScreen extends ConsumerStatefulWidget {
  const ArabicLettersScreen({super.key});

  @override
  ConsumerState<ArabicLettersScreen> createState() =>
      _ArabicLettersScreenState();
}

class _ArabicLettersScreenState extends ConsumerState<ArabicLettersScreen> {
  late List<ArabicLetterItem> _rounds;
  int _index = 0;
  int _stars = 0;
  String? _feedback;
  bool _showBurst = false;
  late List<String> _options;
  final _fx = _LetterFxGame();

  @override
  void initState() {
    super.initState();
    _rounds = List.of(LessonCatalog.arabicLetters)..shuffle(Random());
    _prepareOptions();
  }

  void _prepareOptions() {
    final correct = _rounds[_index].letter;
    final pool = LessonCatalog.arabicLetters.map((e) => e.letter).toList()
      ..shuffle(Random());
    _options = {correct, ...pool}.take(3).toList()..shuffle(Random());
    if (!_options.contains(correct)) {
      _options[0] = correct;
      _options.shuffle(Random());
    }
  }

  Future<void> _onPick(String letter) async {
    final item = _rounds[_index];
    final l10n = AppLocalizations.of(context);
    if (letter == item.letter) {
      ref.read(soundManagerProvider).play(Sfx.correct);
      setState(() {
        _feedback = l10n.correct;
        _stars += 1;
        _showBurst = true;
      });
      _fx.pulse();
      await Future<void>.delayed(const Duration(milliseconds: 700));
      if (!mounted) return;
      if (_index >= _rounds.length - 1) {
        await _finish();
      } else {
        setState(() {
          _index += 1;
          _feedback = null;
          _showBurst = false;
          _prepareOptions();
        });
      }
    } else {
      ref.read(soundManagerProvider).play(Sfx.incorrect);
      setState(() => _feedback = l10n.almost);
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (mounted) setState(() => _feedback = null);
    }
  }

  Future<void> _finish() async {
    ref.read(soundManagerProvider).play(Sfx.celebrate);
    final result = await ref.read(progressRepositoryProvider).completeGame(
          gameId: 'arabic_letters',
          rewardKey: 'arabic_letters_v1_complete',
          starsEarned: _stars.clamp(1, 6),
          xpEarned: 30,
          unlockWorld: 'prayer',
          badgeId: 'letter_learner',
          unlockArabicStage: 'stage_2',
        );
    if (!mounted) return;
    context.go(
      '/victory',
      extra: VictoryArgs(
        titleGame: 'arabic',
        starsEarned: result.starsEarned,
        xpEarned: result.xpEarned,
        replayRoute: '/game/arabic',
        newBadges: result.newBadges,
      ),
    );
  }

  Future<void> _speakWord() async {
    final profile = ref.read(profileProvider).value;
    if (profile?.audioEnabled == false) return;
    final item = _rounds[_index];
    await ref.read(speechServiceProvider).speakArabicLearning(item.wordAr);
  }

  Future<void> _speakLetter() async {
    final profile = ref.read(profileProvider).value;
    if (profile?.audioEnabled == false) return;
    final item = _rounds[_index];
    await ref.read(speechServiceProvider).speakArabicLearning(item.letterNameAr);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider).languageCode;
    final item = _rounds[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.arabicLettersTitle),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/map'),
        ),
      ),
      body: GeometricBackground(
        topColor: AppColors.skyBlue,
        child: Stack(
          children: [
            IgnorePointer(child: GameWidget(game: _fx)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      l10n.roundOf(_index + 1, _rounds.length),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.arabicLettersHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    ObjectScene(objectId: item.objectId, size: 150),
                    const SizedBox(height: 8),
                    Text(
                      item.wordAr,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontFamily: 'NotoNaskhArabic',
                            fontWeight: FontWeight.w700,
                            color: AppColors.royalPurple,
                          ),
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      item.wordFor(locale),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: _speakLetter,
                          icon: const Icon(Icons.record_voice_over_rounded),
                          label: Text(l10n.hearLetter),
                        ),
                        TextButton.icon(
                          onPressed: _speakWord,
                          icon: const Icon(Icons.volume_up_rounded),
                          label: Text(l10n.hearWord),
                        ),
                      ],
                    ),
                    if (_feedback != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _feedback!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: _feedback == l10n.correct
                                    ? AppColors.success
                                    : AppColors.coral,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                    const Spacer(),
                    Row(
                      children: _options.map((opt) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ElevatedButton(
                              onPressed: () => _onPick(opt),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(64, 72),
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.royalPurple,
                              ),
                              child: Text(
                                opt,
                                style: const TextStyle(
                                  fontFamily: 'NotoNaskhArabic',
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            StarBurstOverlay(visible: _showBurst),
          ],
        ),
      ),
    );
  }
}

class _LetterFxGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0x00000000);

  void pulse() {
    final star = CircleComponent(
      radius: 8,
      paint: Paint()..color = AppColors.warmGold,
      position: size / 2,
      anchor: Anchor.center,
    );
    star.add(
      SequenceEffect([
        ScaleEffect.to(Vector2.all(3), EffectController(duration: 0.35)),
        RemoveEffect(),
      ]),
    );
    world.add(star);
  }
}
