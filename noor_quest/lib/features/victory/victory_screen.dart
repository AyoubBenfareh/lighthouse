import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../core/painters/geometric_bg.dart';
import '../../core/painters/noor_lantern_painter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class VictoryArgs {
  const VictoryArgs({
    required this.titleGame,
    required this.starsEarned,
    required this.xpEarned,
    required this.replayRoute,
    this.newBadges = const [],
  });

  factory VictoryArgs.demo() => const VictoryArgs(
        titleGame: 'demo',
        starsEarned: 1,
        xpEarned: 10,
        replayRoute: '/map',
      );

  final String titleGame;
  final int starsEarned;
  final int xpEarned;
  final String replayRoute;
  final List<String> newBadges;
}

class VictoryScreen extends StatefulWidget {
  const VictoryScreen({super.key, required this.args});

  final VictoryArgs args;

  @override
  State<VictoryScreen> createState() => _VictoryScreenState();
}

class _VictoryScreenState extends State<VictoryScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: GeometricBackground(
        topColor: AppColors.warmGold,
        child: SafeArea(
          child: Stack(
            children: [
              const StarBurstOverlay(visible: true),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Spacer(),
                    ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _ctrl,
                        curve: Curves.elasticOut,
                      ),
                      child: const AnimatedNoorLantern(size: 160),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.victoryTitle,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: AppColors.royalPurple,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.greatJob,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      l10n.starsEarned(widget.args.starsEarned),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      l10n.xpEarned(widget.args.xpEarned),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primaryViolet,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.starsAreRewards,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    BigKidButton(
                      label: l10n.backToMap,
                      icon: Icons.map_rounded,
                      onPressed: () => context.go('/map'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => context.go(widget.args.replayRoute),
                      child: Text(l10n.playAgain),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.go('/home'),
                      child: Text(l10n.home),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
