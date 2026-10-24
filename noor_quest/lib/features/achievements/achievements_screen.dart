import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../data/lessons/lesson_catalog.dart';

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  String _label(AppLocalizations l10n, String id) {
    return switch (id) {
      'first_star' => l10n.badgeFirstStar,
      'letter_learner' => l10n.badgeLetterLearner,
      'wudu_explorer' => l10n.badgeWuduExplorer,
      'kind_heart' => l10n.badgeKindHeart,
      'map_traveler' => l10n.badgeMapTraveler,
      'star_collector' => l10n.badgeStarCollector,
      'garden_friend' => l10n.badgeGardenFriend,
      _ => id,
    };
  }

  IconData _icon(String id) {
    return switch (id) {
      'first_star' => Icons.star_rounded,
      'letter_learner' => Icons.abc_rounded,
      'wudu_explorer' => Icons.water_drop_rounded,
      'kind_heart' => Icons.favorite_rounded,
      'map_traveler' => Icons.map_rounded,
      'star_collector' => Icons.auto_awesome_rounded,
      'garden_friend' => Icons.local_florist_rounded,
      _ => Icons.emoji_events_rounded,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(progressProvider).value;
    final earned = progress?.badges ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.achievements),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: GeometricBackground(
        topColor: AppColors.warmGold,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (earned.isEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  l10n.noBadgesYet,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ...LessonCatalog.badgeIds.map((id) {
              final has = earned.contains(id);
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: has
                      ? AppColors.warmGold.withValues(alpha: 0.35)
                      : Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: has ? AppColors.warmGold : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _icon(id),
                      size: 40,
                      color: has
                          ? AppColors.royalPurple
                          : AppColors.darkText.withValues(alpha: 0.35),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _label(l10n, id),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: has
                                  ? AppColors.darkText
                                  : AppColors.darkText.withValues(alpha: 0.45),
                            ),
                      ),
                    ),
                    if (has)
                      const Icon(Icons.check_circle, color: AppColors.success),
                  ],
                ),
              );
            }),
            const SizedBox(height: 12),
            Text(
              l10n.starsAreRewards,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
