import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/map_painter.dart';
import '../../core/painters/noor_lantern_painter.dart';
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
  final _scroll = TransformationController();

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(vsync: this, duration: const Duration(seconds: 8))
      ..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(progressRepositoryProvider).markMapVisited();
    });
  }

  @override
  void dispose() {
    _anim.dispose();
    _scroll.dispose();
    super.dispose();
  }

  String _title(AppLocalizations l10n, WorldId id) => switch (id) {
        WorldId.arabic => l10n.worldArabic,
        WorldId.prayer => l10n.worldPrayer,
        WorldId.garden => l10n.worldGarden,
        WorldId.manners => l10n.worldManners,
        WorldId.quran => l10n.worldQuran,
      };

  String? _routeFor(WorldInfo world) {
    if (world.comingSoon) return null;
    return switch (world.id) {
      WorldId.arabic => '/game/arabic-path',
      WorldId.prayer => '/game/wudu',
      WorldId.garden => '/game/garden',
      WorldId.manners => '/game/manners',
      WorldId.quran => null,
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
        title: Text(
          l10n.worldMapTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 12),
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
            child: InteractiveViewer(
              transformationController: _scroll,
              minScale: 0.9,
              maxScale: 1.8,
              child: AnimatedBuilder(
                animation: _anim,
                builder: (context, _) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final w = constraints.maxWidth;
                      final h = constraints.maxHeight.clamp(420.0, 900.0);
                      return SizedBox(
                        width: w,
                        height: h,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CustomPaint(
                                painter: AdventureMapPainter(
                                  t: reduced ? 0 : _anim.value,
                                ),
                              ),
                            ),
                            Positioned(
                              left: w * 0.42,
                              top: h * 0.48,
                              child: IgnorePointer(
                                child: AnimatedNoorLantern(
                                  size: 64,
                                  reducedMotion: reduced,
                                ),
                              ),
                            ),
                            ...WorldInfo.all.map((world) {
                              final locked = !world.comingSoon &&
                                  !unlocked.contains(world.id.name);
                              return Positioned(
                                left: w * world.mapX - 44,
                                top: h * world.mapY - 44,
                                child: _IslandPin(
                                  color: Color(world.accent),
                                  locked: locked,
                                  comingSoon: world.comingSoon,
                                  selected: _selected?.id == world.id,
                                  label: _title(l10n, world.id),
                                  onTap: () {
                                    ref.read(soundManagerProvider).play(Sfx.tap);
                                    setState(() => _selected = world);
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          _DetailSheet(
            world: _selected,
            title: _selected == null ? null : _title(l10n, _selected!.id),
            hint: l10n.selectWorld,
            canPlay: _selected != null &&
                !_selected!.comingSoon &&
                unlocked.contains(_selected!.id.name),
            comingSoon: _selected?.comingSoon ?? false,
            locked: _selected != null &&
                !_selected!.comingSoon &&
                !unlocked.contains(_selected!.id.name),
            l10n: l10n,
            onPlay: () {
              final route = _selected == null ? null : _routeFor(_selected!);
              if (route != null) {
                ref.read(soundManagerProvider).play(Sfx.transition);
                context.push(route);
              }
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
            width: selected ? 88 : 76,
            height: selected ? 88 : 76,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, Color.lerp(color, Colors.white, 0.35)!],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.royalPurple : Colors.white,
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.45),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
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
              size: 34,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 110,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    shadows: const [Shadow(color: Colors.white, blurRadius: 6)],
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
    required this.hint,
    required this.canPlay,
    required this.comingSoon,
    required this.locked,
    required this.l10n,
    required this.onPlay,
  });

  final WorldInfo? world;
  final String? title;
  final String hint;
  final bool canPlay;
  final bool comingSoon;
  final bool locked;
  final AppLocalizations l10n;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
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
            title ?? hint,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.royalPurple,
                ),
          ),
          if (comingSoon) ...[
            const SizedBox(height: 8),
            Text(l10n.comingSoon, textAlign: TextAlign.center),
          ] else if (locked) ...[
            const SizedBox(height: 8),
            Text(l10n.locked, textAlign: TextAlign.center),
          ],
          if (canPlay) ...[
            const SizedBox(height: 12),
            BigKidButton(
              label: l10n.playGame,
              icon: Icons.play_arrow_rounded,
              onPressed: onPlay,
            ),
          ],
        ],
      ),
    );
  }
}
