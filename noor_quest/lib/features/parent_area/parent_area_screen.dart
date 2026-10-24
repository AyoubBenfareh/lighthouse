import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
import '../../core/audio/sound_manager.dart';
import '../../core/painters/geometric_bg.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/star_burst.dart';

class ParentAreaScreen extends ConsumerWidget {
  const ParentAreaScreen({super.key});

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.parentReset),
        content: Text(l10n.parentResetConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.parentCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.parentConfirm),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(progressRepositoryProvider).resetAll();
      ref.read(soundManagerProvider).play(Sfx.unlock);
    }
  }

  Future<void> _setPin(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final ctrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.parentSetPin),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          obscureText: true,
          maxLength: 4,
          decoration: InputDecoration(hintText: l10n.parentPinHint),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.parentCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.continueLabel),
          ),
        ],
      ),
    );
    if (ok == true && ctrl.text.trim().length >= 4) {
      await ref.read(progressRepositoryProvider).setParentPin(ctrl.text.trim());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(profileProvider).value;
    final progress = ref.watch(progressProvider).value;
    final sound = ref.watch(soundManagerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.parentArea, maxLines: 1, overflow: TextOverflow.ellipsis),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            ref.read(parentUnlockedProvider.notifier).state = false;
            context.go('/home');
          },
        ),
      ),
      body: GeometricBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l10n.parentProgress,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: AppColors.royalPurple,
                  ),
            ),
            const SizedBox(height: 8),
            StarsXpBar(stars: progress?.stars ?? 0, xp: progress?.xp ?? 0),
            const SizedBox(height: 8),
            Text(
              '${l10n.completedLabel}: ${(progress?.completedGames ?? {}).isEmpty ? '—' : (progress?.completedGames ?? {}).join(', ')}',
            ),
            Text(
              '${l10n.unlockedLabel}: ${(progress?.unlockedWorlds ?? {}).join(', ')}',
            ),
            Text('${l10n.badgesLabel}: ${(progress?.badges ?? {}).length}'),
            const Divider(height: 32),
            Text(
              l10n.parentLanguage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final code in ['ar', 'de', 'en'])
                  ChoiceChip(
                    label: Text(code.toUpperCase()),
                    selected: profile?.localeCode == code,
                    onSelected: (_) =>
                        ref.read(progressRepositoryProvider).setLocale(code),
                  ),
              ],
            ),
            SwitchListTile(
              title: Text(l10n.parentAudio),
              value: profile?.audioEnabled ?? true,
              onChanged: (v) {
                sound.enabled = v;
                ref.read(progressRepositoryProvider).updatePrefs(audioEnabled: v);
              },
            ),
            ListTile(
              title: Text(l10n.parentSfxVolume),
              subtitle: Slider(
                value: profile?.sfxVolume ?? 0.8,
                onChanged: (v) {
                  sound.volume = v;
                  ref.read(progressRepositoryProvider).updatePrefs(sfxVolume: v);
                },
              ),
            ),
            SwitchListTile(
              title: Text(l10n.parentReducedMotion),
              value: profile?.reducedMotion ?? false,
              onChanged: (v) => ref
                  .read(progressRepositoryProvider)
                  .updatePrefs(reducedMotion: v),
            ),
            SwitchListTile(
              title: Text(l10n.parentReminders),
              subtitle: Text(l10n.parentRemindersHint),
              value: profile?.sessionReminders ?? false,
              onChanged: (v) => ref
                  .read(progressRepositoryProvider)
                  .updatePrefs(sessionReminders: v),
            ),
            const Divider(height: 32),
            OutlinedButton(
              onPressed: () => _setPin(context, ref),
              child: Text(l10n.parentSetPin),
            ),
            if (profile?.hasParentPin ?? false)
              TextButton(
                onPressed: () =>
                    ref.read(progressRepositoryProvider).clearParentPin(),
                child: Text(l10n.parentClearPin),
              ),
            OutlinedButton(
              onPressed: () => context.push('/premium'),
              child: Text(l10n.premiumTitle),
            ),
            const SizedBox(height: 12),
            Text(l10n.parentPrivacyNote),
            const SizedBox(height: 8),
            Text(l10n.accountScaffold),
            const SizedBox(height: 24),
            BigKidButton(
              label: l10n.parentReset,
              color: AppColors.coral,
              icon: Icons.delete_forever_rounded,
              onPressed: () => _confirmReset(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
