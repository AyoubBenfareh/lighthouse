import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';
import '../../data/lessons/lesson_catalog.dart';
import '../victory/victory_screen.dart';

class MannersGameScreen extends ConsumerStatefulWidget {
  const MannersGameScreen({super.key});

  @override
  ConsumerState<MannersGameScreen> createState() => _MannersGameScreenState();
}

class _MannersGameScreenState extends ConsumerState<MannersGameScreen> {
  int _index = 0;
  int _stars = 0;
  String? _lesson;
  bool _answered = false;
  int? _picked;

  Future<void> _pick(int choice) async {
    if (_answered) return;
    final scenario = LessonCatalog.mannersScenarios[_index];
    final l10n = AppLocalizations.of(context);
    final locale = ref.read(localeProvider).languageCode;
    final correct = choice == scenario.correctIndex;
    ref.read(soundManagerProvider).play(correct ? Sfx.correct : Sfx.incorrect);
    setState(() {
      _answered = true;
      _picked = choice;
      _lesson = correct
          ? scenario.lessonFor(locale)
          : '${l10n.almost} ${scenario.lessonFor(locale)}';
      if (correct) _stars += 1;
    });
  }

  Future<void> _next() async {
    if (_index >= LessonCatalog.mannersScenarios.length - 1) {
      ref.read(soundManagerProvider).play(Sfx.celebrate);
      final result = await ref.read(progressRepositoryProvider).completeGame(
            gameId: 'good_manners',
            rewardKey: 'good_manners_v1_complete',
            starsEarned: _stars.clamp(1, 5),
            xpEarned: 35,
            badgeId: 'kind_heart',
          );
      if (!mounted) return;
      context.go(
        '/victory',
        extra: VictoryArgs(
          titleGame: 'manners',
          starsEarned: result.starsEarned,
          xpEarned: result.xpEarned,
          replayRoute: '/game/manners',
          newBadges: result.newBadges,
        ),
      );
      return;
    }
    setState(() {
      _index += 1;
      _answered = false;
      _picked = null;
      _lesson = null;
    });
  }

  IconData _sceneIcon(String id) {
    return switch (id) {
      'books' => Icons.menu_book_rounded,
      'cup' => Icons.coffee_rounded,
      'parents' => Icons.family_restroom_rounded,
      'share' => Icons.cookie_rounded,
      'clean' => Icons.cleaning_services_rounded,
      _ => Icons.favorite_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider).languageCode;
    final scenario = LessonCatalog.mannersScenarios[_index];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mannersTitle),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/map'),
        ),
      ),
      body: GeometricBackground(
        topColor: AppColors.softPink,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.roundOf(_index + 1, LessonCatalog.mannersScenarios.length),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _sceneIcon(scenario.sceneId),
                        size: 72,
                        color: AppColors.primaryViolet,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        scenario.situationFor(locale),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.mannersHint,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...List.generate(scenario.choices.length, (i) {
                  final selected = _picked == i;
                  final isCorrect = i == scenario.correctIndex;
                  Color bg = Colors.white.withValues(alpha: 0.92);
                  if (_answered && selected && isCorrect) {
                    bg = AppColors.success.withValues(alpha: 0.35);
                  } else if (_answered && selected && !isCorrect) {
                    bg = AppColors.softError.withValues(alpha: 0.3);
                  } else if (_answered && isCorrect) {
                    bg = AppColors.success.withValues(alpha: 0.2);
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      color: bg,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: _answered ? null : () => _pick(i),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          child: Text(
                            scenario.choices[i].textFor(locale),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                if (_lesson != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _lesson!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.royalPurple,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Spacer(),
                  BigKidButton(
                    label: _index >= LessonCatalog.mannersScenarios.length - 1
                        ? l10n.lessonComplete
                        : l10n.next,
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _next,
                  ),
                ] else
                  const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
