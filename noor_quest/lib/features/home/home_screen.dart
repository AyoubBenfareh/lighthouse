import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/painters/noor_lantern_painter.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(profileProvider).value;
    final progress = ref.watch(progressProvider).value;
    final name = (profile?.displayName.isNotEmpty ?? false)
        ? profile!.displayName
        : 'Friend';
    final reduced = profile?.reducedMotion ?? false;

    return Scaffold(
      body: GeometricBackground(
        topColor: AppColors.softTurquoise,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.welcomeHome(name),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.royalPurple,
                            ),
                      ),
                    ),
                    StarsXpBar(
                      stars: progress?.stars ?? 0,
                      xp: progress?.xp ?? 0,
                    ),
                  ],
                ),
                const Spacer(),
                AnimatedNoorLantern(size: 200, reducedMotion: reduced),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    l10n.noorGreeting,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.starsAreRewards,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkText.withValues(alpha: 0.65),
                      ),
                ),
                const Spacer(),
                BigKidButton(
                  label: l10n.openMap,
                  icon: Icons.map_rounded,
                  onPressed: () => context.push('/map'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.push('/achievements'),
                        icon: const Icon(Icons.emoji_events_rounded),
                        label: Text(l10n.achievements),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => context.push('/parent-gate'),
                        icon: const Icon(Icons.family_restroom_rounded),
                        label: Text(l10n.parentArea),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
