import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/avatars/avatar_catalog.dart';
import '../../core/avatars/avatar_painter.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final _nameCtrl = TextEditingController();
  int _avatar = 0;
  late final AnimationController _idle;

  @override
  void initState() {
    super.initState();
    _idle = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _idle.dispose();
    super.dispose();
  }

  String _avatarName(AppLocalizations l10n, int i) {
    return switch (AvatarDef.all[i].kind) {
      AvatarKind.explorer => l10n.avatarExplorer,
      AvatarKind.desertFox => l10n.avatarDesertFox,
      AvatarKind.bird => l10n.avatarBird,
      AvatarKind.cat => l10n.avatarCat,
      AvatarKind.starKid => l10n.avatarStarKid,
      AvatarKind.gardenExplorer => l10n.avatarGardenExplorer,
    };
  }

  Future<void> _start() async {
    ref.read(soundManagerProvider).play(Sfx.tap);
    await ref.read(progressRepositoryProvider).completeOnboarding(
          displayName: _nameCtrl.text.isEmpty ? 'Noor Friend' : _nameCtrl.text,
          avatarIndex: _avatar,
        );
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: GeometricBackground(
        variant: BgVariant.sky,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.createProfile,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.royalPurple,
                      ),
                ),
                const SizedBox(height: 8),
                Text(l10n.pickAvatar, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                AnimatedBuilder(
                  animation: _idle,
                  builder: (context, child) => Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(AvatarDef.all.length, (i) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(soundManagerProvider).play(Sfx.tap);
                          setState(() => _avatar = i);
                        },
                        child: Column(
                          children: [
                            AvatarBadge(
                              index: i,
                              selected: _avatar == i,
                              t: _idle.value,
                              size: 76,
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 84,
                              child: Text(
                                _avatarName(l10n, i),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.adventurerName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(hintText: l10n.nameHint),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.privacyNicknameOnly,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkText.withValues(alpha: 0.7),
                      ),
                ),
                const SizedBox(height: 28),
                BigKidButton(
                  label: l10n.startAdventure,
                  icon: Icons.explore_rounded,
                  onPressed: _start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
