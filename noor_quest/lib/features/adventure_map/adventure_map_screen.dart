import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/painters/map_painter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';
import '../../data/models/world_info.dart';

class AdventureMapScreen extends ConsumerStatefulWidget {
  const AdventureMapScreen({super.key});

  @override
  ConsumerState<AdventureMapScreen> createState() => _AdventureMapScreenState();
}

class _AdventureMapScreenState extends ConsumerState<AdventureMapScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  WorldInfo? _selected;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(progressRepositoryProvider).markMapVisited();
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  String _title(AppLocalizations l10n, WorldId id) {
    return switch (id) {
      WorldId.arabic => l10n.worldArabic,
      WorldId.prayer => l10n.worldPrayer,
      WorldId.garden => l10n.worldGarden,
      WorldId.manners => l10n.worldManners,
      WorldId.quran => l10n.worldQuran,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(progressProvider).value;
    final unlocked = progress?.unlockedWorlds ?? {'arabic', 'manners'};
    final reduced = ref.watch(profileProvider).value?.reducedMotion ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.worldMapTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: StarsXpBar(
              stars: progress?.stars ?? 0,
              xp: progress?.xp ?? 0,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedBuilder(
                  animation: _anim,
                  builder: (context, _) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: AdventureMapPainter(
                              t: reduced ? 0 : _anim.value,
                            ),
                          ),
                        ),
                        ...WorldInfo.all.map((world) {
                          final locked =
                              !world.comingSoon && !unlocked.contains(world.id.name);
                          return Positioned(
                            left: constraints.maxWidth * world.mapX - 40,
                            top: constraints.maxHeight * world.mapY - 40,
                            child: _IslandPin(
                              color: Color(world.accent),
                              locked: locked,
                              comingSoon: world.comingSoon,
                              selected: _selected?.id == world.id,
                              label: _title(l10n, world.id),
                              onTap: () => setState(() => _selected = world),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          _DetailSheet(
            world: _selected,
            title: _selected == null ? null : _title(l10n, _selected!.id),
            unlocked: _selected != null &&
                (unlocked.contains(_selected!.id.name) || _selected!.comingSoon),
            l10n: l10n,
            onPlay: () {
              final route = _selected?.routeGame;
              if (route != null) context.push(route);
            },
          ),
        ],
      ),
    );
  }
}

class _IslandPin extends StatelessWidget {
  const _IslandPin({
    required this.color,
    required this.locked,
    required this.comingSoon,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final bool locked;
  final bool comingSoon;
  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: selected ? 84 : 72,
            height: selected ? 84 : 72,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.royalPurple : Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              comingSoon
                  ? Icons.hourglass_top_rounded
                  : locked
                      ? Icons.lock_rounded
                      : Icons.explore_rounded,
              color: AppColors.darkText,
              size: 32,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 100,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkText,
                    shadows: const [
                      Shadow(color: Colors.white, blurRadius: 6),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSheet extends StatelessWidget {
  const _DetailSheet({
    required this.world,
    required this.title,
    required this.unlocked,
    required this.l10n,
    required this.onPlay,
  });

  final WorldInfo? world;
  final String? title;
  final bool unlocked;
  final AppLocalizations l10n;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    if (world == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        color: Colors.white.withValues(alpha: 0.92),
        child: Text(
          l10n.worldMapTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
    }

    final canPlay = world!.playable && unlocked && !world!.comingSoon;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalPurple.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.royalPurple,
                ),
          ),
          const SizedBox(height: 8),
          if (world!.comingSoon)
            Text(
              l10n.comingSoon,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            )
          else if (!unlocked)
            Text(
              l10n.locked,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 12),
          if (canPlay)
            BigKidButton(
              label: l10n.playGame,
              icon: Icons.play_arrow_rounded,
              onPressed: onPlay,
            ),
        ],
      ),
    );
  }
}
