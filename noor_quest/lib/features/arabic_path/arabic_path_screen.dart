import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../data/lessons/lesson_catalog.dart';

/// Multi-stage Arabic pathway — first stages fully playable.
class ArabicPathScreen extends ConsumerWidget {
  const ArabicPathScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(progressProvider).value;
    final unlocked = progress?.arabicStages ?? {'stage_1'};

    final stages = [
      _Stage(
        id: 'stage_1',
        n: 1,
        letters: LessonCatalog.arabicLetters.take(3).map((e) => e.letter).join(' · '),
        route: '/game/arabic',
        unlocksNext: 'stage_2',
      ),
      _Stage(
        id: 'stage_2',
        n: 2,
        letters: LessonCatalog.arabicLetters.skip(3).take(3).map((e) => e.letter).join(' · '),
        route: '/game/arabic',
        unlocksNext: 'stage_3',
      ),
      _Stage(
        id: 'stage_3',
        n: 3,
        letters: 'د · ذ · ر',
        route: '/game/arabic',
        unlocksNext: null,
        comingSoonExtra: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.arabicPathTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/map'),
        ),
      ),
      body: GeometricBackground(
        variant: BgVariant.sky,
        topColor: AppColors.skyBlue,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l10n.arabicPathHint,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ...stages.map((stage) {
              final open = unlocked.contains(stage.id);
              final locked = !open;
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: open
                      ? Colors.white.withValues(alpha: 0.95)
                      : Colors.white.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: open ? AppColors.primaryViolet : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: open
                          ? AppColors.warmGold
                          : AppColors.darkText.withValues(alpha: 0.15),
                      child: Text(
                        '${stage.n}',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.stageLabel(stage.n),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                          Text(
                            stage.letters,
                            style: const TextStyle(
                              fontFamily: 'NotoNaskhArabic',
                              fontSize: 22,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          if (stage.comingSoonExtra)
                            Text(
                              l10n.comingSoon,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                        ],
                      ),
                    ),
                    if (locked)
                      const Icon(Icons.lock_rounded, color: AppColors.royalPurple)
                    else
                      ElevatedButton(
                        onPressed: () {
                          ref.read(soundManagerProvider).play(Sfx.tap);
                          context.push(stage.route);
                        },
                        child: Text(l10n.playGame),
                      ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                ref.read(soundManagerProvider).play(Sfx.tap);
                context.push('/game/arabic');
              },
              icon: const Icon(Icons.abc_rounded),
              label: Text(l10n.arabicLettersTitle),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stage {
  const _Stage({
    required this.id,
    required this.n,
    required this.letters,
    required this.route,
    this.unlocksNext,
    this.comingSoonExtra = false,
  });

  final String id;
  final int n;
  final String letters;
  final String route;
  final String? unlocksNext;
  final bool comingSoonExtra;
}
