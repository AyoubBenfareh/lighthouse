import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../victory/victory_screen.dart';

/// Gentle introduction to the five pillars — child-appropriate, not rulings.
class GardenScreen extends ConsumerStatefulWidget {
  const GardenScreen({super.key});

  @override
  ConsumerState<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends ConsumerState<GardenScreen> {
  final _found = <int>{};

  List<_Pillar> _pillars(AppLocalizations l10n) => [
        _Pillar(l10n.pillarShahada, Icons.favorite_rounded, AppColors.softPink),
        _Pillar(l10n.pillarPrayer, Icons.mosque_rounded, AppColors.softTurquoise),
        _Pillar(l10n.pillarCharity, Icons.volunteer_activism_rounded, AppColors.warmGold),
        _Pillar(l10n.pillarFasting, Icons.nightlight_round, AppColors.primaryViolet),
        _Pillar(l10n.pillarHajj, Icons.travel_explore_rounded, AppColors.leafGreen),
      ];

  Future<void> _tap(int i) async {
    ref.read(soundManagerProvider).play(Sfx.correct);
    setState(() {
      _found.add(i);
    });
    if (_found.length >= 5) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      final result = await ref.read(progressRepositoryProvider).completeGame(
            gameId: 'garden_pillars',
            rewardKey: 'garden_pillars_v1_complete',
            starsEarned: 3,
            xpEarned: 25,
            badgeId: 'garden_friend',
          );
      if (!mounted) return;
      context.go(
        '/victory',
        extra: VictoryArgs(
          titleGame: 'garden',
          starsEarned: result.starsEarned,
          xpEarned: result.xpEarned,
          replayRoute: '/game/garden',
          newBadges: result.newBadges,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pillars = _pillars(l10n);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.gardenTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/map'),
        ),
      ),
      body: GeometricBackground(
        variant: BgVariant.garden,
        topColor: AppColors.leafGreen,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  l10n.gardenHint,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.roundOf(_found.length, 5),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: pillars.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.05,
                    ),
                    itemBuilder: (context, i) {
                      final p = pillars[i];
                      final found = _found.contains(i);
                      return Material(
                        color: found
                            ? p.color.withValues(alpha: 0.45)
                            : Colors.white.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(24),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(24),
                          onTap: found ? null : () => _tap(i),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(p.icon, size: 48, color: AppColors.royalPurple),
                                const SizedBox(height: 8),
                                Text(
                                  p.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                                if (found)
                                  const Icon(Icons.check_circle, color: AppColors.success),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  l10n.starsAreRewards,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Pillar {
  const _Pillar(this.title, this.icon, this.color);
  final String title;
  final IconData icon;
  final Color color;
}
