import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/avatars/avatar_painter.dart';
import '../../core/brand/logo_mark.dart';
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

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: GeometricBackground(
        topColor: AppColors.softTurquoise,
        variant: BgVariant.sky,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const LogoMark(size: 44),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.welcomeHome(name),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.royalPurple,
                            ),
                      ),
                    ),
                    if (profile != null)
                      AvatarBadge(index: profile.avatarIndex, size: 48),
                    const SizedBox(width: 8),
                    StarsXpBar(
                      stars: progress?.stars ?? 0,
                      xp: progress?.xp ?? 0,
                    ),
                  ],
                ),
                const Spacer(),
                AnimatedNoorLantern(size: 190, reducedMotion: reduced),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    l10n.noorGreeting,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 6),
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
                  onPressed: () {
                    ref.read(soundManagerProvider).play(Sfx.transition);
                    context.push('/map');
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref.read(soundManagerProvider).play(Sfx.tap);
                          context.push('/teacher');
                        },
                        icon: const Icon(Icons.school_rounded),
                        label: Text(l10n.teacherTitle, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ref.read(soundManagerProvider).play(Sfx.tap);
                          context.push('/achievements');
                        },
                        icon: const Icon(Icons.emoji_events_rounded),
                        label: Text(l10n.achievements, maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    ref.read(soundManagerProvider).play(Sfx.tap);
                    context.push('/parent-gate');
                  },
                  icon: const Icon(Icons.family_restroom_rounded),
                  label: Text(l10n.parentArea),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
