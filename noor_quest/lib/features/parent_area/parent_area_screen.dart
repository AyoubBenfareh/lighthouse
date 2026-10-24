import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noor_quest/l10n/app_localizations.dart';

import '../../app/providers.dart';
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
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(profileProvider).value;
    final progress = ref.watch(progressProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.parentArea),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.go('/home'),
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
            StarsXpBar(
              stars: progress?.stars ?? 0,
              xp: progress?.xp ?? 0,
            ),
            const SizedBox(height: 8),
            Text(
              'Completed: ${((progress?.completedGames ?? {}).isEmpty) ? '—' : (progress?.completedGames ?? {}).join(', ')}',
            ),
            Text(
              'Unlocked: ${(progress?.unlockedWorlds ?? {}).join(', ')}',
            ),
            Text('Badges: ${(progress?.badges ?? {}).length}'),
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
              onChanged: (v) => ref
                  .read(progressRepositoryProvider)
                  .updatePrefs(audioEnabled: v),
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
            Text(
              l10n.parentExternalLinks,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.parentExternalLinks),
                    content: const Text(
                      'Parent-gated external links open only after this gate. '
                      'Example (not opened automatically in MVP): '
                      'https://www.islamicity.org\n\n'
                      'Child gameplay has no external links.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(l10n.continueLabel),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.open_in_new_rounded),
              label: const Text('Educational resource (external)'),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.parentPrivacyNote,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
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

